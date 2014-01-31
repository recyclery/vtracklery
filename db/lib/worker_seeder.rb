class WorkerSeeder

  def self.seed
    Worker.load_from_xml_collection(File.read('db/xml/workers.xml')) { print '.' }
  end

end
