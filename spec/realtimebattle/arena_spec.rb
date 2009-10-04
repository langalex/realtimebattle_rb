require 'spec/spec_helper'

describe Arena do
  describe '#step' do
    before(:each) do
      @bot = Bot.new
      @arena = Arena.new [@bot], 20, 20
      @bot_info = @arena.position_for(@bot)
    end
  
    it "should tell each bot to act" do
      @bot.should_receive(:step).and_return([])
      @arena.step
    end
  
    it "should tell a bot about the upper wall" do
      @bot_info.position = [9, 2]
      @bot_info.direction = 90
      @bot.should_receive(:step).with(:wall, 17).and_return([])
      @arena.step
    end
   
    it "should tell a bot about the lower wall" do
      @bot_info.position = [9, 2]
      @bot_info.direction = -90
      @bot.should_receive(:step).with(:wall, 2).and_return([])
      @arena.step
    end
  
    it "should tell a bot about the left wall" do
      @bot_info.position = [9, 2]
      @bot_info.direction = -180
      @bot.should_receive(:step).with(:wall, 9).and_return([])
      @arena.step
    end
  
    it "should tell a bot about the right wall" do
      @bot_info.position = [9, 2]
      @bot_info.direction = 0
      @bot.should_receive(:step).with(:wall, 10).and_return([])
      @arena.step
    end
  
    it "should rotate a bot" do
      @bot_info.direction = 0
      @bot.stub!(:step => [:rotate, -10])
      @bot_info.should_receive(:rotate).with(-10)
      @arena.step
    end
  
    it "should move a bot" do
      @bot_info.position = [10,11]
      @bot_info.direction = 0
      @bot.stub!(:step => [:move])
      @bot_info.should_receive(:move).with(1)
      @arena.step
    end
  
    it "should not move a bot into an obstacle" do
      @bot_info.position = [18,11]
      @bot_info.direction = 0
      @bot.stub!(:step => [:move])
      @bot_info.should_not_receive(:move)
      @arena.step
    end
  end
end