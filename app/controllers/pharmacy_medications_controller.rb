class PharmacyMedicationsController < ApplicationController
  def index
    @pharmacy = Pharmacy.find(params[:pharmacy_id])
    @medications = @pharmacy.medications
  end
end