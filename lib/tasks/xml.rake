#
# xml:dump, xml:backup, and xml:format tasks
#
namespace :xml do
  DATA_XML_DIR = 'db/xml'

  desc "Get data from xml builders and format it"
  task :dump => [:wget, :format]

  desc "Get xml data from xml backup files and save to db/xml/"
  task :wget => :environment do
    site = Settings.api.site

    wget_xml_file(site, "events.xml")
    wget_xml_file(site, "statuses.xml")
    wget_xml_file(site, "surveys.xml")
    wget_xml_file(site, "workers.xml")
    wget_xml_file(site, "work_times.xml")
    wget_xml_file(site, "work_statuses.xml")
  end

  def wget_xml_file(site, filename)
    url = "#{site}/backup/#{filename}"
    options = ["--no-check-certificate",
               "--http-user=#{Settings.api.login}",
               "--http-password=#{Settings.api.password}"].join(" ")
    puts "wget #{options} #{url} -O #{DATA_XML_DIR}/#{filename}"
    `wget #{options} #{url} -O #{DATA_XML_DIR}/#{filename}`
  end

  desc "Move files from db/xml/ to db/xml/backup"
  task :backup => :environment do
    xml_path = File.join(Rails.root,DATA_XML_DIR,"*.xml")
    new_dir = File.join(Rails.root,DATA_XML_DIR,"backup")
    Dir.glob(xml_path).each do |path|
      t = File.ctime(path)
      fname = File.basename(path)
      new_name = "%0.4d-%0.2d-%0.2d-%s" % [t.year, t.month, t.day, fname]
      new_path = File.join(new_dir, new_name)

      puts "mv #{path} #{new_path}"
      FileUtils.mv(path, new_path)
    end
  end

  desc "Indent xml files"
  task :format => :environment do
    xml_path = File.join(Rails.root,'db','xml','*.xml')
    tmpfile = 'db/xml/format.xml'

    Dir.glob(xml_path).each do |path|
      a, m = File.atime(path), File.mtime(path)
      `xmllint --format --recover #{path} > #{tmpfile}`
      FileUtils.mv(tmpfile, path) if File.exists?(tmpfile)
      File.utime(a, m, path)
      puts "xmllint --format --recover #{path}"
    end
  end

end
