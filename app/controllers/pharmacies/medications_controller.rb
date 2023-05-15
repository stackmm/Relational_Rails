class Pharmacies::MedicationsController < ApplicationController
  def index
    @pharmacy = Pharmacy.find(params[:id])
    @medications = @pharmacy.medications
  end

  def new
    @pharmacy = Pharmacy.find(params[:id])
  end

  def create
    @pharmacy = Pharmacy.find(params[:id])

    medication = @pharmacy.medications.new({
      name: params[:name],
      strength: params[:strength],
      dosage_form: params[:dosage_form],
      quantity: params[:quantity],
      in_stock: params[:in_stock]
    })

    medication.save

    redirect_to "/pharmacies/#{@pharmacy.id}/medications"
  end
end