require 'rails_helper'

RSpec.describe Service, type: :model do
  context "Document" do
    it { is_expected.to be_timestamped_document }
  end

  context "Fields" do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:primary).of_type(Mongoid::Boolean) }
  end

  context "Relations" do
    it { is_expected.to have_many(:used_services) }
  end

  context "Validations" do
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }


  end

  context "Primary services" do
    it "exists service for comida" do
      expect(Service.where(name: 'comida', primary: true).size).to eql(1)
    end

    it "exists service for ducha" do
      expect(Service.where(name: 'ducha', primary: true).size).to eql(1)
    end

    it "exists service for ropa" do
      expect(Service.where(name: 'ropa', primary: true).size).to eql(1)
    end

  end
end
