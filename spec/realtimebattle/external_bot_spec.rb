require 'spec/spec_helper'

describe ExternalBot, 'step' do
  after(:each) do
    @bot.exit if @bot
  end
  
  it "should return the external process' reaction as a symbol" do
    @bot = ExternalBot.new('ruby ' + File.dirname(__FILE__) + '/test_bot.rb')
    @bot.step(:wall, 0).should == :move
  end
  
  it "should return pipe separated values as array" do
    @bot = ExternalBot.new('ruby ' + File.dirname(__FILE__) + '/test_bot.rb')
    @bot.step(:wall, 1).should == [:rotate, -10]
  end
end
