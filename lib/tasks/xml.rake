namespace :xml do
  desc "Get xml data from xml backup files and save to db/xml/"
  #task :dump => [:environment, :backup] do
  task :dump => :environment do
    site ||= Settings.app.url
    workers_url = "#{site}/workers.xml"
    puts "wget #{workers_url} -O db/xml/workers.xml"
    `wget #{workers_url} -O db/xml/workers.xml`

    work_times_url = "#{site}/work_times.xml"
    puts "wget #{work_times_url} -O db/xml/work_times.xml"
    `wget #{work_times_url} -O db/xml/work_times.xml`

    events_url = "#{site}/events.xml"
    puts "wget #{events_url} -O db/xml/events.xml"
    `wget #{events_url} -O db/xml/events.xml`
  end

  desc "Move files from db/xml/ to db/xml/backup"
  task :backup => :environment do
    xml_path = "#{Rails.root}/db/xml/*.xml"
    new_dir = "#{Rails.root}/db/xml/backup"
    Dir.glob(xml_path).each do |path|
      t = File.ctime(path)
      fname = File.basename(path)
      new_name = "%0.4d-%0.2d-%0.2d-%s" % [t.year, t.month, t.day, fname]
      new_path = File.join(new_dir, new_name)

      FileUtils.mv(path, new_path)
    end
  end

end
