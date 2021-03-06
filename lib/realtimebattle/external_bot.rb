# starts an external process for a bot
# this allows us to write bot in any langugae
# the external process must wait for events via STDIN and respond via STDOUT
# the input is passed as pipe separated values terminated by \n, the out put must be a 
# string terminated by a \n as well
# for possible inputs/outputs see TestBot#step
class ExternalBot
  
  def initialize(shell_command)
    @io = IO.popen(shell_command, 'r+')
  end
  
  def step(contact_type, contact_distance)
    process_result send_command("#{contact_type}|#{contact_distance}")
  end
  
  def exit
    send_command 'exit'
  end
  
  private
  
  def process_result(result)
    res = result.strip.split('|').map{|res| convert_to_type(res)}
    if res.size == 1
      res.first
    else
      res
    end
  end
  
  def convert_to_type(result)
    if result.match(/^-?\d+$/)
      result.to_i
    else
      result.to_sym
    end
  end
  
  def send_command(command)
    @io << "#{command}\n"
    @io.flush
    res = @io.gets
    res
  end
  
end