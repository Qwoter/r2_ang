class Table < ActiveRecord::Base
  has_many :reservations, dependent: :destroy
  validates :number, presence: true, uniqueness: true

  def self.get_tables_for_calendar(selected_day)
    tables_reservation = []
    Table.all.each do |table|
      reservations = table.reservations.where("table_id = ? AND start_time >= ? AND end_time <= ?", table.id, selected_day, selected_day + 1.day).order(:start_time)
      if !reservations.blank?
        result = reservations.map {|r| [r.start_time.hour, r.end_time.hour]}
      else
        result = []
      end

      tables_reservation << [table.number, result]
    end

    tables_reservation
  end
end
