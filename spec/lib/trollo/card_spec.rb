require 'spec_helper'

describe Trollo::Card do

  it "should support labels" do
    card = Trollo::Card.create!
    label = Trollo::Label.create! name: 'Bug'

    card.labels << label
    card.labels.map(&:name).should == ['Bug']
  end

end