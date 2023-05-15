require "rails_helper"

RSpec.describe Pharmacy, type: :model do
  describe "relationships" do
    it {should have_many :medications}
  end

  describe "instance methods" do
    let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
    let!(:pharmacy_2) { Pharmacy.create!(name: "UCHealth", pharmacist_in_charge: "Max Anderson", num_employees: 22, city: "Denver", open_24_hours: false)}  
    let!(:pharmacy_3) { Pharmacy.create!(name: "CVS", pharmacist_in_charge: "John Lennon", num_employees: 7, city: "Fort Collins", open_24_hours: true)}
    let!(:medication_1) { pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)}
    let!(:medication_2) { pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)}
    let!(:medication_3) { pharmacy_1.medications.create!(name: "Ibuprofen", strength: "800 mg", dosage_form: "tablet", quantity: 220, in_stock: true)}

    it "#sorted_by_created" do
      expect(Pharmacy.sorted_by_created).to eq([pharmacy_3, pharmacy_2, pharmacy_1])
    end

    it "#count_medications" do
      expect(pharmacy_1.count_medications).to eq(3)
    end

    it "#sort_alphabetically" do
      params = {"sort"=>"true", "controller"=>"pharmacies/medications", "action"=>"index", "id"=>"#{pharmacy_1.id}"}
      expect(pharmacy_1.sort_alphabetically(params)).to eq([medication_1,medication_3,medication_2])
    end
  end

end