module Trollo

  class Label < ActiveRecord::Base
    has_and_belongs_to_many :lists, join_table: 'trollo_labels_lists'
    has_and_belongs_to_many :cards, join_table: 'trollo_cards_labels'
  end

end