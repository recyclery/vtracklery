#!/usr/bin/env ruby
require_relative 'vtrack_api'

# Sample script for logging in through the API with an email address
email = ARGV[0] || "example@example.com"
phone = ARGV[0] || "13125551212"

raise "Emaail required" if email.nil?
raise "Phone required" if phone.nil?

puts email
vtrack = VtrackApi.new('http://vtrack.au.lan')
#worker_id = vtrack.api_get_worker_by_email(email)
worker_id = vtrack.api_get_worker_by_phone(phone)
puts worker_id
#vtrack.sign_in(worker_id)
#vtrack.sign_out(worker_id)
#puts vtrack.get_phone(worker_id)
vtrack_phone = vtrack.get_email(worker_id)
puts vtrack_phone.inspect

