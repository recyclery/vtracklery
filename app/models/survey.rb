#
# An optional survey each {Worker} can fill out and update
#
class Survey < ActiveRecord::Base
  belongs_to :worker

  include XmlExtensions

  validates_presence_of :worker

  delegate :name, to: :worker, prefix: true

  # @param val [String]
  # @return [String]
  def worker_name=(val)
    self.worker = Worker.find_by(name: val) unless val.blank?
  end

  # Attributes accessible via the API
  API_ATTRIBUTES = [ :worker_id, :worker_name,
                     :assist_host, :host_program, :greet_open, :frequency,
                     :tues_vol, :tues_open, :thurs_youth, :thurs_open,
                     :fri_vol, :sat_sale, :sat_open,
                     :can_name_bike, :can_fix_flat, :can_replace_tire,
                     :can_replace_seat, :can_replace_cables,
                     :can_adjust_brakes, :can_adjust_derailleurs,
                     :can_replace_brakes, :can_replace_shifters,
                     :can_remove_pedals, :replace_crank, :can_adjust_bearing,
                     :can_overhaul_hubs, :can_overhaul_bracket,
                     :can_overhaul_headset, :can_true_wheels,
                     :can_replace_fork, :assist_youth, :assist_tuneup,
                     :assist_overhaul, :pickup_donations, :taken_tuneup,
                     :taken_overhaul, :drive_stick, :have_vehicle,
                     :represent_recyclery, :sell_ebay, :organize_drive,
                     :organize_events, :skill_graphic_design, :skill_drawing,
                     :skill_photography, :skill_videography,
                     :skill_programming, :skill_grants, :skill_newsletter,
                     :skill_carpentry, :skill_coordination, :skill_fundraising,
                     :comment ]

  # Attributes accessible via the web interface
  WEB_PARAMS = [ :worker_id, :assist_host, :host_program, :greet_open,
                 :frequency, :tues_vol, :tues_open, :thurs_youth, :thurs_open,
                 :fri_vol, :sat_sale, :sat_open, :can_name_bike, :can_fix_flat,
                 :can_replace_tire, :can_replace_seat, :can_replace_cables,
                 :can_adjust_brakes, :can_adjust_derailleurs,
                 :can_replace_brakes, :can_replace_shifters,
                 :can_remove_pedals, :replace_crank, :can_adjust_bearing,
                 :can_overhaul_hubs, :can_overhaul_bracket,
                 :can_overhaul_headset, :can_true_wheels, :can_replace_fork,
                 :assist_youth, :assist_tuneup, :assist_overhaul,
                 :pickup_donations, :taken_tuneup, :taken_overhaul,
                 :drive_stick, :have_vehicle, :represent_recyclery,
                 :sell_ebay, :organize_drive, :organize_events,
                 :skill_graphic_design, :skill_drawing, :skill_photography,
                 :skill_videography, :skill_programming, :skill_grants,
                 :skill_newsletter, :skill_carpentry, :skill_coordination,
                 :skill_fundraising, :comment ]

end
