# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
tables_data = (1..5).map {|i| { number: i }}
tables = Table.create(tables_data)

reservations_data = (3..25).map {|i| { table_id: 1, start_time: Time.now + (i * 2).hours, end_time: Time.now + (i * 2 + 1).hours, additional_info: "asd#{i}" }}
reservations_data += (1..40).map {|i| { table_id: 2, start_time: Time.now + (i * 3).hours, end_time: Time.now + (i * 3 + 2).hours, additional_info: "asd#{i}"  }}
reservations_data += (1..50).map {|i| { table_id: 3, start_time: Time.now + (i).hours + rand(10).minutes, end_time: Time.now + (i+ 1).hours - rand(10).minutes, additional_info: "asd#{i}"  }}
reservations = Reservation.create(reservations_data)