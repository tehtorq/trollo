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

    def set_ordinal
      self.ordinal ||= card.tasklists.length + 1
    end

    def next_task
      tasks.select(&:incomplete?).first
    end

    def check
      check_complete
      check_due_at
    end

    def check_complete
      if complete?
        undo! if tasks.any?(&:incomplete?)
      elsif incomplete?
        finish! if tasks.all?(&:complete?)
      end
    end

    def check_due_at
      self.due_at = tasks.minimum(:due_at)
      self.save!
    end

    def update_card
      card.check
    end

  end

end