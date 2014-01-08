module Trollo

  class List < ActiveRecord::Base
    include Troller

    has_many :cards, order: 'due_at ASC', dependent: :destroy
    has_many :subscriptions, dependent: :destroy
    attr_accessible :name, :trollable
  end

end