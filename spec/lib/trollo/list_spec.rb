require 'spec_helper'

describe Trollo::List do

  it "can be labelled" do
    list = Trollo::List.create!
    
    expect{list.add_label('Bug')}.to change{Trollo::Label.count}.by(1)
    expect{list.add_label('Bug')}.to change{Trollo::Label.count}.by(0)
    expect{list.add_label('Bug')}.to change{list.labels.count}.by(0)

    list.labels.map(&:name).should == ['Bug']
  end

  it "can have labels removed" do
    list = Trollo::List.create!
    
    list.add_label('Bug')
    list.add_label('Tree')
    list.add_label('Foo')

    expect{list.remove_label('Bug')}.to change{Trollo::Label.count}.by(0)
    expect{list.remove_label('Tree')}.to change{list.labels.count}.by(-1)

    list.labels.map(&:name).should == ['Foo']
  end

end