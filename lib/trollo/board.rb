module Trollo

  class Board < ActiveRecord::Base
    has_and_belongs_to_many :lists
    has_many :subscriptions, dependent: :destroy
    attr_accessible :name
  end

end