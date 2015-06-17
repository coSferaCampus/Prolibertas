require 'rails_helper'
RSpec.describe Attached, type: :model do
  context "Document" do
    it { is_expected.to be_timestamped_document }
  end

  context "Fields" do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:description).of_type(String) }
    it { is_expected.to have_field(:date).of_type(Date) }
  end

  context "Relations" do
    it { is_expected.to belong_to(:person) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:date) }    
    it { is_expected.to validate_presence_of(:person) }
  end



end
