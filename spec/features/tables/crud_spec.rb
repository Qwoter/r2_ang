require 'spec_helper.rb'

feature "Creating, editing, and deleting a table", js: true do
  scenario "CRUD a table" do
    visit '/#/'
    click_on "New Table"

    fill_in "number", with: "1"

    click_on "Save"

    expect(page).to have_content("1")

    click_on "Edit"

    fill_in "number", with: "2"

    click_on "Save"

    expect(page).to have_content("2")

    visit "/#/"

    click_on "2"

    click_on "Delete"

    expect(Table.where(:number => 2).first).to be_nil
  end
end