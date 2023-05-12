require "rails_helper"

RSpec.describe "/pharmacies", type: :feature do
  let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
  let!(:pharmacy_2) { Pharmacy.create!(name: "UCHealth", pharmacist_in_charge: "Max Anderson", num_employees: 22, city: "Denver", open_24_hours: false)}  
  let!(:pharmacy_3) { Pharmacy.create!(name: "CVS", pharmacist_in_charge: "John Lennon", num_employees: 7, city: "Fort Collins", open_24_hours: true)}
  let!(:pharmacy_4) { Pharmacy.create!(name: "Safeway", pharmacist_in_charge: "Ringo Starr", num_employees: 14, city: "Los Angeles", open_24_hours: false)}
  let!(:pharmacy_5) { Pharmacy.create!(name: "Denver Health", pharmacist_in_charge: "Dr Pepper", num_employees: 41, city: "Denver", open_24_hours: true)}
  
  # User Story 1
  it "#index displays the name of each Pharmacy record in the system" do
    visit "/pharmacies"

    expect(page).to have_content(pharmacy_1.name)
    expect(page).to have_content(pharmacy_2.name)
    expect(page).to have_content(pharmacy_3.name)
    expect(page).to have_content(pharmacy_4.name)
    expect(page).to have_content(pharmacy_5.name)
  end

  # User Story 6
  it "#index displays Pharmacy names and when created in order of most recently created" do
    visit "/pharmacies"

    expect(pharmacy_5.name).to appear_before(pharmacy_4.name)
    expect(pharmacy_4.name).to appear_before(pharmacy_3.name)
    expect(pharmacy_3.name).to appear_before(pharmacy_2.name)
    expect(pharmacy_2.name).to appear_before(pharmacy_1.name)

    #And next to each of the records I see when it was created
    expect(page).to have_content(pharmacy_1.created_at)
    expect(page).to have_content(pharmacy_2.created_at)
    expect(page).to have_content(pharmacy_3.created_at)
    expect(page).to have_content(pharmacy_4.created_at)
    expect(page).to have_content(pharmacy_5.created_at)
  end 

  # User Story 8 
  it "displays a link to the Pharmacies Index page at top of the page" do
    visit "/pharmacies"
    expect(page).to have_link("Pharmacies", href: "/pharmacies")
  end

  # User Story 9 
  it "displays a link to the Medications Index page at top of the page" do
    visit "/pharmacies"
    expect(page).to have_link("Medications", href: "/medications")
  end

end