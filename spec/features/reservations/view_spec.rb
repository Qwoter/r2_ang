require 'spec_helper.rb'

feature "Navigating to reservations", js: true do
  before do
    create(:reservation, details: 'Anny lunch')
    create(:reservation, details: 'Henry breakfast', start_time: Time.now + 3.hours, end_time: Time.now + 4.hours)
  end

  scenario "finding reservations" do
    visit '/'
    click_on "Reservations"

    expect(page).to have_content("Anny lunch")
    expect(page).to have_content("Henry breakfast")
  end
end