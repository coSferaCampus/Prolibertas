require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create, :update, :destroy]
  json_attributes = [:name, :full_name, :email, :tlf]

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
    @update_params = { 
      name: 'nombre1' , full_name: "nombre1 apellido1", 
      email: "email1@email.com", tlf: "957000001"
    }
  end

  before do
    sign_in @user
  end

  it_behaves_like "a REST controller", options, json_attributes
end
