module Trollo

  class Card < ActiveRecord::Base
    include Troller
    include Workflow
    acts_as_commentable

    belongs_to :list, touch: true
    has_many :tasklists, order: :ordinal, dependent: :destroy
    has_and_belongs_to_many :labels, join_table: 'trollo_cards_labels'
    before_save :set_ordinal
    attr_accessible :name, :description, :workflow_state, :trollable

    scope :due_today, lambda { where(due_at: Time.now.beginning_of_day..Time.now.end_of_day) }
    scope :overdue, lambda { where('due_at < ?', Time.now) }

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
        list.cards.length + 1
      else
        1
      end
    end

    def check
      check_due_at
    end

    def check_due_at
      self.due_at = tasklists.minimum(:due_at)
      self.save!
    end

  end

end