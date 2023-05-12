# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Pharmacy.destroy_all
Medication.destroy_all

@pharmacy_1 = Pharmacy.create!(name: "Walgreens", pharmacist_in_charge: "John Smith", num_employees: 9, city: "Toronto", open_24_hours: true)
@pharmacy_2 = Pharmacy.create!(name: "UCHealth", pharmacist_in_charge: "Max Anderson", num_employees: 22, city: "Denver", open_24_hours: false)
@pharmacy_3 = Pharmacy.create!(name: "CVS", pharmacist_in_charge: "John Lennon", num_employees: 7, city: "Fort Collins", open_24_hours: true)

@medication_1 = @pharmacy_1.medications.create!(name: "Amoxicillin", strength: "500 mg", dosage_form: "tablet", quantity: 5000, in_stock: true)
@medication_2 = @pharmacy_1.medications.create!(name: "Penicillin VK", strength: "250 mg", dosage_form: "tablet", quantity: 400, in_stock: true)

@medication_3 = @pharmacy_2.medications.create!(name: "Vancomycin", strength: "1000 mg", dosage_form: "intravenous solution", quantity: 100, in_stock: true)
@medication_4 = @pharmacy_2.medications.create!(name: "Levofloxacin", strength: "500 mg", dosage_form: "intravenous solution", quantity: 0, in_stock: false)

@medication_5 = @pharmacy_3.medications.create!(name: "Metformin", strength: "1000 mg", dosage_form: "tablet", quantity: 1200, in_stock: true)
@medication_6 = @pharmacy_3.medications.create!(name: "Lisinopril", strength: "10 mg", dosage_form: "tablet", quantity: 0, in_stock: false)
