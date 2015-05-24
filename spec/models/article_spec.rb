require 'rails_helper'
RSpec.describe Article, type: :model do 
	context "Document" do
		it { is_expected.to be_timestamped_document }
	end
	context "Fields" do
    it { is_expected.to have_field(:type).of_type(Symbol) }
    it { is_expected.to have_field(:amount).of_type(Integer) }
    it { is_expected.to have_field(:requested).of_type(Date) }
    it { is_expected.to have_field(:dispensed).of_type(Date) }
    it { is_expected.to have_field(:observations).of_type(String) }
  end

  context "Relations" do
  	it { is_expected.to belong_to(:person) }
  end

  context "Validations" do
  	it { is_expected.to validate_inclusion_of(:type).to_allow([:blanket, :sheet, :jacket, :shoes, :others1, :others2, :others3])}
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:requested) }
    it { is_expected.to validate_presence_of(:person) }
  end
end