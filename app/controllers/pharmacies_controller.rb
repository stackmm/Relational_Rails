class PharmaciesController < ApplicationController
  def index
    @pharmacies = Pharmacy.sorted
  end

  def show
    @pharmacies = Pharmacy.find(params[:id])
  end
end