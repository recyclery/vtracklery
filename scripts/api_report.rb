#!/usr/bin/env ruby
require_relative 'vtrack_api'
require 'date'
#require 'time'

# Sample script for logging in through the API with an email address
email = ARGV[0] || "example@example.com"
phone = ARGV[0] || "13125551212"

raise "Emaail required" if email.nil?
raise "Phone required" if phone.nil?

puts email
vtrack = VtrackApi.new('http://vtrack.au.lan')

worker_id = vtrack.get_worker_by_phone(phone)
puts worker_id

status = vtrack.get_status(worker_id)
puts status

week = vtrack.get_current_report_week
beg_string = week["beg"]
ending_string = week["ending"]

array = []

beg = Time.new(*beg_string.split("-").map(&:to_i)).to_date
ending = Time.new(*ending_string.split("-").map(&:to_i)).to_date
(beg..ending).each do |day|
  workers = vtrack.get_day_workers(day)
  array.push [day, workers] unless workers.empty?
end

puts array.inspect
#puts Time.new.inspect
#puts Date.new.inspect
#puts Time.new(2016,10,11).inspect
