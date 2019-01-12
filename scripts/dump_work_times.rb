#!/usr/bin/env ruby
require_relative '../config/environment.rb'


worktimes = WorkTime.find_since(Date.new(2015, 1, 1))
worktimes.each do |wt|
  puts "#{wt.worker_id},#{wt.start_at},#{wt.end_at},#{wt.created_at},#{wt.updated_at}"
end
