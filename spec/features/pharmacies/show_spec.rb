require "rails_helper"

RSpec.describe "/pharmacies/:id", type: :feature do

  # User Story 2
  describe "as a visitor, when I visit /pharmacies/:id" do
    let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:pharmacy_2) { Pharmacy.create!(name: "UCHealth", pharmacist_in_charge: "Max Anderson", num_employees: 22, city: "Denver", open_24_hours: false)}

    it "displays the Pharmacy associated with that ID and its attributes" do
      visit "/pharmacies/#{pharmacy_1.id}"

      expect(page).to have_content(pharmacy_1.name)
      expect(page).to have_content("Pharmacist: #{pharmacy_1.pharmacist_in_charge}")
      expect(page).to have_content("Number of employees: #{pharmacy_1.num_employees}")
      expect(page).to have_content("Location: #{pharmacy_1.city}")
      expect(page).to have_content("Open 24 Hours: #{pharmacy_1.open_24_hours}")
  
      expect(page).to_not have_content(pharmacy_2.name)
      expect(page).to_not have_content(pharmacy_2.pharmacist_in_charge)
      expect(page).to_not have_content(pharmacy_2.num_employees)
      expect(page).to_not have_content(pharmacy_2.city)
      expect(page).to_not have_content(pharmacy_2.open_24_hours)
    end
  end

  # User Story 7
  describe "as a visitor, when I visit a Pharmacy's show page" do
    let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:pharmacy_2) { Pharmacy.create!(name: "UCHealth", pharmacist_in_charge: "Max Anderson", num_employees: 22, city: "Denver", open_24_hours: false)}
    let!(:medication_1) { pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) { pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}
  
    let!(:medication_3) { pharmacy_2.medications.create!(name: "Vancomycin", strength: "1000 mg", dosage_form: "intravenous solution", quantity: 100, in_stock: true)}
    let!(:medication_4) { pharmacy_2.medications.create!(name: "Levofloxacin", strength: "500 mg", dosage_form: "intravenous solution", quantity: 0, in_stock: false)}
    let!(:medication_5) { pharmacy_2.medications.create!(name: "Ondansetron", strength: "4 mg", dosage_form: "ODT", quantity: 2000, in_stock: true)}
    
    it "displays a count of the number of medications associated with that Pharmacy" do
      visit "/pharmacies/#{pharmacy_1.id}"
      expect(page).to have_content("Medication Count: #{pharmacy_1.count_medications}")


      visit "/pharmacies/#{pharmacy_2.id}"
      expect(page).to have_content("Medication Count: #{pharmacy_2.count_medications}")
    end
  end

  # User Story 10
  describe "as a visitor, when I visit a Pharmacy's show page" do
    let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) { pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) { pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}

    it "displays a link to that Pharmacy's medications page /pharmacies/:id/medications" do
      visit "/pharmacies/#{pharmacy_1.id}"
      
      expect(page).to have_content("#{pharmacy_1.name}'s Medications")
      expect(page).to have_link("Medications", href: "/pharmacies/#{pharmacy_1.id}/medications")
      click_on("#{pharmacy_1.name}'s Medications")
      expect(page).to have_current_path("/pharmacies/#{pharmacy_1.id}/medications")
    end
  end

  # User Story 12
  describe "as a visitor, when I visit a Pharmacy's show page" do
    let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: false)}
    
    it "displays a link to update the pharmacy" do
      visit "/pharmacies/#{pharmacy_1.id}"

      expect(page).to have_content("Walgreens")
      expect(page).to have_content("John Smith")
      expect(page).to have_content(9)
      expect(page).to have_content("Toronto")
      expect(page).to have_content(false)

      expect(page).to have_content("Update Pharmacy")
      expect(page).to have_link("Update Pharmacy", href: "/pharmacies/#{pharmacy_1.id}/edit")
    end

    it "when I click on Update Pharmacy, I am taken to /pharmacies/:id/edit where I see a form to edit attributes" do
      visit "/pharmacies/#{pharmacy_1.id}"

      click_link("Update Pharmacy")
      expect(page).to have_current_path("/pharmacies/#{pharmacy_1.id}/edit")
      expect(page).to have_content("Pharmacy name")
      expect(page).to have_content("Pharmacist")
      expect(page).to have_content("Number of employees")
      expect(page).to have_content("City")
      expect(page).to have_content("Open 24 hours")
    end

    it "when I fill out the form and click submit, then that Pharmacy's info is updated and I am redirect to it's show page" do
      visit "/pharmacies/#{pharmacy_1.id}/edit"

      fill_in("name", with: "Awesome Pharmacy")
      fill_in("pharmacist_in_charge", with: "Dr. Awesome")
      fill_in("num_employees", with: 12)
      fill_in("city", with: "Fort Collins")
      choose('true')
      click_on("Update Pharmacy")

      expect(page).to have_current_path("/pharmacies/#{pharmacy_1.id}")
      expect(page).to have_content("Awesome Pharmacy")
      expect(page).to have_content("Dr. Awesome")
      expect(page).to have_content(12)
      expect(page).to have_content("Fort Collins")
      expect(page).to have_content(true)
    end
  end

end