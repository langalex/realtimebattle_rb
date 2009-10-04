require 'spec/spec_helper'

describe Arena do
  describe '#step' do
    
    describe "sensors" do
      
      before(:each) do
        @bot = Bot.new
        @arena = Arena.new [@bot], 20, 20
        @bot_info = @arena.info_for(@bot)
      end
      
      it "should tell a bot about the upper wall" do
        @bot_info.position = [9, 2]
        @bot_info.direction = 90
        @bot.should_receive(:step).with(:wallelement, 17).and_return([])
        @arena.step
      end

      it "should tell a bot about the lower wall" do
        @bot_info.position = [9, 2]
        @bot_info.direction = -90
        @bot.should_receive(:step).with(:wallelement, 2).and_return([])
        @arena.step
      end

      it "should tell a bot about the left wall" do
        @bot_info.position = [9, 2]
        @bot_info.direction = -180
        @bot.should_receive(:step).with(:wallelement, 9).and_return([])
        @arena.step
      end

      it "should tell a bot about the right wall" do
        @bot_info.position = [9, 2]
        @bot_info.direction = 0
        @bot.should_receive(:step).with(:wallelement, 10).and_return([])
        @arena.step
      end
      
    end
    
    describe "movement" do
      
      before(:each) do
        @bot = Bot.new
        @arena = Arena.new [@bot], 20, 20
        @bot_info = @arena.info_for(@bot)
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
        @bot.stub!(:step => :move)
        @bot_info.should_receive(:move)
        @arena.step
      end

      it "should not move a bot into an obstacle" do
        @bot_info.position = [18,11]
        @bot_info.direction = 0
        @bot.stub!(:step => :move)
        @bot_info.should_not_receive(:move)
        @arena.step
      end
      
    end
  
    describe "cleaning up" do
      it "should remove all dead objects" do
        dead = stub('dead').as_null_object
        @arena = Arena.new [dead], 10, 10
        info = @arena.info_for(dead)
        info.stub!(:dead? => true)
        @arena.step
        @arena.info_for(dead).should be_nil
      end
      
    end
    
    
    it "should tell two object moving into each other about the collision" do
      object1 = stub('object1', :step => :move, :direction => 0, :speed => 1)
      object2 = stub('object2', :step => nil)
      arena = Arena.new [object1, object2], 20, 20
      info1 = arena.info_for(object1)
      info1.position = [1,2]
      info1.stub!(:damage => 10)
      info2 = arena.info_for(object2)
      info2.stub!(:damage => 20)
      info2.position = [2,2]
      
      info1.should_receive(:hit).with(20)
      info2.should_receive(:hit).with(10)
      
      arena.step
    end
    
  end
end