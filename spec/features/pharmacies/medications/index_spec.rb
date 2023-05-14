require "rails_helper"

RSpec.describe "/pharmacies/:id/medications", type: :feature do
  
  # User Story 5
  describe "As a visitor, when I visit the pharmacy medications index page" do
    let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}

    it "shows the medications associated with a specific pharmacy and their attributes" do
      visit "/pharmacies/#{pharmacy_1.id}/medications"
      
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
  
  # it "links to each medication's show page" do
  #   visit "/pharmacies/#{pharmacy_1.id}/medications"
  #   click_on medication_1.name
  #   expect(current_path).to eq("/medications/#{medication_1.id}")
  # end

  # User Story 13
  describe "As a visitor, when I visit /pharmacies/:id/medications" do
    let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}
    
    it "displays a link for a new adoptable mediction" do
      visit "/pharmacies/#{pharmacy_1.id}/medications"
      expect(page).to have_content("Add Medication")
    end

    it "when I click on the link, I am to /pharmacies/:id/medications/new" do
      visit "/pharmacies/#{pharmacy_1.id}/medications"

      click_on("Add Medication")
      expect(page).to have_current_path("/pharmacies/#{pharmacy_1.id}/medications/new")
    end

    it "displays a form to fill in with the medication's attributes" do
      visit "/pharmacies/#{pharmacy_1.id}/medications/new"
      expect(page).to have_content("Medication")
      expect(page).to have_content("Strength")
      expect(page).to have_content("Dosage Form")
      expect(page).to have_content("Quantity")
      expect(page).to have_content("In Stock:")
    end

    it "when I fill in the form and click 'Create Medication', a POST require is sent and redirected to Index page" do
      visit "/pharmacies/#{pharmacy_1.id}/medications/new"
      fill_in("name", with: "Omeprazole")
      fill_in("strength", with: "20 mg")
      fill_in("dosage_form", with: "tablet")
      fill_in("quantity", with: 0)
      choose("false")

      click_on("submit")
      
      expect(page).to have_current_path("/pharmacies/#{pharmacy_1.id}/medications")
      expect(page).to have_content("Omeprazole")
      expect(page).to have_content("20 mg")
    end
  end
  
end