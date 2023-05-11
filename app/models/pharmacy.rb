class Pharmacy < ApplicationRecord 
  has_many :medications

  def self.sorted
    Pharmacy.order(:created_at).reverse_order
  end
end