require 'spec_helper.rb'

feature "Creating, editing, and deleting a reservation", js: true do
  before do
    create(:table)
    create(:table, number: 2)
  end

  scenario "Create reservation" do
    visit '/#/reservations'

    click_on "New Reservation"

    fill_in "additional_info", with: "Cake Party!"
    select '1', :from => 'tables'
    fill_in "start_date", with: Time.now + 1.hours
    find(:xpath , '//*[@id="start_time"]/tbody/tr[2]/td[1]/input').set((Time.now + 1.hours).hour)
    find(:xpath , '//*[@id="start_time"]/tbody/tr[2]/td[3]/input').set((Time.now + 1.hours).min)
    fill_in "end_date", with: Time.now + 2.hours
    find(:xpath , '//*[@id="end_time"]/tbody/tr[2]/td[1]/input').set((Time.now + 2.hours).hour)
    find(:xpath , '//*[@id="end_time"]/tbody/tr[2]/td[3]/input').set((Time.now + 2.hours).min)

    click_on "Save"

    expect(page).to have_content("Cake Party!")

    click_on "Edit"

    fill_in "additional_info", with: "Tea Party"

    click_on "Save"

    expect(page).to have_content("Tea Party")

    visit "/#/reservations"

    click_on "Tea Party"

    click_on "Delete"

    expect(Reservation.where(:additional_info => 'Tea Party').first).to be_nil
  end
end