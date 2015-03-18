FactoryGirl.define do
  factory :service do
    name
    type { [:primary, :secondary].sample }
  end
end
