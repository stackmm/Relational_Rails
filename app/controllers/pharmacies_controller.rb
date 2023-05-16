class PharmaciesController < ApplicationController
  def index
    @pharmacy= Pharmacy.sorted_by_created
  end

  def show
    @pharmacy = Pharmacy.find(params[:id])
  end

  def new
  end

  def create
    Pharmacy.create(pharmacy_params)
    redirect_to "/pharmacies"
  end

  def edit
    @pharmacy = Pharmacy.find(params[:id])
  end

  def update
    pharmacy = Pharmacy.find(params[:id])
    pharmacy.update(pharmacy_params)
    redirect_to "/pharmacies/#{pharmacy.id}"
  end

  # def destroy
  #  pharmacy = Pharmacy.find(params[:id])
  # pharmacy.medications.destroy_all
  # pharmacy.destroy
  # redirect_to "/pharmacies"
  # end

  private 
    def pharmacy_params
      params.permit(:name, :pharmacist_in_charge, :num_employees, :city, :open_24_hours)
    end
end