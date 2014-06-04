module Trollo

  class List < ActiveRecord::Base
    belongs_to :board
    has_many :cards, order: 'due_at ASC', dependent: :destroy
    has_and_belongs_to_many :labels, join_table: 'trollo_labels_lists'
    attr_accessible :name

    def named(name)
      where(name: name).first
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
      labels.map(&:name).include?(name)
    end
  end

end