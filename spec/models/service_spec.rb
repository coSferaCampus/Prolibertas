require 'rails_helper'

RSpec.describe Services, type: :model do
  context "Document" do
    it { is_expected.to be_timestamped_document }
  end

  context "Fields" do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:type).of_type(Symbol) }
  end

  context "Validations" do
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

    it {
      is_expected.to validate_inclusion_of(:type).to_allow(
        [:primary, :secondary ]
      )
    }
  end
end
