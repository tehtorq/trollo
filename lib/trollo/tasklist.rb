module Trollo

  class Tasklist < ActiveRecord::Base
    include Troller
    include Workflow

    belongs_to :card, touch: true
    has_many :tasks, order: :ordinal, dependent: :destroy
    before_save :set_ordinal
    after_save :update_card
    attr_accessible :name, :workflow_state, :trollable

    workflow do
      state :complete do
        event :undo, :transitions_to => :incomplete
      end

      state :incomplete do
        event :finish, :transitions_to => :complete
      end
    end    

    def incomplete_tasks
      tasks.with_incomplete_state
    end

    def overdue_tasks
      incomplete_tasks.overdue
    end

    def set_ordinal
      self.ordinal ||= card.tasklists.length + 1
    end

    def next_task
      incomplete_tasks.first
    end

    def check
      check_complete
      check_due_at
    end

    def check_complete
      if complete?
        undo! if incomplete_tasks.any?
      elsif incomplete?
        finish! if incomplete_tasks.none?
      end
    end

    def check_due_at
      self.due_at = incomplete_tasks.minimum(:due_at)
      self.save!
    end

    def update_card
      card.check
    end

    def finish_tasks(identifier)
      if identifier
        incomplete_tasks.where(identifier: identifier).each(&:finish!)
      end
    end

    def remove_tasks(identifier)
      if identifier
        tasks.where(identifier: identifier).each(&:destroy)
      end
    end

  end

end