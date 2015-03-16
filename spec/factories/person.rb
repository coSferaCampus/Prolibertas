FactoryGirl.define do

	factory :person do
		name { Faker::Name.first_name }
		surname { Faker::Name.last_name }
		origin { Faker::Address.country }
		genre { [:man, :woman].sample }
		phone { Faker::PhoneNumber.cell_phone }
		assistance { Faker::Lorem.sentence(3) }
		home { Faker::Lorem.word}
		family_status { [:single, :married, :divorced, :widower].sample  }
		health_status {[:drug_addict, :alcoholic, :sic, :healthy].sample  }
		birth { Faker::Date.between(60.years.ago, 18.years.ago) }
		nif { Faker::Number.number(8) }
		social_services { [:derivative, :no_derivative,].sample }
		menu { [:standar, :muslim].sample }
		income { [:yes, :not].sample }
		address { Faker::Address.street_address }
		contact_family { Faker::Name.first_name }
		notes { Faker::Lorem.paragraph}

	end
  # Sólo se debe usar con attributes_for
  factory :person_update, parent: :person do
  	name "A new name"
  	surname "A new surname"
  	origin "A new origin"
  	genre [:man, :woman].sample
  	phone "A new phone"
  	assistance "A new assistance"
  	home "A new home"
  	family_status "A new family_status"
  	health_status "A new health_status"
  	birth { Faker::Date.between(60.years.ago, 18.years.ago) }
  	nif "A new nif"
  	social_services "A new social_services"
  	menu "A new menu"
  	income "A new income"
  	address "A new address"
  	contact_family "A new contact_family"
  	notes "A new notes"
  end
end
