class MedicationsController < ApplicationController
  def index
    @medications = Medication.all
  end

  def show
    @medications = Medication.find(params[:id])
  end

  def edit
    @medications = Medication.find(params[:id])
  end

  def update
    medication = Medication.find(params[:id])
    medication.update({
      name: params[:name],
      strength: params[:strength],
      dosage_form: params[:dosage_form],
      quantity: params[:quantity],
      in_stock: params[:in_stock]
    })
    medication.save

    redirect_to "/medications/#{medication.id}"
  end
end