require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Real Time Battle' do
  context 'bot' do
    before(:each) do
      @bot = Bot.new
      @arena = Arena.new [@bot], 10, 10
      @info = @arena.info_for(@bot)
    end
  
    it "should move around" do
      @arena.step # move
      @info.position.should == [2,1]
      @arena.step # move
      @info.position.should == [3,1]
      @arena.step # shoot
      @info.position.should == [3,1]
      @arena.step # move
      @info.position.should == [4,1]
      @arena.step # turn
      @info.position.should == [4,1]
      @arena.step # shoot
      @info.position.should == [4,1]
      @arena.step # move
      @info.position.should == [4,2]
    end
    
    context 'with bullet' do
      before :each do
        @arena.step
        @arena.step
        @arena.step
      end
      
      it "should have two objects in the arena" do
        @arena.objects.length.should == 2
      end
      
      it "should have both objects in the same position and direction" do
        one = @arena.info_for @arena.objects.first
        two = @arena.info_for @arena.objects.last
        
        one.x.should == two.x
        one.y.should == two.y
        one.direction.should == two.direction
      end
    end
  end
  
  context 'bullet' do
    before :each do
      @bullet = Bullet.new
      @arena  = Arena.new [@bullet], 10, 10
      @info   = @arena.info_for(@bullet)
    end
    
    it "should move around" do
      @arena.step
      @info.position.should == [3, 1]
      @arena.step
      @info.position.should == [5, 1]
      @arena.step
      @info.position.should == [7, 1]
    end
    
    it "should remove the bullet from play if it collides with a wall" do
      @arena.step
      @arena.step
      @arena.step
      @arena.step
      @arena.step
      @arena.info_for(@bullet).should be_nil
    end
  end
end