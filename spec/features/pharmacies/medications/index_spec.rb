require "rails_helper"

RSpec.describe "Pharmacies' medications index" do
  before :each do
    @pharmacy_1 = Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)
    @medication_1 = @pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)
    @medication_2 = @pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)
  end
  it "shows all the names of the medications for a specific pharmacy" do
    visit "/pharmacies/#{@pharmacy_1.id}/medications"

    expect(page).to have_content(@medication_1.name)
    expect(page).to have_content(@medication_2.name)
  end

  it "links to each medication's show page" do
    visit "/pharmacies/#{@pharmacy_1.id}/medications"

    click_on @medication_1.name

    expect(current_path).to eq("/medications/#{@medication_1.id}")
  end
end