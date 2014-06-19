module Trollo

  class Board < ActiveRecord::Base
    has_many :lists, order: 'ordinal ASC', dependent: :destroy
    has_many :subscriptions, dependent: :destroy
    attr_accessible :name

    def tasks
      card_ids = Trollo::Card.where(list_id: list_ids).pluck(:id)
      tasklist_ids = Trollo::Tasklist.where(card_id: card_ids).pluck(:id)
      Trollo::Task.where(tasklist_id: tasklist_ids)
    end

    def incomplete_tasks
      tasks.with_incomplete_state
    end

    def overdue_tasks
      incomplete_tasks.overdue
    end
  end

end