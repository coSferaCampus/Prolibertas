FactoryGirl.define do
  sequence :name do |n|
    "nombre#{n}"
  end

  sequence :full_name do |n|
    "nombre#{n} apellido#{n}"
  end

  sequence :email do |n|
    "email#{n}@email.com"
  end

  sequence :tlf do |n|
    "957" + "%06d" % n
  end
end
