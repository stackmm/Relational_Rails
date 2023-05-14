require "rails_helper"

RSpec.describe "/pharmacies/:id", type: :feature do
  let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
  let!(:pharmacy_2) { Pharmacy.create!(name: "UCHealth", pharmacist_in_charge: "Max Anderson", num_employees: 22, city: "Denver", open_24_hours: false)}
  let!(:medication_1) { pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
  let!(:medication_2) { pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}

  let!(:medication_3) { pharmacy_2.medications.create!(name: "Vancomycin", strength: "1000 mg", dosage_form: "intravenous solution", quantity: 100, in_stock: true)}
  let!(:medication_4) { pharmacy_2.medications.create!(name: "Levofloxacin", strength: "500 mg", dosage_form: "intravenous solution", quantity: 0, in_stock: false)}
  let!(:medication_5) { pharmacy_2.medications.create!(name: "Ondansetron", strength: "4 mg", dosage_form: "ODT", quantity: 2000, in_stock: true)}
  
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

  # User Story 7
  it "displays a count of the number of medications associated with a specific pharmacy" do
    visit "/pharmacies/#{pharmacy_1.id}"
    expect(page).to have_content("Medication Count: 2")


    visit "/pharmacies/#{pharmacy_2.id}"
    expect(page).to have_content("Medication Count: 3")
  end

  # User Story 10
  it "displays a link to that pharmacy's medications page" do
    visit "/pharmacies/#{pharmacy_1.id}"

    expect(page).to have_link("Medications", href: "/pharmacies/#{pharmacy_1.id}/medications")
  end
  
end