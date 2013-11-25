module Worker::Phone
  extend ActiveSupport::Concern

  #included do
  #end

  module ClassMethods
  end

  def shoehorn_phone
    # Normalize phone will return 'nil' if there aren't 10 digits
    if out = normalize_phone
      "(#{out[0]}) #{out[1]}-#{out[2]}"
    else
      # Some people enter two phone numbers, usually separated by a stroke
      # Split the string in half (minus the middle char)
      n1 = normalize_phone( phone[0, phone.size/2].strip )
      n2 = normalize_phone( phone[phone.size/2 + 1, phone.size].strip )
      if n1 and n2 # If both are valid phone numbers
        "(#{n1[0]}) #{n1[1]}-#{n1[2]}" + " / " +
          "(#{n2[0]}) #{n2[1]}-#{n2[2]}" 
      else
        phone + " <b>(oops)</b>"
      end
    end
  end # def shoehorn_phone

  def normalize_phone(number = phone)
    case number
    when /^\s+/ # Begins with whitespace, remove whitespace and try again
      return normalize_phone($')
    when /^\((\d{3})\)\s*(\d{3})-?(\d{4})$/
      # "(847) 328-1212" "(847)328-1212" "(847)3281212" "(847) 3281212" 
      return [$1, $2, $3]
    when /^[^\d]/ # No previous match, begins with non-numeric value
      return normalize_phone($')
    when /^(\d{3})(\d{3})(\d{4})$/ # "8473281212"
      return [$1, $2, $3]
    when /^(\d{3})-(\d{3})-(\d{4})$/ # "847-328-1212"
      return [$1, $2, $3]
    when /^(\d{3})\.(\d{3})\.(\d{4})$/ # "847.328.1212"
      return [$1, $2, $3]
    when /^(\d{3})\s(\d{3})\s(\d{4})$/ # "847 328 1212"
      return [$1, $2, $3]
    when /^(\d{3})\/(\d{3})-(\d{4})$/ # "847/328-1212"
      return [$1, $2, $3]
    when /^1/ # No match but begins with '1'
      return normalize_phone($')
    end
    return nil
  end # def normalize_phone
end
