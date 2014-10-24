class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :table_id
      t.datetime :start_time
      t.datetime :end_time
      t.string :additional_info

      t.timestamps
    end
  end
end
