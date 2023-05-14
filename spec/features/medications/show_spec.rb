require "rails_helper"

RSpec.describe "/medications/:id", type: :feature do
  let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
  let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
  let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}

  # User Story 4
  it "displays the medication associated with that ID including its attributes" do
    visit "/medications/#{medication_1.id}"

    expect(page).to have_content(medication_1.name)
    expect(page).to have_content("Strength: #{medication_1.strength}")
    expect(page).to have_content("Dosage Form: #{medication_1.dosage_form}")
    expect(page).to have_content("Quantity: #{medication_1.quantity}")
    expect(page).to have_content("In Stock: #{medication_1.in_stock}")

    visit "/medications/#{medication_2.id}"

    expect(page).to have_content(medication_2.name)
    expect(page).to have_content("Strength: #{medication_2.strength}")
    expect(page).to have_content("Dosage Form: #{medication_2.dosage_form}")
    expect(page).to have_content("Quantity: #{medication_2.quantity}")
    expect(page).to have_content("In Stock: #{medication_2.in_stock}")
  end
end