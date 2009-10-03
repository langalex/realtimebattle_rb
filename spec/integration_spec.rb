require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'all' do
  
  before(:each) do
    @bot = Bot.new
    @arena = Arena.new [@bot], 10, 10
    @info = @arena.info_for(@bot)
  end
  
  it "should move the bot around" do
    @arena.step
    @info.position.should == [2,1]
    @arena.step
    @info.position.should == [3,1]
    @arena.step
    @info.position.should == [4,1]
    @arena.step
    @info.position.should == [5,1]
    @arena.step
    @info.position.should == [5,1]
    @arena.step
    @info.position.should == [5,2]
  end
end