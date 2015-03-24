require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create, :update, :destroy]
  json_attributes = [:name]

  before :all do
    @user = FactoryGirl.create(:user)

    # Para todos los tests
    @model = User

    # Para el test de show
    @resource = FactoryGirl.create(:user)

    # Para el test de index
    @first_page_resources = User.all

    # Para el test de create y destroy
    @parameters = FactoryGirl.attributes_for(:user)

    # Para el test de update
    @update_params = { name: 'pepe' }
  end

  before do
    sign_in @user
  end

  it_behaves_like "a REST controller", options, json_attributes
end
