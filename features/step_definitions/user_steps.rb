Given(/^I visit login page$/) do
  visit new_user_session_path
end

# Para iniciar sesión

Given(/^I am loged in like user$/) do
  usuario = FactoryGirl.create(:user)
  visit new_user_session_path
  fill_in 'user_name', with: usuario.name
  fill_in 'user_password', with: 'foobarfoo'
  #click_button 'buttomlogin'
  #page.execute_script "$('body').scrollTo('#buttomlogin');"
  page.find("#buttomlogin").click
end

Given(/^I am loged in like director$/) do
  usuario = FactoryGirl.create(:director)
  visit new_user_session_path
  fill_in 'user_name', with: usuario.name
  fill_in 'user_password', with: 'foobarfoo'
  #click_button 'buttomlogin'
  #page.execute_script "$('body').scrollTo('#buttomlogin');"
  page.find("#buttomlogin").click
end

When(/^I fill user login form with invalid parameters$/) do
  fill_in 'user_name', with: 'nombreinventado'
  fill_in 'user_password', with: 'contranseñainventadaalcuadrado'
  click_button 'buttomlogin'
end

Then(/^I should see message to say that name and password are invalid$/) do
  expect(page).to have_css "#invalid", text:"nombre o contraseña incorrectos"
end

When(/^I fill user login form with valid parameters$/) do
  usuario = FactoryGirl.create(:user)
  fill_in 'user_name', with: usuario.name
  fill_in 'user_password', with: 'foobarfoo'
  #click_button 'buttomlogin'
  page.find("#buttomlogin").click
end

Then(/^I should be in home info page$/) do
  expect(page).to have_css ".menu"
end

When(/^I visit home page$/) do
  visit root_path
end

Then(/^I should to be in login page$/) do
  expect(page).to have_css ".containerall"
end

#Test para CERRAR SESIÓN

When(/^I click the logout icon$/) do
  page.find("#logout").click
end

Then(/^I should be in login page$/) do
  expect(page).to have_css ".logologin"
end


# Test para lista de usuarios

Given(/^There are (\d+) workers users in the platform$/) do |amount|
  FactoryGirl.create_list(:worker, amount.to_i)
end

When(/^I go to users list page$/) do
  click_link 'go-users'
end


Then(/^I should see the list of all users$/) do
  expect(page).to have_css "#usersTable"
  User.each do |user|
    expect(page).to have_css "tr#user_#{user.id} td:nth-child(1)", text: user.name
    expect(page).to have_css "tr#user_#{user.id} td:nth-child(2)", text: user.full_name
    expect(page).to have_css "tr#user_#{user.id} td:nth-child(3)", text: 
    if user.roles.first.name == 'director'
      'Director'
    elsif user.roles.first.name == 'worker'
      'Trabajador Social'
    else
      'Voluntario'
    end
  end
end

# Test para vista de usuario

When(/^I click the view icon of a user in users list view$/) do
  usuario = User.first 
  page.find("#user-show-#{usuario.id}").click
end

Then(/^I should go to a view of this user$/) do
  usuario = User.first 
  expect(page).to have_css "#user_full_name", text: usuario.full_name
  expect(page).to have_css "#user_username", text: usuario.name
  expect(page).to have_css "#user_tlf", text: usuario.tlf
  expect(page).to have_css "#user_email", text: usuario.email
  expect(page).to have_css "#user_role", text: 
  if usuario.role == 'director'
    'Director'
  elsif usuario.role == 'worker'
    'Trabajador Social'
  else
    'Voluntario'
  end
end

# Test vista de usuario - borrar usuario

When(/^I click the remove button in users view$/) do
  @usuario = User.first 
  page.find("#user-show-#{@usuario.id}").click
  page.find("#remove-user-btn").click
  page.driver.browser.switch_to.alert.accept
end

Then(/^I should remove this user$/) do
  expect(page).to_not have_css "#user-show-#{@usuario.id}"
end

Then(/^I should see a success message$/) do
  expect(page).to have_css ".leo-message", text:"¡Borrado satisfactoriamente!"
end

# Test para vista crear usuario

When(/^I fill user form with valid parameters$/) do
  parametros = FactoryGirl.attributes_for(:user)
  fill_in 'InputUsername', with: parametros[:name]
  fill_in 'InputPass', with: parametros[:password]
  fill_in 'InputPassConfirmation', with: parametros[:password]
  fill_in 'InputName', with: parametros[:full_name]
  if parametros[:role] == :director
    select('Director', from: 'InputRole')
  elsif parametros[:role] == :worker
    select('Trabajador Social', from: 'InputRole')
  else
    select('Voluntario', from: 'InputRole')
  end
  fill_in 'InputEmail', with: parametros[:email]
  fill_in 'InputTlf', with: parametros[:tlf]
  click_button 'InputSubmit'
end

Then(/^I should see the new user in users list$/) do
  expect(page).to have_css "#usersTable"

  user = User.last
  expect(page).to have_css "tr#user_#{user.id} td:nth-child(1)", text: user.name
  expect(page).to have_css "tr#user_#{user.id} td:nth-child(2)", text: user.full_name
  expect(page).to have_css "tr#user_#{user.id} td:nth-child(3)", text: 
  if user.role == :director
    "Director"
  elsif user.role == :worker
    "Trabajor Social"
  else
    "Voluntario"
  end
end

Then(/^I should see user created message$/) do
  expect(page).to have_css ".leo-message", text:"¡Ha creado satisfactoriamente un nuevo usuario!"
end
