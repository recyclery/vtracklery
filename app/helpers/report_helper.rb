module ReportHelper
  def first_day_of_week(day)
    day
  end
  
  def last_day_of_week(day)
    if day > 0
      day - 1
    else
      6
    end
  end
  
  def days_between(first, second)
    if first > second
      second + (7 - first)
    else
      second - first
    end
  end
  
  def beginning_of_week(date, start = 1)
    days_to_beg = days_between(start, date.wday)
    date - days_to_beg
  end

  def end_of_week(date, start = 1)
    days_to_beg = days_between(start, date.wday)
    date + (6 - days_to_beg)
  end
  
  def weekend?(date)
    [0, 6].include?(date.wday)
  end
end
