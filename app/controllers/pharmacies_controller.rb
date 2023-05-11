class PharmaciesController < ApplicationController
  def index
    @pharmacies = Pharmacy.all
  end

  def show
    @pharmacies = Pharmacy.find(params[:id])
  end
end