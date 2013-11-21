class StatusSeeder
  STATUS = ["Volunteer", "Member", "Paid Staff"]
  WORK_STATUS = ["Volunteer", "Earn-a-bike", "Paid"]

  def self.seed
    if block_given?
      STATUS.each { |stat| Status.create(:name => stat) { yield } }
      WORK_STATUS.each { |stat|  WorkStatus.create(:name => stat) { yield } }
    else
      STATUS.each { |stat| Status.create(:name => stat) }
      WORK_STATUS.each { |stat| WorkStatus.create(:name => stat) }
    end
  end

end
