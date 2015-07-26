 require 'rails_helper'

RSpec.describe UsedService, type: :model do

  context "Relations" do
  it { is_expected.to belong_to(:service) }
  it { is_expected.to belong_to(:person) }
  end

end
