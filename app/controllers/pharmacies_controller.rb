class PharmaciesController < ApplicationController
  def index
    @pharmacies = Pharmacy.sorted_by_created
  end

  def show
    @pharmacies = Pharmacy.find(params[:id])
  end
end