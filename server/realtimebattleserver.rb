#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'json'

$LOAD_PATH.unshift 'lib'
require 'realtimebattle'

mime :json, "application/json"

arena = Arena.new [Bot.new], 20, 20

Thread.new do
  while(true)
    arena.step
    $arena_json = {
      :walls => [],
      :objects => arena.objects.map { |object|
        object_info = arena.info_for object
        {
          :x => object_info.x,
          :y => object_info.y,
          :direction => object_info.direction,
          :type => object.class.name,
          :stats => object.respond_to?(:stats) ? object.stats : {}
        }
      }
    }.to_json
    sleep 0.1
  end
end

get '/' do
  redirect 'index.html'
end

get '/arena' do
  content_type :json
  $arena_json
end