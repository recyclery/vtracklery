# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require_relative 'lib/status_seeder'
require_relative 'lib/worker_seeder'
require_relative 'lib/work_time_seeder'

puts
print "Seeding Statuses"
StatusSeeder.seed { print '.' }

print "\nSeeding Workers"
WorkerSeeder.seed # { print '.' }

print "\nSeeding WorkTimes"
WorkTimeSeeder.seed # 

puts
