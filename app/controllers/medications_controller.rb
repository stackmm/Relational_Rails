class MedicationsController < ApplicationController
  def index
    @medications = Medication.where(in_stock: true)
  end

  def show
    @medications = Medication.find(params[:id])
  end

  def edit
    @medications = Medication.find(params[:id])
  end

  def update
    medication = Medication.find(params[:id])
    medication.update(medication_params)
    redirect_to "/medications/#{medication.id}"
  end

  private
    def medication_params
      params.permit(:name, :strength, :dosage_form, :quantity, :in_stock)
    end
end