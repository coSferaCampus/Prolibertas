require 'rails_helper'
RSpec.describe Person, type: :model do
  context "Document" do
    it { is_expected.to be_timestamped_document }
  end
  context "Fields" do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:surname).of_type(String) }
    it { is_expected.to have_field(:origin).of_type(String) }
    it { is_expected.to have_field(:genre).of_type(Symbol) }
    it { is_expected.to have_field(:phone).of_type(String) }
    it { is_expected.to have_field(:assistance).of_type(String) }
    it { is_expected.to have_field(:home).of_type(String) }
    it { is_expected.to have_field(:family_status).of_type(String) }
    it { is_expected.to have_field(:health_status).of_type(String) }
    it { is_expected.to have_field(:birth).of_type(Date) }
    it { is_expected.to have_field(:nif).of_type(String) }
    it { is_expected.to have_field(:social_services).of_type(String) }
    it { is_expected.to have_field(:menu).of_type(String) }
    it { is_expected.to have_field(:income).of_type(String) }
    it { is_expected.to have_field(:address).of_type(String) }
    it { is_expected.to have_field(:contact_family).of_type(String) }
    it { is_expected.to have_field(:notes).of_type(String) }
  end

  context "Relations" do
    it { is_expected.to have_many(:used_services) }
  end
  
  context "Validations" do
  	it { is_expected.to validate_presence_of(:name) }
  	it { is_expected.to validate_presence_of(:surname) }
    it { is_expected.to validate_inclusion_of(:genre).to_allow([:man, :woman]) }
  end
end
