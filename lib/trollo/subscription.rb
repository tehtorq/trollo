module Trollo

  class Subscription < ActiveRecord::Base
    belongs_to :board
    belongs_to :subscriber, polymorphic: true
  end

end