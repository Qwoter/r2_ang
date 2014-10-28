require 'rails_helper'

RSpec.describe Reservation, :type => :model do
  it "has a valid factory" do
    expect(build(:reservation)).to be_valid
  end
  
  it "presence of required fields" do
    table = create(:table, id: 1)
    expect(build(:reservation, additional_info: nil, table: table)).to_not be_valid
    expect(build(:reservation, start_time: nil, table: table)).to_not be_valid
    expect(build(:reservation, end_time: nil, table: table)).to_not be_valid
    expect(build(:reservation, table_id: nil, table: table)).to_not be_valid
  end

  it "start time can't be in past" do
    reservation = build(:reservation, start_time: Time.now - 10.hours, end_time: Time.now + 2.hours)
    expect(reservation).to_not be_valid
  end

  it "start time can't be less then end time" do
    reservation = build(:reservation, start_time: Time.now + 2.hours, end_time: Time.now + 1.hours)
    expect(reservation).to_not be_valid
  end

  it "should not intersect time with other reservation" do
    table = create(:table, id: 1)
    now = Time.now
    create(:reservation, table: table, start_time: now + 2.hour, end_time: now + 5.hours)
    reservation_contains      = build(:reservation, table: table, start_time: now + 1.hour, end_time: now + 6.hours)
    reservation_left_overlap  = build(:reservation, table: table, start_time: now + 1.hour, end_time: now + 3.hours)
    reservation_contained     = build(:reservation, table: table, start_time: now + 3.hour, end_time: now + 4.hours)
    reservation_right_overlap = build(:reservation, table: table, start_time: now + 3.hour, end_time: now + 6.hours)

    expect(reservation_contains).to_not be_valid
    expect(reservation_left_overlap).to_not be_valid
    expect(reservation_contained).to_not be_valid
    expect(reservation_right_overlap).to_not be_valid
  end
end
