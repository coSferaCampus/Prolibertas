FactoryGirl.define do

  factory :person do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    origin { Faker::Address.country }
    genre { [:man, :woman].sample }
    phone { Faker::PhoneNumber.cell_phone }
    assistance { [0, 1, 2].sample }
    home { Faker::Lorem.word}
    family_status { [:single, :married, :divorced, :widower].sample  }
    health_status {[:drug_addict, :alcoholic, :sic, :healthy].sample  }
    birth { Faker::Date.between(60.years.ago, 18.years.ago) }
    nif { Faker::Number.number(8) }
    social_services { [0, 1].sample }
    menu { [:standar, :muslim].sample }
    income { [:yes, :not].sample }
    address { Faker::Address.street_address }
    contact_family { Faker::Name.first_name }
    notes { Faker::Lorem.paragraph}
    documentation { [0, 1, 2].sample }
    address_type { [0, 1, 2].sample }
    residence { [0, 1].sample }
    have_income { [0, 1].sample }
    city { [:Alava, :Albacete, :Alicante, :Almeria, :Asturias, :Avila, :Badajoz, :Baleares, :Barcelona,:Burgos, :Caceres, :Cadiz, :Cantabria, :Castellon, :Ceuta, :Ciudad_Real, :Cordoba, :Cuenca, :Girona, :Granada, :Guadalajara, :Guipuzcoa, :Huelva,:Huesca, :Jaen, :La_Coruna, :La_Rioja, :Las_Palmas, :Leon, :Lerida, :Lugo, :Madrid, :Malaga, :Melilla, :Murcia, :Navarra, :Orense, :Palencia, :Pontevedra,:Salamanca, :Segovia, :Sevilla, :Soria, :Tarragona, :Tenerife,:Teruel, :Toledo, :Valencia, :Valladolid, :Vizcaya, :Zamora, :Zaragoza].sample }
  end
  # Sólo se debe usar con attributes_for
  factory :person_update, parent: :person do
    name "A new name"
    surname "A new surname"
    origin "A new origin"
    genre { [:man, :woman].sample }
    phone "A new phone"
    assistance { [0, 1, 2].sample }
    home "A new home"
    family_status "A new family_status"
    health_status "A new health_status"
    birth { Faker::Date.between(60.years.ago, 18.years.ago) }
    nif "A new nif"
    social_services { [0, 1].sample }
    menu "A new menu"
    income "A new income"
    address "A new address"
    contact_family "A new contact_family"
    notes "A new notes"
    documentation { [0, 1, 2].sample }
    address_type { [0, 1, 2].sample }
    residence { [0, 1].sample }
    have_income  { [0, 1].sample }
    city { [:Alava, :Albacete, :Alicante, :Almeria, :Asturias, :Avila, :Badajoz, :Baleares, :Barcelona,:Burgos, :Caceres, :Cadiz, :Cantabria, :Castellon, :Ceuta, :Ciudad_Real, :Cordoba, :Cuenca, :Girona, :Granada, :Guadalajara, :Guipuzcoa, :Huelva,:Huesca, :Jaen, :La_Coruna, :La_Rioja, :Las_Palmas, :Leon, :Lerida, :Lugo, :Madrid, :Malaga, :Melilla, :Murcia, :Navarra, :Orense, :Palencia, :Pontevedra,:Salamanca, :Segovia, :Sevilla, :Soria, :Tarragona, :Tenerife,:Teruel, :Toledo, :Valencia, :Valladolid, :Vizcaya, :Zamora, :Zaragoza].sample }
  end
end
