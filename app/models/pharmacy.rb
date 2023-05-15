class Pharmacy < ApplicationRecord 
  has_many :medications

  def self.sorted_by_created
    Pharmacy.order(:created_at).reverse_order
  end

  def count_medications
    medications.size
  end

  def sort_alphabetically(params)
    @medications = self.medications

    if params['sort']
      @medications = @medications.order(:name)
    end
    @medications
  end
  
end