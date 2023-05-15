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
    pharmacy = Pharmacy.new(
      name: params[:name],
      pharmacist_in_charge: params[:pharmacist_in_charge],
      num_employees: params[:num_employees],
      city: params[:city],
      open_24_hours: params[:open_24_hours]
      )

    pharmacy.save

    redirect_to "/pharmacies"
  end

  def edit
    @pharmacy = Pharmacy.find(params[:id])
  end

  def update
    pharmacy = Pharmacy.find(params[:id])

    pharmacy.update({
      name: params[:name],
      pharmacist_in_charge: params[:pharmacist_in_charge],
      num_employees: params[:num_employees],
      city: params[:city],
      open_24_hours: params[:open_24_hours]
    })
    pharmacy.save

    redirect_to "/pharmacies/#{pharmacy.id}"
  end
end