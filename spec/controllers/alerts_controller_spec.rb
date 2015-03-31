require 'rails_helper'

RSpec.describe AlertsController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create, :update, :destroy]
  json_attributes = FactoryGirl.attributes_for(:alert).keys

  before :all do
    @user = FactoryGirl.create(:user)
    @person = FactoryGirl.create(:person)
    @volunteer = FactoryGirl.create(:volunteer)
    
    # Para todos los tests
    @model = Alert

    # Para el test de show
    @resource = FactoryGirl.create(:alert, person: @person)

    # Para el test de index
    # Opciones necesarias para crear la lista de alertas en el test de index
    @list_options = {person: @person}
    # Parámetros que se envían al get :index
    @index_params = {person_id: @person.id.to_s}
    @first_page_resources = @person.alerts

    #Para el test de create
    @create_params = {person_id: @person.id.to_s}

    # Para el test de create y destroy
    @parameters = FactoryGirl.attributes_for(:alert)

    # Para el test de update
    @update_params = FactoryGirl.attributes_for(:alert_update)

    #Para el test de destroy
    @destroy_params = {person: @person}
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

      context "GET #show" do
        it "returns 403 HTTP status code" do
          get :show, id: @resource.id.to_s 
          expect(response).to have_http_status :forbidden
        end
      end

      context "PUT #update" do
        it "returns 403 HTTP status code" do
          put :update, id: @resource.id.to_s
          expect(response).to have_http_status :forbidden
        end
      end

      context "DELETE #destroy" do
        it "returns 403 HTTP status code" do
          delete :destroy, id: @resource.id.to_s
          expect(response).to have_http_status :forbidden
        end
      end
    end
  end
end
