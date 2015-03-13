shared_examples_for "a destroy action for a REST controller" do
  context "when resource do exist" do
    before do
      @destroy_resource =
        FactoryGirl.create(@model.to_s.underscore.to_sym, @parameters.merge(@destroy_params || {}))
      delete :destroy, id: @destroy_resource.id
    end

    it "returns a 204 HTTP status code" do
      expect(response).to have_http_status(:no_content)
    end

    it "delete the resource from database" do
      expect{
        @model.find( @destroy_resource.id )
      }.to raise_error Mongoid::Errors::DocumentNotFound
    end
  end

  context "when resources does not exist" do
    before do
      delete :destroy, id: 'random_id'
    end

    it "returns a 404 HTTP status code" do
      expect(response).to have_http_status(:not_found)
    end
  end
end
