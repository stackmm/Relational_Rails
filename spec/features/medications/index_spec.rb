require "rails_helper"

RSpec.describe "/medications", type: :feature do

  # User Story 3
  describe "as a visitor, when I visit /medications index page" do
    let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}
    
    it "displays each medication in the system and their attributes" do
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
  end

  # User Story 15
  describe "as a visitor, when I visit /medications index page" do
    let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}
    let!(:medication_3) {pharmacy_1.medications.create!(name: "Vancomycin", strength: "1000 mg", dosage_form: "intravenous solution", quantity: 0, in_stock: false)}
    let!(:medication_4) {pharmacy_1.medications.create!(name: "Gentamicin", strength: "400 mg", dosage_form: "intravenous solution", quantity: 25, in_stock: true)}
    let!(:medication_5) {pharmacy_1.medications.create!(name: "Amlodipine", strength: "5 mg", dosage_form: "tablet", quantity: 0, in_stock: false)}
    let!(:medication_6) {pharmacy_1.medications.create!(name: "Omeprazole", strength: "20 mg", dosage_form: "capsule", quantity: 350, in_stock: true)}

    it "displays only medications where in_stock is true" do
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

      expect(page).to have_content(medication_4.name)
      expect(page).to have_content("Strength: #{medication_4.strength}")
      expect(page).to have_content("Dosage Form: #{medication_4.dosage_form}")
      expect(page).to have_content("Quantity: #{medication_4.quantity}")
      expect(page).to have_content("In Stock: #{medication_4.in_stock}")

      expect(page).to have_content(medication_6.name)
      expect(page).to have_content("Strength: #{medication_6.strength}")
      expect(page).to have_content("Dosage Form: #{medication_6.dosage_form}")
      expect(page).to have_content("Quantity: #{medication_6.quantity}")
      expect(page).to have_content("In Stock: #{medication_6.in_stock}")

      expect(page).to_not have_content(medication_3.name)
      expect(page).to_not have_content(medication_5.name)
    end
  end

  # User Story 18
  describe "as a visitor, when I visit /medications index page" do
    let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}
    
    it "next to every medication, I see a link to edit that medication's info" do
      visit "/medications"
      expect(page).to have_content("Edit #{medication_1.name}")
      expect(page).to have_content("Edit #{medication_2.name}")
    end

    it "when I click the edit link, I am taken to /medications/:id/edit" do
      visit "/medications"
      click_on("Edit #{medication_1.name}")
      expect(current_path).to eq("/medications/#{medication_1.id}/edit")
    end

    it "when I fill out the form with updated information and click submit, /medications/:id is updated" do
      visit "/medications/#{medication_1.id}/edit"

      fill_in("name", with: "Amoxicillin")
      fill_in("strength", with: "250 mg")
      fill_in("dosage_form", with: "capsule")
      fill_in("quantity", with: 0)
      choose("false")

      click_on("Update Medication")

      expect(page).to have_current_path("/medications/#{medication_1.id}")
      expect(page).to have_content("Amoxicillin")
      expect(page).to have_content("250 mg")
      expect(page).to have_content("capsule")
      expect(page).to have_content(0)
      expect(page).to have_content(false)
    end
  end
end