require "rails_helper"

RSpec.describe "/medications/:id", type: :feature do

  # User Story 4
  describe "as a visitor, when I visit /medications/:id" do
    let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}
  
    it "displays the medication associated with that ID and it's attributes" do
      visit "/medications/#{medication_1.id}"

      expect(page).to have_content(medication_1.name)
      expect(page).to have_content("Strength: #{medication_1.strength}")
      expect(page).to have_content("Dosage Form: #{medication_1.dosage_form}")
      expect(page).to have_content("Quantity: #{medication_1.quantity}")
      expect(page).to have_content("In Stock: #{medication_1.in_stock}")
      expect(page).to_not have_content(medication_2.name)
      
      visit "/medications/#{medication_2.id}"

      expect(page).to have_content(medication_2.name)
      expect(page).to have_content("Strength: #{medication_2.strength}")
      expect(page).to have_content("Dosage Form: #{medication_2.dosage_form}")
      expect(page).to have_content("Quantity: #{medication_2.quantity}")
      expect(page).to have_content("In Stock: #{medication_2.in_stock}")
      expect(page).to_not have_content(medication_1.name)
    end
  end

  # User Story 14
  describe "as a visitor, when I visit /medications/:id" do
    let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}
  
    it "displays a link to update that medication" do
      visit "/medications/#{medication_1.id}"
      expect(page).to have_content("Update Medication")
    end

    it "when I click on the link, I am taken to /medications/:id/edit" do
      visit "/medications/#{medication_1.id}"
      click_on("Update Medication")
      expect(page).to have_current_path("/medications/#{medication_1.id}/edit")
    end

    it "displays a form to edit the medication's attributes" do
      visit "/medications/#{medication_1.id}/edit"

      expect(page).to have_content("Medication")
      expect(page).to have_content("Strength")
      expect(page).to have_content("Dosage form")
      expect(page).to have_content("Quantity")
      expect(page).to have_content("In stock")
    end

    it "after I edit the attributes and submit, the medication attributes are updated and I am redirected to the show page" do
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