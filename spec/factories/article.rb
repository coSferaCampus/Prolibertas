FactoryGirl.define do

  factory :article do
    type { [:blanket, :sheet, :jacket, :shoes, :others1, :others2, :others3].sample }
    amount { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].sample }
    requested { Faker::Date.backward(14)}
    dispensed { Faker::Date.forward(23) }
    observations { Faker::Lorem.sentence(3) }

  end
  # Sólo se debe usar con attributes_for
  factory :article_update, parent: :article do
    type { [:blanket, :sheet, :jacket, :shoes, :others1, :others2, :others3].sample }
    amount { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].sample }
    requested { Faker::Date.backward(14)}
    dispensed { Faker::Date.forward(23) }
    observations { Faker::Lorem.sentence(3) }
  end
end
