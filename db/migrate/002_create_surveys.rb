class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.references :worker, index: true
      t.boolean :assist_host
      t.boolean :host_program
      t.boolean :greet_open
      t.integer :frequency
      t.boolean :tues_vol
      t.boolean :tues_open
      t.boolean :thurs_youth
      t.boolean :thurs_open
      t.boolean :fri_vol
      t.boolean :sat_sale
      t.boolean :sat_open
      t.integer :can_name_bike
      t.integer :can_fix_flat
      t.integer :can_replace_tire
      t.integer :can_replace_seat
      t.integer :can_replace_cables
      t.integer :can_adjust_brakes
      t.integer :can_adjust_derailleurs
      t.integer :can_replace_brakes
      t.integer :can_replace_shifters
      t.integer :can_remove_pedals
      t.integer :replace_crank
      t.integer :can_adjust_bearing
      t.integer :can_overhaul_hubs
      t.integer :can_overhaul_bracket
      t.integer :can_overhaul_headset
      t.integer :can_true_wheels
      t.integer :can_replace_fork
      t.boolean :assist_youth
      t.boolean :assist_tuneup
      t.boolean :assist_overhaul
      t.boolean :pickup_donations
      t.boolean :taken_tuneup
      t.boolean :taken_overhaul
      t.boolean :drive_stick
      t.boolean :have_vehicle
      t.boolean :represent_recyclery
      t.boolean :sell_ebay
      t.boolean :organize_drive
      t.boolean :organize_events
      t.boolean :skill_graphic_design
      t.boolean :skill_drawing
      t.boolean :skill_photography
      t.boolean :skill_videography
      t.boolean :skill_programming
      t.boolean :skill_grants
      t.boolean :skill_newsletter
      t.boolean :skill_carpentry
      t.boolean :skill_coordination
      t.boolean :skill_fundraising
      t.text :comment

      t.timestamps
    end
  end
end
