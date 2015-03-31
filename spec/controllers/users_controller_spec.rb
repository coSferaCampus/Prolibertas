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
    @resource = FactoryGirl.create(:volunteer)

    # Para el test de index
    @first_page_resources = User.all

    # Para el test de create y destroy
    @parameters = FactoryGirl.attributes_for(:user)

    # Para el test de update
    @update_params = FactoryGirl.attributes_for(:user)
  end

  before do
    sign_in @user
  end

  it_behaves_like "a REST controller", options, json_attributes

  context "currentUser" do
    before do
      sign_in @user
    end

    context "GET #current" do
      it "returns 200 HTTP status code" do
        get :current, id: @user.id.to_s 
        expect(response).to have_http_status :ok
        
      end
    end
  end

  context "abilities" do 

    context "volunteer" do
      before do
        sign_in @volunteer
      end

      context "GET #show" do
        it "returns 200 HTTP status code when looking for himself" do
          get :show, id: @volunteer.id.to_s 
          expect(response).to have_http_status :ok
        end

        it "returns 403 HTTP status code when looking for other volunteer" do
          voluntario = FactoryGirl.create(:volunteer)
          get :show, id: voluntario.id.to_s 
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

      context "POST #create, worker only can create volunteers" do
        it "returns 201 HTTP status code" do
          @parameters[:role] = "director"
          post :create, user: @parameters
          expect(User.last).to have_role :volunteer
        end
      end

      context "PUT #update" do
        it "cant upgrade volunteer to worker" do
          @parameters[:role] = "worker"
          put :update,id: @volunteer.id.to_s, user: @parameters 
          expect(User.where(id: @volunteer.id.to_s).first).to have_role :volunteer
        end
      end

      context "DELETE #destroy" do
        it "returns 204 HTTP status code" do
          volunteer = FactoryGirl.create(:volunteer)
          delete :destroy, id: volunteer.id.to_s
          expect(response).to have_http_status :no_content
        end

        it "cant destroy worker, returns 403 HTTP status code" do
          delete :destroy, id: @worker.id.to_s, user: @parameters
          expect(response).to have_http_status :forbidden
        end

        it "cant destroy director, returns 403 HTTP status code" do
          delete :destroy, id: @user.id.to_s, user: @parameters
          expect(response).to have_http_status :forbidden
        end
      end
    end

    context "director" do
      before do
        sign_in @user
      end

      context "GET #show" do
        it "returns 200 HTTP status code when looking for a volunteer" do
          get :show, id: @volunteer.id.to_s
          expect(response).to have_http_status :ok
        end
      end

      context "GET #index" do
        it "returns only workers and volunteers" do
          get :index
          expect(assigns(:users).to_a).to match_array User.with_any_role(:volunteer, :worker).to_a
        end
      end

      context "POST #create, director can create workers and volunteers" do
        it "returns 201 HTTP status code" do
          @parameters[:role] = "volunteer"
          post :create, user: @parameters
          expect(User.last).to have_role :volunteer
        end
      end

      context "PUT #update" do
        it "can upgrade volunteer to worker" do
          @parameters[:role] = "worker"
          put :update, id: @volunteer.id.to_s, user: @parameters 
          expect(User.where(id: @volunteer.id.to_s).first).to have_role :worker
        end

        it "can update my own password" do
          director = FactoryGirl.create(:director)
          sign_in director
          put :update, id: director.id.to_s, user: { password: 'foofoobar', password_confirmation: 'foofoobar' }
          expect(response).to have_http_status :no_content
        end
      end

      context "DELETE #destroy" do
        it "can destroy workers and volunteers" do
          worker = FactoryGirl.create(:worker)
          delete :destroy, id: worker.id.to_s
          expect(response).to have_http_status :no_content
        end

        it "cant destroy director, returns 403 HTTP status code" do
          delete :destroy, id: @user.id.to_s, user: @parameters
          expect(response).to have_http_status :forbidden
        end
      end
    end
  end
end
