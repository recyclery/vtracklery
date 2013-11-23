class Worker < ActiveRecord::Base
  has_many :work_times, dependent: :destroy
  belongs_to :status
  belongs_to :work_status

  validates_presence_of :name

  #MISSING_IMAGE = "/images/default_avatars/vimg01.png"
  MISSING_IMAGE = "/assets/default_avatars/vimg01.png"
  STATUS = ["Volunteer", "Member", "Paid Staff"] 

  delegate :name, to: :status, prefix: true
  def status_name=(val)
    self.status.name = val
  end
  delegate :name, to: :work_status, prefix: true
  def work_status_name=(val)
    self.work_status.name = val
  end

  # If the image name has no directory marks, assume its from the default
  def image_path
    path = (image =~ /\w+\/\w+/ ? image : "/images/default_avatars/#{image}")
    
    if image.nil?
      return MISSING_IMAGE
    else
      return File.exist?("public/system/#{path}") ? path : MISSING_IMAGE
    end
  end

  def previous
    loop do
      prev = self.id - 1
      if prev == 0
        return Worker.find(:last).id
      elsif Worker.find(prev)
        return prev
      end
    end
  end

  def next
    loop do
      prev = self.id + 1
      last_volunteer = Worker.find(:last).id
      if prev > last_volunteer
        return Worker.find(:first).id
      elsif Worker.find(prev)
        return prev
      end
    end
  end

  def has_hours?
    work_times.empty? ? false : true
  end

  def is_in_shop?
    latest_record.is_open?
  end

  def latest_record
    @sorted_hours ||= work_times.sort_by { |h| h.start_at }
    @sorted_hours[-1]
  end

  def oldest_record
    @sorted_hours ||= work_times.sort_by { |h| h.start_at }
    @sorted_hours[0]
  end

  def sum_time_in_seconds(begin_time, end_time)
    conditions = ["worker_id = ? AND start_at > ? AND start_at < ?", 
                  id, begin_time, end_time]
    time = WorkTime.find(:all, conditions: conditions)
    return time.sum(&:difference_in_seconds)
  end

  def sum_time_in_hours(begin_time, end_time)
    return sum_time_in_seconds(begin_time, end_time) / (60 * 60)
  end

  def created_datetime
    created_at.strftime("%a %b %d %Y")
  end

  def last_visit_text
    if not has_hours?
      "Has not volunteered yet"
    elsif is_in_shop? 
      "Currently in shop"
    else
      "Last visit on " + latest_record.end_date
    end
  end

  def shoehorn_name
    name.split(/\s/).map {|n| 
      n.split('-').map { |nn| 
        nn.capitalize }.join("-")}.join(" ")
  end

  def shoehorn_phone
    if out = normalize_phone
      "(#{out[0]}) #{out[1]}-#{out[2]}"
    else # Split the string in half (minus the middle char)
      n1 = normalize_phone( phone[0, phone.size/2].strip )
      n2 = normalize_phone( phone[phone.size/2 + 1, phone.size].strip )
      if n1 and n2
        "(#{n1[0]}) #{n1[1]}-#{n1[2]}" + " / " +
          "(#{n2[0]}) #{n2[1]}-#{n2[2]}" 
      else
        phone + " <b>(oops)</b>"
      end
    end

  end

  def normalize_phone(number = phone)
    case number
    when /^(\d{3})(\d{3})(\d{4})$/ # "8473281212"
      return [$1, $2, $3]
    when /^(\d{3})-(\d{3})-(\d{4})$/ # "847-328-1212"
      return [$1, $2, $3]
    when /^(\d{3})\.(\d{3})\.(\d{4})$/ # "847.328.1212"
      return [$1, $2, $3]
    when /^(\d{3})\s(\d{3})\s(\d{4})$/ # "847 328 1212"
      return [$1, $2, $3]
    when /^\((\d{3})\)\s(\d{3})-(\d{4})$/ # "(847) 328-1212"
      return [$1, $2, $3]
    when /^(\d{3})\/(\d{3})-(\d{4})$/ # "847/328-1212"
      return [$1, $2, $3]
    end
    return nil
  end

end
