FactoryGirl.define do
  factory :family do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    origin { Faker::Address.country }
    menu { ["standar", "muslim"].sample }
    phone { Faker::PhoneNumber.cell_phone }
    adults { rand(1...3) }
    children { rand(1...5) }
    birthchildren { "1,2,1" }
    center { ['Norte', 'Levante', 'Fuensanta', 'Ribera',
      'Poniente Sur', 'Poniente Norte', 'Moreras', 'Periferia', 'Lucena'].sample }
    socialworker { Faker::Name.name}
    type_of_income { [0, 1].sample }
    amount_of_income {  rand(100...700).to_f.to_s }
    address_type { [0, 1, 2].sample }
    address { Faker::Address.street_address }
    assistance { [0, 1, 2].sample }
    nif { Faker::Number.number(8) }
  end

  # Sólo se debe usar con attributes_for
  factory :family_update, parent: :family do
    name "Nombre nuevo"
    surname { Faker::Name.last_name }
    origin { Faker::Address.country }
    menu { ["standar", "muslim"].sample }
    phone { Faker::PhoneNumber.cell_phone }
    adults { rand(1...3) }
    children { rand(1...5) }
    birthchildren "1,2,1"
    center { ['Norte', 'Levante', 'Fuensanta', 'Ribera', 'Poniente Sur', 'Poniente Norte', 'Moreras', 'Periferia', 'Lucena'].sample }
    socialworker { Faker::Name.name}
    type_of_income { [0, 1].sample }
    amount_of_income {  rand(100...700).to_f.to_s }
    address_type { [0, 1, 2].sample }
    address { Faker::Address.street_address }
    assistance { [0, 1, 2].sample }
    nif { Faker::Number.number(8) }
  end
end
