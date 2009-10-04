require 'spec/spec_helper'

describe Bullet do
  describe '#step' do
    before :each do
      @bullet = Bullet.new
    end
    
    it "should impact contact if there is no space" do
      @bullet.step(:wall, 0).should == :impact
    end
    
    it "should impact if moving will run out space" do
      @bullet.step(:wall, 2).should == :impact
    end
    
    it "should move if there is enough space" do
      @bullet.step(:wall, 3).should == :move
    end
    
    it "should hit the obstacle if there is no space between the obstacle and the bullet" do
      @bullet.step(:bot, 0, :bot_object).should == [:hit, :bot_object]
    end
    
    it "should hit the obstacle if moving will hit the obstacle" do
      @bullet.step(:bot, 1, :bot_object).should == [:hit, :bot_object]
    end
    
    it "should move if there is enough space to the obstacle" do
      @bullet.step(:bot, 3, :bot_object).should == :move
    end
  end
  
  describe '#speed' do
    it "should be 2" do
      Bullet.new.speed.should == 2
    end
  end
  
  describe '#damage' do
    it "should be 25" do
      Bullet.new.damage.should == 25
    end
  end
end
