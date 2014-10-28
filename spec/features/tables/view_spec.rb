require 'spec_helper.rb'

feature "Navigating to tables", js: true do
  before do
    create(:table, number: '1')
    create(:table, number: '2')
    create(:table, number: '3')
    create(:table, number: '4')
    create(:table, number: '5')
  end
  
  scenario "finding tables" do
    visit '/#/Reservations'
    click_on "Tables"

    expect(page).to have_content("1")
    expect(page).to have_content("2")
    expect(page).to have_content("3")
    expect(page).to have_content("4")
    expect(page).to have_content("5")
  end
end