class Pharmacies::MedicationsController < ApplicationController
  def index
    @pharmacy = Pharmacy.find(params[:id])
    @medications = @pharmacy.sort_alphabetically(params)
  end

  def new
    @pharmacy = Pharmacy.find(params[:id])
  end

  def create
    @pharmacy = Pharmacy.find(params[:id])

    @pharmacy.medications.create(medication_params)
    redirect_to "/pharmacies/#{@pharmacy.id}/medications"
  end

  private
  def medication_params
    params.permit(:name, :strength, :dosage_form, :quantity, :in_stock)
  end
end