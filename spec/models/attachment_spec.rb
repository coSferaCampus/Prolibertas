require 'rails_helper'
RSpec.describe Attachment, type: :model do
  context "Document" do
    it { is_expected.to be_timestamped_document }
  end

  context "Fields" do
    it { is_expected.to have_field(:name).of_type(String) }
  end

  context "Relations" do
    it { is_expected.to belong_to(:person) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
