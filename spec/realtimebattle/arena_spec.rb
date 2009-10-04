require 'spec/spec_helper'

describe Arena do
  describe "#object_at" do
    it "should return the object at the given coordinates" do
      bullet = Bullet.new
      arena = Arena.new [bullet], 20, 20
      arena.object_at(1, 1).should == bullet
    end
    
    it "should return nil if there is no object with the given coordinates" do
      Arena.new([], 1, 1).object_at(1, 1).should be_nil
    end
  end
  
  describe '#next_obstacle' do
    before(:each) do
      @bot = Bot.new
      @bot_in_the_way = Bot.new
      @arena = Arena.new [@bot, @bot_in_the_way], 10, 4
      pos = @arena.position_for(@bot)
      pos.position = [1, 2]
      pos.direction = 0
      @pos_in_the_way = @arena.position_for(@bot_in_the_way)
    end
    
    it "should return the first object on the collision way" do
      @pos_in_the_way.position = [5, 2]
      @arena.next_obstacle(@bot).should == @bot_in_the_way
    end
    
    it "should return :wall if there is no object in the way" do
      @pos_in_the_way.position = [5, 3]
      @arena.next_obstacle(@bot).should == :wall
    end
  end
  
  describe '#step' do
    describe "bots" do
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
end