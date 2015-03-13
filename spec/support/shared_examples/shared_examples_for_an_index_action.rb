shared_examples_for "an index action for a REST controller" do |attributes|
  # Methods used here that have to be defined
  # model    [Class]    Document class that define the resources. ( Alarm, User, etc )
  # resource [Document] Existing resource to show, update and delete. ( FactoryGirl.create( :alarm ), etc )

  before do
    FactoryGirl.create_list( @model.to_s.underscore.to_sym, 3, defined?( @list_options ) ? @list_options : nil )
    get :index, defined?( @index_params ) ? @index_params : nil
  end

  let( :root ){ defined?( fixed_root ) ? fixed_root.pluralize : @model.to_s.tableize }

  it "returns a 200 HTTP status code" do
    expect(response).to have_http_status :ok
  end

  it "returns the response body as JSON data" do
    expect(->{JSON.parse(response.body)}).to_not raise_error
  end

  it "returns the pluralized name of the resource as JSON root" do
    expect(response_body_json).to have_key( root )
  end

  it "returns a collection of resources" do
    expect(response_body_json[root].is_a?(Array)).to eql(true)
  end

  it "returns all resources" do
    model_ids    = @first_page_resources.map{ |m| m.id.to_s }
    resource_ids = response_body_json[ root ].map{ |r| r["id"] }

    expect(resource_ids - model_ids).to eql([])
  end

  describe "Resource attributes" do
    attributes.each do |attr|
      it "include the attribute #{attr}" do
        response_body_json[ root ].each do |r|
          expect(r).to have_key( attr.to_s )
        end
      end
    end
  end
end
