require "rails_helper"

RSpec.describe "/pharmacies/new", type: :feature do

  # User Story 11 (part 1)
  it "displays a link to create a new Pharmacy from the index page" do
    visit "/pharmacies"

    expect(page).to have_link("New Pharmacy", href: "/pharmacies/new")
  end

  # User Story 11 (part 2)
  it "displays a form to create a new Pharmacy and redirects to Index Page after submitting" do
    visit "/pharmacies/new"

    expect(page).to have_content("Pharmacy Name")
    expect(page).to have_content("Pharmacist")
    expect(page).to have_content("Number of Employees")
    expect(page).to have_content("City")
    expect(page).to have_content("Open 24 Hours?")

    fill_in("name", with: "Stackhouse Pharmacy")
    fill_in("pharmacist_in_charge", with: "Steven Stackhouse")
    fill_in("num_employees", with: 7)
    fill_in("city", with: "Fort Collins")
    choose('false')

    click_button("Create Pharmacy")

    expect(page).to have_content("Stackhouse Pharmacy")
    
    expect(current_path).to have_content("/pharmacies")
  end
end