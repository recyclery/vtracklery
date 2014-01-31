class WorkTimeSeeder

  def self.seed
    WorkTime.load_from_xml_collection(File.read('db/xml/work_times.xml')) { print '.' }
  end

end
