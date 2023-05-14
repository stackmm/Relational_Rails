class PharmaciesController < ApplicationController
  def index
    @pharmacies = Pharmacy.sorted_by_created
  end

  def show
    @pharmacies = Pharmacy.find(params[:id])
  end

  def new
  end

  def create
    if params[:open_24_hours]
      open_hours = true
    else 
      open_hours = false
    end
    
    pharmacy = Pharmacy.new(
      name: params[:name],
      pharmacist_in_charge: params[:pharmacist_in_charge],
      num_employees: params[:num_employees],
      city: params[:city],
      open_24_hours: open_hours
      )
    pharmacy.save

    redirect_to "/pharmacies"
  end
end