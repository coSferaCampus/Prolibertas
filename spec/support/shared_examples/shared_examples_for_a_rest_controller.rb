shared_examples_for "a REST controller" do |options, attributes, no_check_values = []|
  if options.include?( :index )
    describe "GET #index" do
      it_behaves_like "an index action for a REST controller", attributes
    end
  end

  if options.include?( :show )
    describe "GET #show" do
      it_behaves_like "a show action for a REST controller", attributes, no_check_values
    end
  end

  if options.include?( :create )
    describe "POST #create" do
      it_behaves_like "a create action for a REST controller", attributes, no_check_values
    end
  end

  if options.include?( :update )
    describe "PUT #update" do
      it_behaves_like "an update action for a REST controller", attributes, no_check_values
    end
  end

  if options.include?( :destroy )
    describe "DELETE #destroy" do
      it_behaves_like "a destroy action for a REST controller"
    end
  end

end
