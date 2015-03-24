FactoryGirl.define do
  sequence :name do |n|
    "nombre#{n}"
  end
end
