class Table < ActiveRecord::Base
  has_many :reservations, dependent: :destroy
  validates :number, presence: true, uniqueness: true

  def self.get_tables_for_calendar(selected_day)
    tables_reservation = []
    Table.all.each do |table|
      reservations = table.reservations.where("table_id = ? AND start_time >= ? AND start_time <= ?", table.id, selected_day, selected_day + 1.day).order(:start_time)
      if !reservations.blank?
        result = reservations.map { |r|
          start_time_raw = r.start_time.in_time_zone('Europe/Kiev')
          end_time_raw = r.end_time.in_time_zone('Europe/Kiev')

          if start_time_raw.day < end_time_raw.day
            end_time = 24 * 60 / 2
          else 
            end_time = (end_time_raw.hour * 60 + end_time_raw.min)/2
          end

          start_time = (start_time_raw.hour * 60 + start_time_raw.min)/2

          [start_time, end_time, r.additional_info, start_time_raw, end_time_raw]
        }
      else
        result = []
      end

      tables_reservation << [table.number, result] if !result.blank?
    end

    tables_reservation
  end
end
