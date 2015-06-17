require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :index, :create, :update, :destroy]
  json_attributes = FactoryGirl.attributes_for(:article).keys

  before :all do
    @user = FactoryGirl.create(:user)
    @person = FactoryGirl.create(:person)
    @volunteer = FactoryGirl.create(:volunteer)

    # Para todos los tests
    @model = Article

    # Para el test de show
    @resource = FactoryGirl.create(:article, person: @person)

    # Para el test de index
    # Opciones necesarias para crear la lista de artículos en el test de index
    @list_options = {person: @person}
    # Parámetros que se envían al get :index
    @index_params = {person_id: @person.id.to_s}
    @first_page_resources = @person.articles

    #Para el test de create
    @create_params = {person_id: @person.id.to_s}

    # Para el test de create y destroy
    @parameters = FactoryGirl.attributes_for(:article)

    # Para el test de update
    @update_params = FactoryGirl.attributes_for(:article_update)

    #Para el test de destroy
    @destroy_params = {person: @person}
  end

  before do
    sign_in @user
  end

  it_behaves_like "a REST controller", options, json_attributes
end
