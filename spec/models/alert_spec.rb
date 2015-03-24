require 'rails_helper'
RSpec.describe Alert, type: :model do
  context "Document" do
    it { is_expected.to be_timestamped_document }
  end
  context "Fields" do
    it { is_expected.to have_field(:type).of_type(Symbol) }
    it { is_expected.to have_field(:description).of_type(String) }
    it { is_expected.to have_field(:cause).of_type(String) }
    it { is_expected.to have_field(:pending).of_type(Date) }
  end

  context "Relations" do
  it { is_expected.to belong_to(:person) }
  end
  
  context "Validations" do
    it { is_expected.to validate_inclusion_of(:type).to_allow([:punishment, :warning, :advice]) }
    it { is_expected.to validate_presence_of(:pending) }
  end
end
