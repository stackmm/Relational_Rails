class Pharmacy < ApplicationRecord 
  has_many :medications

  def self.sorted_by_created
    Pharmacy.order(:created_at).reverse_order
  end
end