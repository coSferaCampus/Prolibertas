Rolify.configure do |config|
  # By default ORM adapter is ActiveRecord. uncomment to use mongoid
  config.use_mongoid

  # Dynamic shortcuts for User class (user.is_admin? like methods). Default is: false
  # config.use_dynamic_shortcuts

  if Role.where(name: 'director').empty?
    Role.create(name: 'director')
  end

  if Role.where(name: 'worker').empty?
    Role.create(name: 'worker')
  end

  if Role.where(name: 'volunteer').empty?
    Role.create(name: 'volunteer')
  end
end