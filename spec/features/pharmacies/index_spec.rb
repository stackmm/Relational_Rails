require "rails_helper"

RSpec.describe "/pharmacies", type: :feature do
  
  # User Story 1
  describe "as a visitor, when I visit /pharmacies index page" do
    let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:pharmacy_2) { Pharmacy.create!(name: "UCHealth", pharmacist_in_charge: "Max Anderson", num_employees: 22, city: "Denver", open_24_hours: false)}  
    
    it "displays the name of each Pharmacy record" do
      visit "/pharmacies"

      expect(page).to have_content(pharmacy_1.name)
      expect(page).to have_content(pharmacy_2.name)
    end
  end

  # User Story 6
  describe "as a visitor, when I visit /pharmacies index page" do
    let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:pharmacy_2) { Pharmacy.create!(name: "UCHealth", pharmacist_in_charge: "Max Anderson", num_employees: 22, city: "Denver", open_24_hours: false)}  
    let!(:pharmacy_3) { Pharmacy.create!(name: "CVS", pharmacist_in_charge: "John Lennon", num_employees: 7, city: "Fort Collins", open_24_hours: true)}
    let!(:pharmacy_4) { Pharmacy.create!(name: "Safeway", pharmacist_in_charge: "Ringo Starr", num_employees: 14, city: "Los Angeles", open_24_hours: false)}
    let!(:pharmacy_5) { Pharmacy.create!(name: "Denver Health", pharmacist_in_charge: "Dr Pepper", num_employees: 41, city: "Denver", open_24_hours: true)}
    
    it "display the pharmacies in order of most recently created first" do
      visit "/pharmacies"

      expect(pharmacy_5.name).to appear_before(pharmacy_4.name)
      expect(pharmacy_4.name).to appear_before(pharmacy_3.name)
      expect(pharmacy_3.name).to appear_before(pharmacy_2.name)
      expect(pharmacy_2.name).to appear_before(pharmacy_1.name)
      
    end

    it "displays when each Pharmacy was created" do
      visit "/pharmacies"

      expect(page).to have_content(pharmacy_1.created_at)
      expect(page).to have_content(pharmacy_2.created_at)
      expect(page).to have_content(pharmacy_3.created_at)
      expect(page).to have_content(pharmacy_4.created_at)
      expect(page).to have_content(pharmacy_5.created_at)
    end
  end

  # User Story 11
  describe "as a visitor, when I visit /pharmacies index page" do
    it "displays a link to create a new Pharmacy" do
      visit "/pharmacies"
      expect(page).to_not have_content("Stackhouse Pharmacy")
      expect(page).to have_link("New Pharmacy", href: "/pharmacies/new")
    end

    it "when I click the link, I am taken to /pharmacies/new" do
      visit "/pharmacies"
      click_on("New Pharmacy")
      expect(page).to have_current_path("/pharmacies/new")
    end

    it "displays a form to create a new Pharmacy and redirects to Index Page after submitting" do
      visit "/pharmacies/new"
  
      expect(page).to have_content("Name")
      expect(page).to have_content("Pharmacist")
      expect(page).to have_content("Number of employees")
      expect(page).to have_content("City")
      expect(page).to have_content("Open 24 hours")
  
      fill_in("name", with: "Stackhouse Pharmacy")
      fill_in("pharmacist_in_charge", with: "Steven Stackhouse")
      fill_in("num_employees", with: 7)
      fill_in("city", with: "Fort Collins")
      choose("false")
      click_on("Create Pharmacy")
  
      expect(page).to have_content("Stackhouse Pharmacy")
      expect(page).to have_current_path("/pharmacies")
    end
  end

  # User Story 17
  describe "as a visitor, when I visit /pharmacies index page" do
    let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:pharmacy_2) { Pharmacy.create!(name: "UCHealth", pharmacist_in_charge: "Max Anderson", num_employees: 22, city: "Denver", open_24_hours: false)}  
    let!(:pharmacy_3) { Pharmacy.create!(name: "CVS", pharmacist_in_charge: "John Lennon", num_employees: 7, city: "Fort Collins", open_24_hours: true)}

    it "displays an edit link next to every Pharmacy" do 
      visit "/pharmacies"

      expect(page).to have_content(pharmacy_1.name)
      expect(page).to have_content("Edit #{pharmacy_1.name}")
      expect(page).to have_content(pharmacy_2.name)
      expect(page).to have_content("Edit #{pharmacy_2.name}")
      expect(page).to have_content(pharmacy_3.name)
      expect(page).to have_content("Edit #{pharmacy_3.name}")
    end

    it "when I click edit, displays the Pharmacy's edit page at /pharmacies/:id/edit" do
      visit "/pharmacies"
      click_on("Edit #{pharmacy_1.name}")
      expect(current_path).to eq("/pharmacies/#{pharmacy_1.id}/edit")
    end

    it "when I fill out the form with updated information and click submit, /pharmacies/:id is updated" do
      visit "/pharmacies/#{pharmacy_1.id}/edit"

      fill_in("name", with: "Not Walgreens")
      fill_in("pharmacist_in_charge", with: "Kim Jong Un")
      fill_in("num_employees", with: 1)
      fill_in("city", with: "Kim Jong Un")
      choose("false")
      click_on("Update Pharmacy")

      expect(page).to have_current_path("/pharmacies/#{pharmacy_1.id}")
      expect(page).to have_content("Not Walgreens")
      expect(page).to have_content("Kim Jong Un")
      expect(page).to have_content(1)
      expect(page).to have_content("Kim Jong Un")
      expect(page).to have_content(false)
    end
  end

  # User Story 22
  describe "as a visitor, when I visit /pharmacies index page" do
    let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:pharmacy_2) { Pharmacy.create!(name: "UCHealth", pharmacist_in_charge: "Max Anderson", num_employees: 22, city: "Denver", open_24_hours: false)}  
    let!(:pharmacy_3) { Pharmacy.create!(name: "CVS", pharmacist_in_charge: "John Lennon", num_employees: 7, city: "Fort Collins", open_24_hours: true)}

    it "displays a link to delete each Pharmacy" do
      visit "/pharmacies"

      expect(page).to have_content(pharmacy_1.name)
      expect(page).to have_content(pharmacy_2.name)
      expect(page).to have_content(pharmacy_3.name)
      expect(page).to have_selector(:button, "Delete #{pharmacy_1.name}")
      expect(page).to have_selector(:button, "Delete #{pharmacy_2.name}")
      expect(page).to have_selector(:button, "Delete #{pharmacy_3.name}")
    end

    it "when I click Delete, I am returned to /pharmacies and I no longer see that Pharmacy" do
      visit "/pharmacies"

      click_button("Delete #{pharmacy_1.name}")
      expect(page).to have_current_path("/pharmacies")
      expect(page).to_not have_content(pharmacy_1.name)
      expect(page).to_not have_selector(:button, "Delete #{pharmacy_1.name}")

      expect(page).to have_content(pharmacy_2.name)
      expect(page).to have_content(pharmacy_3.name)
      expect(page).to have_selector(:button, "Delete #{pharmacy_2.name}")
      expect(page).to have_selector(:button, "Delete #{pharmacy_3.name}")
    end
  end
end