module Trollo

  class Board < ActiveRecord::Base
    has_many :lists, order: 'ordinal ASC', dependent: :destroy
    has_many :subscriptions, dependent: :destroy
    attr_accessible :name

    def tasks
      task_ids = lists.map(&:cards).flatten.compact.map(&:tasklists).flatten.compact.map(&:tasks).flatten.compact.map(&:id)
      Task.where(id: task_ids)
    end

    def incomplete_tasks
      task_ids = lists.map(&:cards).flatten.compact.map(&:tasklists).flatten.compact.map(&:tasks).flatten.compact.select{|t| t.incomplete?}.map(&:id)
      Task.where(id: task_ids)
    end

    def overdue_tasks
      task_ids = lists.map(&:cards).flatten.compact.map(&:tasklists).flatten.compact.map(&:tasks).flatten.compact.select{|t| t.overdue?}.map(&:id)
      Task.where(id: task_ids)
    end
  end

end