require 'spec/spec_helper'

describe Bot do
  describe '#speed' do
    it "should be 1" do
      Bot.new.speed.should == 1
    end
  end
  
  describe '#health' do
    it "should default to 100" do
      Bot.new.health.should == 100
    end
  end
  
  describe '#hit with a bullet' do
    it "should decrease health by given damage" do
      bot = Bot.new
      bot.hit(25)
      bot.health.should == 75
    end
  end
  
  describe "#dead?" do
    it "should return true if health is less than 0" do
      bot = Bot.new
      bot.hit(101)
      bot.should be_dead
    end
    
    it "should return true if health is zero" do
      bot = Bot.new
      bot.hit(100)
      bot.should be_dead
    end
    
    it "should return false if health is greater than 0" do
      Bot.new.should_not be_dead
    end
  end
  
  describe "#stats" do
    it "should return a hash including the bots health" do
      Bot.new.stats.should include(:health => 100)
    end
  end
end
