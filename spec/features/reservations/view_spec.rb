require 'spec_helper.rb'

feature "Navigating to reservations", js: true do
  before do
    table = create(:table)
    create(:reservation, table: table, additional_info: 'Anny lunch', start_time: Time.now + 1.hours, end_time: Time.now + 2.hours)
    create(:reservation, table: table, additional_info: 'Henry breakfast', start_time: Time.now + 3.hours, end_time: Time.now + 4.hours)
  end

  scenario "finding reservations" do
    visit '/'
    click_on "Reservations"

    expect(page).to have_content("Anny lunch")
    expect(page).to have_content("Henry breakfast")
  end
end