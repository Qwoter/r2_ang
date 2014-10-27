require 'spec_helper.rb'

feature "Creating, editing, and deleting a reservation", js: true do
  scenario "CRUD a reservation" do
    visit '/#/reservations'
    click_on "New Reservation"

    fill_in "details", with: "1"

    click_on "Save"

    expect(page).to have_content("1")

    click_on "Edit"

    fill_in "details", with: "2"

    click_on "Save"

    expect(page).to have_content("2")

    visit "/#/reservations"

    click_on "2"

    click_on "Delete"

    expect(Table.where(:number => 2).first).to be_nil
  end
end