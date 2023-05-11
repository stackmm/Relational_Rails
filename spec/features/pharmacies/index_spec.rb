require "rails_helper"

RSpec.describe "/pharmacies (Pharmacy Index Page)", type: :feature do
  # User Story 1
  describe "as a visitor, when I visit the Pharmacy Index Page" do
    let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:pharmacy_2) { Pharmacy.create!(name: "UCHealth", pharmacist_in_charge: "Max Anderson", num_employees: 22, city: "Denver", open_24_hours: false)}
    
    it "displays the name of each Pharmacy record in the system" do
      visit "/pharmacies"
      #save_and_open_page
      expect(page).to have_content(pharmacy_1.name)
      expect(page).to have_content(pharmacy_2.name)
    end
  end
end