module Trollo

  class Task < ActiveRecord::Base
    include Troller
    include Workflow

    belongs_to :tasklist, touch: true
    before_save :set_ordinal
    after_save :update_tasklist
    after_destroy :update_tasklist
    attr_accessible :name, :group, :workflow_state, :due_at, :trollable
    serialize :data

    scope :search, lambda {|term| unless term.blank?;where("name LIKE :q", q: "%#{term}%");end;}
    scope :overdue, lambda { with_incomplete_state.where('due_at IS NOT NULL AND due_at < ?', Time.now) }

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