# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
Dir.glob("#{Rails.root}/db/lib/*_seeder.rb").each { |file| require file }

print "\nLoading statuses"
StatusSeeder.seed { print '.' }

print "\nLoading workers"
WorkerSeeder.seed { print '.' }

print "\nLoading work_times"
WorkTimeSeeder.seed { print '.' }

print "\nLoading events"
EventSeeder.seed { print '.' }

#print "\nLoading surveys"
#SurveySeeder.seed { print '.' }

print "\n"
