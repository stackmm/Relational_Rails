require "rails_helper"

RSpec.describe Pharmacy, type: :model do
  describe "relationships" do
    it {should have_many :medications}
  end

  let!(:pharmacy_1) { Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)}
  let!(:pharmacy_2) { Pharmacy.create!(name: "UCHealth", pharmacist_in_charge: "Max Anderson", num_employees: 22, city: "Denver", open_24_hours: false)}  
  let!(:pharmacy_3) { Pharmacy.create!(name: "CVS", pharmacist_in_charge: "John Lennon", num_employees: 7, city: "Fort Collins", open_24_hours: true)}
  
  describe "instance methods" do
    it "#sorted_by_created" do
      expected = [pharmacy_3, pharmacy_2, pharmacy_1]
      expect(Pharmacy.sorted_by_created).to eq(expected)
    end
  end
  
end