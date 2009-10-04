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
    @info.move
    @info.position.should == [11,10]
  end
  
  it "should move the bot to the left" do
    @info.direction = -180
    @info.move
    @info.position.should == [9,10]
  end
  
  it "should move the bot down" do
    @info.direction = -90
    @info.move
    @info.position.should == [10,9]
  end
  
  it "should move the bot up" do
    @info.direction = 90
    @info.move
    @info.position.should == [10,11]
  end
end

describe ObjectInfo, 'health' do
  it "should default to 100" do
    ObjectInfo.new.health.should == 100
  end
end

describe '#hit with a bullet' do
  it "should decrease health by given damage" do
    bot = ObjectInfo.new
    bot.hit(25)
    bot.health.should == 75
  end
end

describe "#dead?" do
  it "should return true if health is less than 0" do
    bot = ObjectInfo.new
    bot.hit(101)
    bot.should be_dead
  end
  
  it "should return true if health is zero" do
    bot = ObjectInfo.new
    bot.hit(100)
    bot.should be_dead
  end
  
  it "should return false if health is greater than 0" do
    ObjectInfo.new.should_not be_dead
  end
end

describe "#stats" do
  it "should return a hash including the bots health" do
    ObjectInfo.new.stats.should include(:health => 100)
  end
end
