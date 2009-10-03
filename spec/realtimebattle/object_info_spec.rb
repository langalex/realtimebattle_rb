require 'spec/spec_helper'

describe ObjectInfo, 'rotate' do
  before(:each) do
    @info = ObjectInfo.new
    @info.direction = 0
  end
  
  it "should add to the direction" do
    @info.rotate 10
    @info.direction.should == 10
  end
  
  it "should cap the direction at 180" do
    @info.rotate 170
    @info.rotate 20
    @info.direction.should == -170
  end
  
  it "should cap the direction at -180" do
    @info.rotate -170
    @info.rotate -20
    @info.direction.should == 170
  end
end

describe ObjectInfo, 'move' do
  before(:each) do
    @info = ObjectInfo.new
    @info.direction = 0
    @info.position = [10,10]
  end
  
  it "should move the bot to the right" do
    @info.move 1
    @info.position.should == [11,10]
  end
  
  it "should move the bot to the left" do
    @info.direction = -180
    @info.move 1
    @info.position.should == [9,10]
  end
  
  it "should move the bot down" do
    @info.direction = -90
    @info.move 1
    @info.position.should == [10,9]
  end
  
  it "should move the bot up" do
    @info.direction = 90
    @info.move 1
    @info.position.should == [10,11]
  end
end
