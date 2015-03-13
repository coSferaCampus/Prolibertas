shared_examples_for "a create action for a REST controller" do |attributes, no_check_values|
  context "when all parameters are correct" do
    let( :root ){ defined?( fixed_root ) ? fixed_root : @model.to_s.tableize.singularize }

    before do
      post :create, {:"#{root}" => @parameters}.merge(@create_params || {})
    end

    after do
      @model.last.destroy if @model.present?
    end

    it "returns a 201 HTTP status code" do
      expect(response).to have_http_status :created
    end

    it "returns the new resource URI in the Location header" do
      expect(response.headers['Location']).to match( /\/#{root.pluralize}\/[0-9a-f]+/ )
    end

    it "returns an entity which describes the status of the new resource (the id)" do
      expect(response_body_json[root]).to have_key( 'id' )
    end

    describe "Resource attributes" do
      attributes.each do |attr|
        unless no_check_values.include?( attr )
          it "include the attribute #{attr}" do
            expect(response_body_json[root]).to have_key( attr.to_s )
          end
        end

        unless attr == :id || no_check_values.include?( attr )
          it "return the correct value for attribute #{attr}" do
            # Casting to json and parse again is needed to take values
            # is correct format and type
            # For instance:
            #   (Parameters) alarm[:status]  #=> :pending
            #   (JSON)       alarm["status"] #=> "pending"
            parameters = @parameters.dup
            no_check_values.each{ |value| parameters.delete value }
            json_value  = response_body_json[root][attr.to_s]
            param_value = JSON.parse( parameters.to_json )[attr.to_s]
            # The id can not be checked up for correct value because when
            # we create a new resource we dont know about the id
            expect(json_value).to eql( param_value ) unless attr == :id
          end
        end
      end
    end
  end
end
