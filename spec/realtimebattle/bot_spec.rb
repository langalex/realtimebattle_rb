require 'spec/spec_helper'

describe Bot do
  describe '#speed' do
    it "should be 1" do
      Bot.new.speed.should == 1
    end
  end
end
