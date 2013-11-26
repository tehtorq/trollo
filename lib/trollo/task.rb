module Trollo

  class Task < ActiveRecord::Base
    include Troller
    include Workflow

    belongs_to :tasklist, touch: true
    before_save :set_ordinal
    after_save :update_tasklist
    attr_accessible :name, :group, :workflow_state, :trollable

    workflow do
      state :incomplete do
        event :finish, :transitions_to => :complete
      end

      state :complete do
        event :undo, :transitions_to => :incomplete
      end
    end

    def set_ordinal
      self.ordinal ||= tasklist.tasks.length + 1
    end

    def overdue?
      incomplete? && due_at && (Time.now > due_at)
    end

    def update_tasklist
      tasklist.check
    end
  end

end