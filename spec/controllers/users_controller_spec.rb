require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create, :update, :destroy]
  json_attributes = [:name, :full_name, :email, :tlf]

  before :all do
    @user = FactoryGirl.create(:director)
    @worker = FactoryGirl.create(:worker)
    @volunteer = FactoryGirl.create(:volunteer)

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

  context "abilities" do 

    context "volunteer" do
      before do
        sign_in @volunteer
      end

      context "POST #create" do
        it "returns 403 HTTP status code" do
          post :create, user: @parameters 
          expect(response).to have_http_status :forbidden
        end
      end
    end
  end
end
