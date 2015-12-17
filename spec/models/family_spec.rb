require 'rails_helper'
RSpec.describe Family, type: :model do
  context "Document" do
    it { is_expected.to be_timestamped_document }
  end

  context "Fields" do
    it { is_expected.to have_field( :name             ).of_type(String) }
    it { is_expected.to have_field( :surname          ).of_type(String) }
    it { is_expected.to have_field( :origin           ).of_type(String) }
    it { is_expected.to have_field( :menu             ).of_type(String) }
    it { is_expected.to have_field( :phone            ).of_type(String) }
    it { is_expected.to have_field( :birthchildren    ).of_type(String) }
    it { is_expected.to have_field( :socialworker     ).of_type(String) }
    it { is_expected.to have_field( :address          ).of_type(String) }
    it { is_expected.to have_field( :identifier       ).of_type(String) }
    it { is_expected.to have_field( :id_type          ).of_type(String) }
    it { is_expected.to have_field( :amount_of_income ).of_type(String) }
    it { is_expected.to have_field( :zts              ).of_type(String) }
    it { is_expected.to have_field( :ropero_time      ).of_type(String) }

    it { is_expected.to have_field( :adults           ).of_type(Integer) }
    it { is_expected.to have_field( :children         ).of_type(Integer) }
    it { is_expected.to have_field( :type_of_income   ).of_type(Integer) }
#    it { is_expected.to have_field( :address_type     ).of_type(Integer) }
    it { is_expected.to have_field( :assistance       ).of_type(Integer) }

    it { is_expected.to have_field( :from             ).of_type(Date) }
    it { is_expected.to have_field( :to               ).of_type(Date) }
    it { is_expected.to have_field( :ropero_date      ).of_type(Date) }

    it { is_expected.to have_field( :muslim ).of_type(Mongoid::Boolean) }
  end

  context "Relations" do
    it { is_expected.to have_many(:used_services) }
    it { is_expected.to have_many(:alerts) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of( :name     ) }
    it { is_expected.to validate_presence_of( :surname  ) }
    it { is_expected.to validate_presence_of( :adults   ) }
    it { is_expected.to validate_presence_of( :children ) }
    it { is_expected.to validate_presence_of( :origin   ) }
  end
end
