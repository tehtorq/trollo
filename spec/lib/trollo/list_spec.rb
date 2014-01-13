require 'spec_helper'

describe Trollo::List do

  it "should support labels" do
    list = Trollo::List.create!
    label = Trollo::Label.create! name: 'Bug'

    list.labels << label
    list.labels.map(&:name).should == ['Bug']
  end

end