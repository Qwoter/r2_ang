class AddIndexToReservations < ActiveRecord::Migration
  def change
    add_index :reservations, [:start_time, :end_time]
  end
end
