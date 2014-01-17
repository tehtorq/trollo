require 'spec_helper'

describe Trollo::Card do

  it "can be labelled" do
    card = Trollo::Card.create!
    
    expect{card.add_label('Bug')}.to change{Trollo::Label.count}.by(1)
    expect{card.add_label('Bug')}.to change{Trollo::Label.count}.by(0)
    expect{card.add_label('Bug')}.to change{card.labels.count}.by(0)

    card.labels.map(&:name).should == ['Bug']
  end

  it "can have labels removed" do
    card = Trollo::Card.create!
    
    card.add_label('Bug')
    card.add_label('Tree')
    card.add_label('Foo')

    expect{card.remove_label('Bug')}.to change{Trollo::Label.count}.by(0)
    expect{card.remove_label('Tree')}.to change{card.labels.count}.by(-1)

    card.labels.map(&:name).should == ['Foo']
  end

end