require "rails_helper"

RSpec.describe Medication, type: :model do
  describe "relationship" do
    it {should belong_to :pharmacy}
  end
end