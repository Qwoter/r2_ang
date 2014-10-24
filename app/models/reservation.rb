class Reservation < ActiveRecord::Base
  belongs_to :table
  validate :cant_be_in_past, :start_time_cant_be_less_then_end_time, :reservations_cant_intersect

  def cant_be_in_past
    if self.start_time <= Time.now
      errors.add(:start_time, "can't be in past")
    end
  end

  def start_time_cant_be_less_then_end_time
    if self.start_time >= self.end_time
      errors.add(:start_time, "can't be less then end time")
    end
  end

  def reservations_cant_intersect
    if !self.table.reservations.where("start_time >= ? AND end_time <?", self.start_time, self.end_time).blank?
      errors.add(:reservation, "time can't intersect with other reservations")
    end
  end
end
