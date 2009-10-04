require 'spec/spec_helper'

describe Bullet do
  describe '#step' do
    before :each do
      @bullet = Bullet.new
    end
    
    it "should always move" do
      @bullet.step(:wall, 3).should == :move
    end
  end
  
end
