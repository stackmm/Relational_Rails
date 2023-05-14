require "rails_helper"

RSpec.describe "/pharmacies/:id/edit" do
  let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: false)}

  # User Story 12
  it "displays a form to edit the pharmacy's attributes and redirects to the show page on submission" do
    visit "/pharmacies/#{pharmacy_1.id}"
    
    expect(page).to have_content("Walgreens")
    expect(page).to have_content("John Smith")
    expect(page).to have_content(9)
    expect(page).to have_content("Toronto")
    expect(page).to have_content(false)

    expect(page).to have_link("Update Pharmacy", href: "/pharmacies/#{pharmacy_1.id}/edit")
    click_link("Update Pharmacy")

    expect(page).to have_current_path("/pharmacies/#{pharmacy_1.id}/edit")
    
    fill_in("name", with: "Awesome Pharmacy")
    fill_in("pharmacist_in_charge", with: "Dr. Awesome")
    fill_in("num_employees", with: 12)
    fill_in("city", with: "Fort Collins")
    choose('true')

    click_on("Submit")

    expect(page).to have_current_path("/pharmacies/#{pharmacy_1.id}")

    expect(page).to have_content("Awesome Pharmacy")
    expect(page).to have_content("Dr. Awesome")
    expect(page).to have_content(12)
    expect(page).to have_content("Fort Collins")
    expect(page).to have_content(true)
  end
end