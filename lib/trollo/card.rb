module Trollo

  class Card < ActiveRecord::Base
    include Troller
    include Workflow
    acts_as_commentable

    belongs_to :list, touch: true
    has_many :tasklists, -> { order("ordinal ASC") }, dependent: :destroy
    has_and_belongs_to_many :labels, join_table: 'trollo_cards_labels'
    before_save :set_ordinal

    def self.overdue
      where('due_at < ?', Time.now)
    end

    workflow do
      state :active do
        event :archive, :transitions_to => :archived
      end

      state :archived do
        event :unarchive, :transitions_to => :active
      end
    end    

    def set_ordinal
      self.ordinal ||= if list
        list.cards.count + 1
      else
        1
      end
    end

    def tasks
      Trollo::Task.where(tasklist_id: tasklist_ids)
    end

    def incomplete_tasks
      tasks.with_incomplete_state
    end

    def overdue_tasks
      incomplete_tasks.overdue
    end

    def check
      check_due_at
      unarchive! if due_at && archived?
    end

    def check_due_at
      self.due_at = tasklists.minimum(:due_at)
      self.save!
    end

    def add_label(name)
      return if has_label?(name)
      label = Label.where(name: name).first || Label.create!(name: name)
      self.labels << label
      
      if self.list && self.list.board
        self.list.board.add_label(name)
      end
    end

    def finish_tasks(identifier)
      self.tasklists.each{|tasklist| tasklist.finish_tasks(identifier)}
    end

    def remove_tasks(identifier)
      self.tasklists.each{|tasklist| tasklist.remove_tasks(identifier)}
    end

    def remove_label(name)
      self.labels -= Label.where(name: name)
    end

    def has_label?(name)
      labels.pluck(:name).include?(name)
    end
      
  end

end