FactoryGirl.define do

  factory :history do
    description { Faker::Lorem.paragraph }
    liabilities { Faker::Lorem.paragraph }
    date { Faker::Date.forward(23)}
    time { Faker::Lorem.word}
    newdate { Faker::Date.forward(23)}
    newtime { Faker::Lorem.word}

  end
  # Sólo se debe usar con attributes_for
  factory :history_update, parent: :history do
    description "A new description"
    liabilities "A new liabilities"
    date { Faker::Date.forward(23) }
    time "A new time"
    newdate { Faker::Date.forward(23) }
    newtime "A new timenew"
  end
end
