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
  end
  
  describe '#speed' do
    it "should be 2" do
      Bullet.new.speed.should == 2
    end
  end
end
