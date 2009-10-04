#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'json'
$LOAD_PATH.unshift 'lib'
require 'realtimebattle'

mime :json, "application/json"

CACHE = {}
CACHE['arena'] = nil

get '/' do
  redirect 'index.html'
end

get '/arena' do
  content_type :json
  
  CACHE['arena'] ||= Arena.new [Bot.new], 640, 480 # FIXME: keep battle field scale in the javascript part of the application
  arena = CACHE['arena']
  
  state = {
    :walls => [],
    :objects => arena.objects.map { |object|
      position_info = arena.position_for object
      {
        :x => position_info.x,
        :y => position_info.y,
        :direction => position_info.direction,
        :type => object.class.name,
        :stats => object.respond_to?(:stats) ? object.stats : {}
      }
    }
  }.to_json
  arena.step
  CACHE['arena'] = arena
  state
end