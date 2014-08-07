module Trollo

  class List < ActiveRecord::Base
    belongs_to :board
    has_many :cards, order: 'due_at ASC', dependent: :destroy
    attr_accessible :name

    def named(name)
      where(name: name).first
    end
  end

end