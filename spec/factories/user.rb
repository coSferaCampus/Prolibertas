FactoryGirl.define do
  factory :user do
    name 
    password "foobarfoo"
    password_confirmation "foobarfoo"
    full_name { Faker::Name.name }
    email
    tlf
  end

  factory :director, parent: :user do
    before( :create ) do |user|
      user.add_role "director"
    end
    role "director"
  end

  factory :worker, parent: :user do
    before( :create ) do |user|
      user.add_role "worker"
    end
    role "worker"
  end

  factory :volunteer, parent: :user do
    before( :create ) do |user|
      user.add_role "volunteer"
    end
    role "volunteer"
  end
end
