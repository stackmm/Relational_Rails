require "rails_helper"

RSpec.describe "layouts", type: :feature do
  
  # User Story 8 and 9
  describe "as a visitor, when I visit any page on the site" do
    let!(:pharmacy_1) {Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:medication_1) {pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) {pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}

    # User Story 8
    it "displays a link at the top of the page to /pharmacies" do
      visit "/pharmacies"
      expect(page).to have_link("Pharmacies", href: "/pharmacies")
      click_on("Pharmacies")
      expect(page).to have_current_path("/pharmacies")

      visit "/pharmacies/#{pharmacy_1.id}/medications"
      expect(page).to have_link("Pharmacies", href: "/pharmacies")
      click_on("Pharmacies")
      expect(page).to have_current_path("/pharmacies")

      visit "/medications/#{medication_1.id}"
      expect(page).to have_link("Pharmacies", href: "/pharmacies")
      click_on("Pharmacies")
      expect(page).to have_current_path("/pharmacies")
    end
    
    # User Story 9
    it "displays a link at the top of the page to /medications" do
      visit "/pharmacies"
      expect(page).to have_link("Medications", href: "/medications")
      click_on("Medications")
      expect(page).to have_current_path("/medications")

      visit "/pharmacies/#{pharmacy_1.id}/medications"
      expect(page).to have_link("Medications", href: "/medications")
      click_on("Medications")
      expect(page).to have_current_path("/medications")

      visit "/medications/#{medication_1.id}"
      expect(page).to have_link("Medications", href: "/medications")
      click_on("Medications")
      expect(page).to have_current_path("/medications")
    end
  end

end
