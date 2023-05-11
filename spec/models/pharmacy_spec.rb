require "rails_helper"

RSpec.describe Pharmacy, type: :model do
  describe "relationships" do
    it {should have_many :medications}
  end
end