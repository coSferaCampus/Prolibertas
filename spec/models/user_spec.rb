require 'rails_helper'

RSpec.describe User, type: :model do
  context "Document" do
    it { is_expected.to be_timestamped_document }
  end

  context "Fields" do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:full_name).of_type(String) }
    it { is_expected.to have_field(:role).of_type(String) }
    it { is_expected.to have_field(:email).of_type(String) }
    it { is_expected.to have_field(:tlf).of_type(String) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_presence_of(:password).on(:create) }

    it { is_expected.to validate_confirmation_of(:password) }

    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end
end
