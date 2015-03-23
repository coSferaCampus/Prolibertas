require 'rails_helper'

RSpec.describe UsedServicesController, type: :controller do
  set_content_type 'application/json'

  options = [:show, :create, :destroy]
  json_attributes = [:person_id, :service_id]

  before :all do
    @user  = FactoryGirl.create(:user)
    @model = UsedService

    person = FactoryGirl.create(:person)
    service = FactoryGirl.create(:service)

    #Para el test de show
    @resource = FactoryGirl.create(:used_service, person: person, service: service)

    #Para los test create y destroy
    @parameters = {person_id: person.id.to_s, service_id: service.id.to_s}
  end

  before do
    sign_in @user
  end

  it_behaves_like "a REST controller", options, json_attributes

end
