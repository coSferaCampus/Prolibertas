shared_examples_for "a show action for a REST controller" do |attributes, no_check_values|
  context "when resource does exist" do
    before :each do
      get :show, id: @resource.id
    end

    let( :root ){ @model.to_s.underscore }

    it "returns a 200 HTTP status code" do
      expect(response).to have_http_status :ok
    end

    it "returns the response body as JSON data" do
      expect(->{JSON.parse(response.body)}).to_not raise_error
    end

    it "returns the singular name of the resource as JSON root" do
      expect(response_body_json).to have_key( root )
    end

    it "returns a hash containing the resource" do
      expect(response_body_json[root].is_a?( Hash )).to eql(true)
    end

    describe "Resource attributes" do
      attributes.each do |attr|
        unless no_check_values.include?( attr )
          it "include the attribute #{attr}" do
            expect(response_body_json[root]).to have_key( attr.to_s )
          end

          it "return the correct value for attribute #{attr}" do
            # Casting to json and parse again is needed to take values
            # is correct format and type
            # For instance:
            #   (Model) alarm.status    #=> :pending
            #   (JSON)  alarm["status"] #=> "pending"
            json_value  = response_body_json[root][attr.to_s]
            model_value = @resource.send(attr).as_json

            expect(json_value).to eql model_value
          end
        end
      end
    end
  end

  context "when resource does not exists" do
    before do
      get :show, id: 'random_id'
    end

    it "returns a 404 HTTP status code" do
      expect(response).to have_http_status(:not_found)
    end
  end
end
