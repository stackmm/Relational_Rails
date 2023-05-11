class MedicationsController < ApplicationController
  def index
    @medications = Medication.all
  end

  def show
    @medications = Medication.find(params[:id])
  end
end