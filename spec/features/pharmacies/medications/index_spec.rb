require "rails_helper"

RSpec.describe "/pharmacies/:id/medications", type: :feature do
  
  #User Story 5
  describe "as a visitor, when I visit /pharmacies/:id/medications" do
    let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}

    it "displays the medications associated with that specific pharmacy and their attributes" do
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
  
  # User Story 13
  describe "as a visitor, when I visit /pharmacies/:id/medications" do
    let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}
    
    it "displays a link for a new adoptable mediction" do
      visit "/pharmacies/#{pharmacy_1.id}/medications"
      expect(page).to have_content("Add Medication")
    end

    it "when I click on the link, I am taken to /pharmacies/:id/medications/new" do
      visit "/pharmacies/#{pharmacy_1.id}/medications"
      click_on("Add Medication")
      expect(page).to have_current_path("/pharmacies/#{pharmacy_1.id}/medications/new")
    end

    it "displays a form with the medication's attributes" do
      visit "/pharmacies/#{pharmacy_1.id}/medications/new"
      expect(page).to have_content("Medication")
      expect(page).to have_content("Strength")
      expect(page).to have_content("Dosage form")
      expect(page).to have_content("Quantity")
      expect(page).to have_content("In stock")
    end

    it "when I fill in the form and click 'Create Medication', a new medication is created for that pharmacy and I am redirected to /pharmacies/:id/medications" do
      visit "/pharmacies/#{pharmacy_1.id}/medications/new"
      fill_in("name", with: "Omeprazole")
      fill_in("strength", with: "20 mg")
      fill_in("dosage_form", with: "tablet")
      fill_in("quantity", with: 0)
      choose("false")
 
      click_on("Create Medication")
      
      expect(page).to have_current_path("/pharmacies/#{pharmacy_1.id}/medications")
      expect(page).to have_content("Omeprazole")
      expect(page).to have_content("20 mg")
      expect(page).to have_content(0)
      expect(page).to have_content(false)
    end
  end
  
  # User Story 16
  describe "as a visitor, when I visit /pharmacies/:id/medications" do
    let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}
    let!(:medication_3) {pharmacy_1.medications.create!(name: "Vancomycin", strength: "1000 mg", dosage_form: "intravenous solution", quantity: 32, in_stock: true)}
    let!(:medication_4) {pharmacy_1.medications.create!(name: "Gentamicin", strength: "400 mg", dosage_form: "intravenous solution", quantity: 25, in_stock: true)}
    let!(:medication_5) {pharmacy_1.medications.create!(name: "Amlodipine", strength: "5 mg", dosage_form: "tablet", quantity: 1200, in_stock: true)}
    let!(:medication_6) {pharmacy_1.medications.create!(name: "Omeprazole", strength: "20 mg", dosage_form: "capsule", quantity: 350, in_stock: true)}

    it "displays medications NOT in alphabetical order" do
      visit "/pharmacies/#{pharmacy_1.id}/medications"

      expect(medication_1.name).to appear_before(medication_2.name)
      expect(medication_2.name).to appear_before(medication_3.name)
      expect(medication_3.name).to appear_before(medication_4.name)
      expect(medication_4.name).to appear_before(medication_5.name)
      expect(medication_5.name).to appear_before(medication_6.name)
    end

    it "displays a link to sort medications in alphabetical order" do
      visit "/pharmacies/#{pharmacy_1.id}/medications"
      expect(page).to have_content("Sort Alphabetically")
    end

    it "when I click the link, I'm taken back to /pharmacies/:id/medications where medications are listed alphabetically" do
      visit "/pharmacies/#{pharmacy_1.id}/medications"

      click_on("Sort Alphabetically")

      expect(page).to have_current_path("/pharmacies/#{pharmacy_1.id}/medications?sort=true")
      expect(medication_5.name).to appear_before(medication_1.name)
      expect(medication_1.name).to appear_before(medication_4.name)
      expect(medication_4.name).to appear_before(medication_6.name)
      expect(medication_6.name).to appear_before(medication_2.name)
      expect(medication_2.name).to appear_before(medication_3.name)
    end
  end

  # User Story 18
  describe "as a visitor, when I visit /pharmacies/:id/medications" do
    let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}
    
    it "next to every medication, I see a link to edit that medication's info" do
      visit "/pharmacies/#{pharmacy_1.id}/medications"
      expect(page).to have_content("Edit #{medication_1.name}")
      expect(page).to have_content("Edit #{medication_2.name}")
    end

    it "when I click the edit link, I am taken to /medications/:id/edit" do
      visit "/pharmacies/#{pharmacy_1.id}/medications"
      click_on("Edit #{medication_1.name}")
      expect(page).to have_current_path("/medications/#{medication_1.id}/edit")
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

  # User Story 23
  describe "as a visitor, when I visit /pharmacies/:id/medications" do
    let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}
    let!(:medication_3) {pharmacy_1.medications.create!(name: "Vancomycin", strength: "1000 mg", dosage_form: "intravenous solution", quantity: 20, in_stock: true)}
    
    it "displays a link to delete each Medication" do
      visit "/pharmacies/#{pharmacy_1.id}/medications"

      expect(page).to have_content(medication_1.name)
      expect(page).to have_content(medication_2.name)
      expect(page).to have_content(medication_3.name)
      expect(page).to have_selector(:button, "Delete #{medication_1.name}")
      expect(page).to have_selector(:button, "Delete #{medication_2.name}")
      expect(page).to have_selector(:button, "Delete #{medication_3.name}")
    end

    it "when I click delete, I am taken to /medications where I no longer see that medication" do
      visit "/pharmacies/#{pharmacy_1.id}/medications"

      click_button("Delete #{medication_1.name}")
      
      expect(page).to have_current_path("/medications")
      expect(page).to_not have_content(medication_1.name)
      expect(page).to_not have_selector(:button, "Delete #{medication_1.name}")

      expect(page).to have_content(medication_2.name)
      expect(page).to have_content(medication_3.name)
      expect(page).to have_selector(:button, "Delete #{medication_2.name}")
      expect(page).to have_selector(:button, "Delete #{medication_3.name}")
    end
  end
end