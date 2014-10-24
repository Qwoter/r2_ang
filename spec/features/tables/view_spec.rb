require 'spec_helper.rb'

feature "Navigating to tables", js: true do
  before do
    Table.create!(number: '1')
    Table.create!(number: '2')
    Table.create!(number: '3')
    Table.create!(number: '4')
    Table.create!(number: '5')
  end
  
  scenario "finding tables" do
    visit '/'
    click_on "Tables"

    expect(page).to have_content("1")
    expect(page).to have_content("2")
    expect(page).to have_content("3")
    expect(page).to have_content("4")
    expect(page).to have_content("5")
  end
end