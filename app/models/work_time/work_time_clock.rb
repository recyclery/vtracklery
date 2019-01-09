#
# Clock methods for {WorkTime}
#
# Several of these methods may be redundant, see DateTime methods.
#
module WorkTime::WorkTimeClock
  extend ActiveSupport::Concern

  #included do
  #end

  # Class methods added to the object when {WorkTime::WorkTimeClock}
  # is included
  #
  module ClassMethods
    # @param year [Integer] default Time.now.year
    # @param month [Integer,nil]
    # @return [Hash,Integer]
    def prev(year = Time.now.year, month = nil)
      year = year.to_i
      if month &&= month.to_i
        (month == 1) ? {month: 12, year: year - 1} : 
          {month: month - 1, year: year }        
      else
        year - 1
      end
    end

    # @param year [Integer] default Time.now.year
    # @param month [Integer,nil]
    # @return [Hash,Integer]
    def next(year = Time.now.year, month = nil)
      year = year.to_i
      if month &&= month.to_i
        (month == 12) ? {month: 1, year: year + 1} : 
          {month: month + 1, year: year }        
      else
        year + 1
      end    
    end

    # @return [WorkTime] the oldest work_time in the database
    def oldest
      return order(:start_at, :id).first
    end

    # @param month [Integer] default Time.now.month
    # @param year [Integer] default Time.now.year
    # @return [DateTime]
    def start_of_month(month = Time.now.month, year = Time.now.year)
      DateTime.new(year, month)
    end

    # @param month [Integer] default Time.now.month
    # @param year [Integer] default Time.now.year
    # @return [DateTime]
    def end_of_month(month = Time.now.month, year = Time.now.year)
      if 12 == month
        end_of_year(year)
      else
        DateTime.new(year, month + 1) - 1.second
      end
    end

    # @param year [Integer] default Time.now.year
    # @return [DateTime]
    def start_of_year(year = Time.now.year)
      DateTime.new(year)
    end

    # @param year [Integer] default Time.now.year
    # @return [DateTime]
    def end_of_year(year = Time.now.year)
      DateTime.new(year + 1) - 1.second
    end

    # @param seconds [Integer]
    # @return [Integer]
    def seconds_to_minutes(seconds)
      (seconds / 60).to_i
    end

    # @param minutes [Integer]
    # @return [Integer]
    def minutes_to_hours(minutes)
      (minutes / 60).to_i
    end

  end
end
