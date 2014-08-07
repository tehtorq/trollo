require 'spec_helper'

describe Trollo::Board do

  it "can be labelled" do
    board = Trollo::Board.create!
    
    expect{board.add_label('Bug')}.to change{Trollo::Label.count}.by(1)
    expect{board.add_label('Bug')}.to change{Trollo::Label.count}.by(0)
    expect{board.add_label('Bug')}.to change{board.labels.count}.by(0)

    board.labels.map(&:name).should == ['Bug']
  end

  it "can have labels removed" do
    board = Trollo::Board.create!
    
    board.add_label('Bug')
    board.add_label('Tree')
    board.add_label('Foo')

    expect{board.remove_label('Bug')}.to change{Trollo::Label.count}.by(0)
    expect{board.remove_label('Tree')}.to change{board.labels.count}.by(-1)

    board.labels.map(&:name).should == ['Foo']
  end

end