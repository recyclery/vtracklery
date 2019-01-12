#!/usr/bin/env ruby
require_relative '../config/environment.rb'


workers = Worker.all
workers.each do |w|
  puts "#{w.id},#{w.name}"
end
