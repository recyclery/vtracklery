class StatusSeeder
  STATUS = ["Volunteer", "Member", "Paid Staff"]
  WORK_STATUS = ["Volunteer", "Earn-a-bike", "Paid"]

  def self.seed
    if block_given? then basic_seed { yield }
    else basic_seed
    end
  end

  def self.basic_seed
    if block_given?
      STATUS.each { |stat| Status.create(:name => stat) { yield } }
      WORK_STATUS.each { |stat| WorkStatus.create(:name => stat) { yield } }
    else
      STATUS.each { |stat| Status.create(:name => stat) }
      WORK_STATUS.each { |stat| WorkStatus.create(:name => stat) }
    end
  end

  def self.xml_seed
    xml_text = File.read('db/xml/statuses.xml')
    unless xml_text.blank?
      if block_given? then
        Status.load_from_xml_collection(xml_text) { yield }
      else
        Status.load_from_xml_collection(xml_text)
      end
    end
  end
end

if __FILE__ == $0
  StatusSeeder.seed
end

