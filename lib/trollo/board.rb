module Trollo

  class Board < ActiveRecord::Base
    has_many :lists, order: 'ordinal ASC', dependent: :destroy
    has_many :subscriptions, dependent: :destroy
    has_and_belongs_to_many :labels, join_table: 'trollo_boards_labels'
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

    def add_label(name)
      return if has_label?(name)
      label = Label.where(name: name).first || Label.create!(name: name)
      self.labels << label
    end

    def remove_label(name)
      self.labels -= Label.where(name: name)
    end

    def has_label?(name)
      labels.pluck(:name).include?(name)
    end
  end

end