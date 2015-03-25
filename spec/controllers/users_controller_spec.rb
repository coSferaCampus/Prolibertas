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

      context "GET #show" do
        it "returns 403 HTTP status code" do
          get :show, id: @volunteer.id.to_s 
          expect(response).to have_http_status :forbidden
        end
      end

      context "GET #index" do
        it "returns 403 HTTP status code" do
          get :index
          expect(response).to have_http_status :forbidden
        end
      end

      context "POST #create" do
        it "returns 403 HTTP status code" do
          post :create, user: @parameters 
          expect(response).to have_http_status :forbidden
        end
      end

      context "PUT #update" do
        it "returns 403 HTTP status code" do
          put :update, id: @volunteer.id.to_s, user: @parameters 
          expect(response).to have_http_status :forbidden
        end
      end

      context "DELETE #destroy" do
        it "returns 403 HTTP status code" do
          delete :destroy, id: @volunteer.id.to_s
          expect(response).to have_http_status :forbidden
        end
      end
    end

    context "worker" do
      before do
        sign_in @worker
      end

      context "GET #show" do
        it "returns 403 HTTP status code when looking for a director" do
          get :show, id: @user.id.to_s
          expect(response).to have_http_status :forbidden
        end

        it "returns 403 HTTP status code when looking for a worker" do
          get :show, id: @worker.id.to_s
          expect(response).to have_http_status :forbidden
        end

        it "returns 200 HTTP status code when looking for a volunteer" do
          get :show, id: @volunteer.id.to_s
          expect(response).to have_http_status :ok
        end
      end

      context "GET #index" do
        it "returns only volunteers" do
          get :index
          expect(assigns(:users).to_a).to match_array User.with_role(:volunteer).to_a
        end
      end

      # context "POST #create, worker only can create volunteers" do
      #   it "returns 201 HTTP status code" do
      #     post :create, user: @parameters
      #     expect(assigns(:user)).to eql User.with_role(:volunteer)
      #   end
      # end
    end

    context "director" do
      before do
        sign_in @user
      end

      context "create user with role worker" do
        it "returns 200 HTTP status code when looking for a volunteer" do
          get :show, id: @volunteer.id.to_s
          expect(response).to have_http_status :ok
        end
      end
    end
  end
end
