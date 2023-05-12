require "rails_helper"

RSpec.describe "/medications", type: :feature do
  let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
  let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
  let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}
  
  # User Story 3
  it "#index displays each Medication record in the system and the associated attributes" do
    visit "/medications"

    expect(page).to have_content(medication_1.name)
    expect(page).to have_content("Strength: #{medication_1.strength}")
    expect(page).to have_content("Dosage Form: #{medication_1.dosage_form}")
    expect(page).to have_content("Quantity: #{medication_1.quantity}")
    expect(page).to have_content("In Stock: #{medication_1.in_stock}")

    expect(page).to have_content(medication_2.name)
    expect(page).to have_content("Strength: #{medication_2.strength}")
    expect(page).to have_content("Dosage Form: #{medication_2.dosage_form}")
    expect(page).to have_content("Quantity: #{medication_2.quantity}")
    expect(page).to have_content("In Stock: #{medication_2.in_stock}")
  end

    # User Story 8 
    it "displays a link to the Pharmacies Index page at top of the page" do
      visit "/medications"
      expect(page).to have_link("Pharmacies", href: "/pharmacies")
    end
  
    # User Story 9 
    it "displays a link to the Medications Index page at top of the page" do
      visit "/medications"
      expect(page).to have_link("Medications", href: "/medications")
    end
end