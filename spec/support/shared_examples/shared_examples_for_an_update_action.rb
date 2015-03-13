shared_examples_for "an update action for a REST controller" do |attributes, no_check_values|
  context "when resource does exist" do
    let( :root ){ defined?( fixed_root ) ? fixed_root : @model.to_s.tableize.singularize }

    before do
      put :update, :"#{root}" => @update_params, id: @resource.id
    end

    it "returns a 204 HTTP status code" do
      expect(response).to have_http_status(:no_content)
    end

    describe "Resource attributes" do
      let( :updated_resource ){ @resource.reload }

      attributes.each do |attr|
        # The id cannot be changed so it is not present in updated parameters
        unless attr == :id || no_check_values.include?( attr )
          it "update the attribute #{attr}" do
            expect(updated_resource.send(attr)).to eql @update_params[attr]
          end
        end
      end
    end
  end

  context "when resource does not exist" do
    before do
      put :update, id: 'random_id'
    end

    it "returns a 404 HTTP status code" do
      expect(response).to have_http_status(:not_found)
    end
  end
end
