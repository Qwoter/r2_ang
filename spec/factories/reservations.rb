FactoryGirl.define do
  factory :reservation do
    start_time Time.now + 2.hours
    end_time Time.now + 3.hours
    table
  end
end
