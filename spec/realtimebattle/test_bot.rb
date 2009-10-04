#!/usr/bin/env ruby

while (input = STDIN.gets) != "exit\n"
  next if input.nil?
  contact_type, contact_distance = input.strip.split('|')
  if contact_type == 'wall' && contact_distance == '0'
    puts 'move'
  else
    puts 'rotate|-10'
  end
  STDOUT.flush
end