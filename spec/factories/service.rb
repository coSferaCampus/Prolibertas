FactoryGirl.define do
  factory :service do
    name
    primary { [true, false].sample }
  end
end
