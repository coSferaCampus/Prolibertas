require 'rails_helper'

RSpec.describe User, type: :model do
  context "Document" do
    it { is_expected.to be_timestamped_document }
  end

  context "Fields" do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:full_name).of_type(String) }
    it { is_expected.to have_field(:email).of_type(String) }
    it { is_expected.to have_field(:tlf).of_type(String) }
  end
end
