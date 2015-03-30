FactoryGirl.define do

	factory :alert do
		type { [:punishment, :warning, :advice].sample }
		description { Faker::Lorem.sentence(3) }
		cause { Faker::Lorem.word}
		pending { Faker::Date.forward(23) }

	end
  # Sólo se debe usar con attributes_for
  factory :alert_update, parent: :alert do
  	type [:punishment, :warning, :advice].sample
  	description "A new description"
  	cause "A new cause"
  	pending { Faker::Date.forward(23) }
  end
end
