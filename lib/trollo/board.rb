module Trollo

  class Board < ActiveRecord::Base
    has_many :lists, order: 'ordinal ASC', dependent: :destroy
    has_many :subscriptions, dependent: :destroy
    attr_accessible :name
  end

end