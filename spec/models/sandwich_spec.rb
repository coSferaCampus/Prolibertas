require 'rails_helper'
RSpec.describe Sandwich, type: :model do

  context "Fields" do
    it { is_expected.to have_field(:created_at).of_type(Date) }
    it { is_expected.to have_field(:amount).of_type(Integer) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:created_at) }
    it { is_expected.to validate_presence_of(:amount) }
  end
end
