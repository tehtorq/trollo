module Trollo

  class Card < ActiveRecord::Base
    include Troller
    include Workflow

    belongs_to :list, touch: true
    has_many :tasklists, order: :ordinal, dependent: :destroy
    before_save :set_ordinal
    attr_accessible :name, :workflow_state, :trollable

    scope :due_today, lambda { where(due_at: Time.now.beginning_of_day..Time.now.end_of_day) }
    scope :overdue, lambda { where('due_at < ?', Time.now) }

    workflow do
      state :complete do
        event :undo, :transitions_to => :incomplete
      end

      state :incomplete do
        event :finish, :transitions_to => :complete
      end
    end    

    def set_ordinal
      self.ordinal ||= list.cards.length + 1
    end

    def check
      check_complete
      check_due_at
    end

    def check_complete
      if complete?
        undo! if tasklists.any?(&:incomplete?)
      elsif incomplete?
        finish! if tasklists.all?(&:complete?)
      end
    end

    def check_due_at
      self.due_at = tasklists.minimum(:due_at)
      self.save!
    end

  end

end