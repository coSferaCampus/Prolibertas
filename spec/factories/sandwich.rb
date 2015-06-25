FactoryGirl.define do

  factory :sandwich do
    created_at { Faker::Date.between(Date.today, Date.today) }
    amount { Faker::Number.number(3).to_i }
  end

  # Sólo se debe usar con attributes_for
  factory :sandwich_update, parent: :sandwich do
    created_at { Faker::Date.between(Date.today, Date.today) }
    amount { Faker::Number.number(3).to_i }
  end
end
