#!/usr/bin/env ruby

while (input = STDIN.gets) != "exit\n"
  next if input.nil?
  contact_type, contact_distance = input.strip.split('|')
  STDOUT.puts "got #{contact_type} and #{contact_distance}"
  STDOUT.flush
end