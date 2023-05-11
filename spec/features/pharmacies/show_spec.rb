require "rails_helper"

RSpec.describe "/pharmacies/:id", types: :feature do
  let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
  let!(:pharmacy_2) { Pharmacy.create!(name: "UCHealth", pharmacist_in_charge: "Max Anderson", num_employees: 22, city: "Denver", open_24_hours: false)}
  
  # User Story 2
  it "displays the pharmacy associated with that ID including the pharmacy's attributes" do
    visit "/pharmacies/#{pharmacy_1.id}"

    expect(page).to have_content(pharmacy_1.name)
    expect(page).to have_content(pharmacy_1.pharmacist_in_charge)
    expect(page).to have_content(pharmacy_1.num_employees)
    expect(page).to have_content(pharmacy_1.city)
    expect(page).to have_content(pharmacy_1.open_24_hours)

    visit "/pharmacies/#{pharmacy_2.id}"

    expect(page).to have_content(pharmacy_2.name)
    expect(page).to have_content(pharmacy_2.pharmacist_in_charge)
    expect(page).to have_content(pharmacy_2.num_employees)
    expect(page).to have_content(pharmacy_2.city)
    expect(page).to have_content(pharmacy_2.open_24_hours)
  end
end