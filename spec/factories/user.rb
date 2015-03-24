FactoryGirl.define do
  factory :user do
    name
    password "foobarfoo"
  end

  factory :director, parent: :user do
    before( :create ) do |user|
      user.add_role "director"
    end
  end

  factory :worker, parent: :user do
    before( :create ) do |user|
      user.add_role "worker"
    end
  end

  factory :volunteer, parent: :user do
    before( :create ) do |user|
      user.add_role "volunteer"
    end
  end
end
