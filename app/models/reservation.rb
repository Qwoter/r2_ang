class Reservation < ActiveRecord::Base
  belongs_to :table
  validates :table_id, :start_time, :end_time, :additional_info, presence: true
  validate :cant_be_in_past, :start_time_cant_be_less_then_end_time, :reservations_cant_intersect, :if => :object_valid?

  def cant_be_in_past
    if start_time <= Time.now
      errors.add(:start_time, "can't be in past")
    end
  end

  def start_time_cant_be_less_then_end_time
    if start_time >= end_time
      errors.add(:start_time, "can't be less then end time")
    end
  end

  def reservations_cant_intersect
    if !table.reservations.where("id <> ? AND table_id =? AND start_time >= ? AND end_time <?", id, table_id, start_time, end_time).blank?
      errors.add(:reservation, "time can't intersect with other reservations")
    end
  end

  def table_number
    table.number
  end

  private
    # Check for validations
    def object_valid?
      errors.blank?
    end
end
