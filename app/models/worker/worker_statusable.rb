#
# Convenience methods for checking {Worker} {Status}.
#
module Worker::WorkerStatusable
  extend ActiveSupport::Concern

  included do
  end

  # Class methods added to the object when {Worker::WorkerStatusable}
  # is included
  #
  module ClassMethods
    def all_member
      return where(status_id: Status.member.id)
    end

    def all_staff
      return where(status_id: Status.staff.id)
    end

    def all_volunteer
      return where(status_id: Status.volunteer.id)
    end

    def all_youth
      return where(status_id: Status.youth.id)
    end

  end

  # @return [Boolean] true if Worker has "Member" status
  def member?
    return Status::MEMBER == status.name
  end

  def member; end #virtual attribute

  # @return [Boolean] true if Worker has "Staff" status
  def staff?
    return Status::STAFF == status.name
  end

  def staff; end #virtual attribute

  # @return [Boolean] true if Worker has "Volunteer" status
  def volunteer?
    return Status::VOLUNTEER == status.name
  end

  def volunteer; end #virtual attribute

  # @return [Boolean] true if Worker has "Youth" status
  def youth?
    return Status::YOUTH == status.name
  end

  def youth; end #virtual attribute

end
