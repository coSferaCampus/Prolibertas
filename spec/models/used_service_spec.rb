require 'rails_helper'

RSpec.describe UsedService, type: :model do
  context "Document" do
    it { is_expected.to be_timestamped_document }
  end

  context "Relations" do
  it { is_expected.to belong_to(:service) }
  it { is_expected.to belong_to(:person) }
  end
end
