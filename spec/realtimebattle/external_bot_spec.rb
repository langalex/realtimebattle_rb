require 'spec/spec_helper'

describe ExternalBot, 'step' do
  after(:each) do
    @bot.exit if @bot
  end
  
  it "should return the external process' reaction as a symbol" do
    @bot = ExternalBot.new('ruby ' + File.dirname(__FILE__) + '/test_bot.rb')
    @bot.step(:wall, 10).should == :'got wall and 10'
  end
end
