require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  set_content_type 'application/json'

  options = [:show]
  json_attributes = [:name]

  before :all do
    @user = FactoryGirl.create(:user)

    # Para todos los tests
    @model = User

    # Para el test de show
    @resource = FactoryGirl.create(:user)
  end

  before do
    sign_in @user
  end

  it_behaves_like "a REST controller", options, json_attributes
end
