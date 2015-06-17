Given(/^I visit login page$/) do
  visit new_user_session_path
end

# Para iniciar sesión

Given(/^I am loged in like user$/) do
  usuario = FactoryGirl.create(:director)

  visit new_user_session_path

  fill_in 'user_name', with: usuario.name
  fill_in 'user_password', with: 'foobarfoo'

  page.find("#buttomlogin").click
end

Given(/^I am loged in like director$/) do
  usuario = FactoryGirl.create(:director)

  visit new_user_session_path

  fill_in 'user_name', with: usuario.name
  fill_in 'user_password', with: 'foobarfoo'

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
  usuario = FactoryGirl.create(:director)

  fill_in 'user_name', with: usuario.name
  fill_in 'user_password', with: 'foobarfoo'

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
  User.with_role(:worker).each do |user|
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

Then(/^I should see a remove user success message$/) do
  expect(page).to have_css ".leo-message", text:"¡Borrado satisfactoriamente!"
end

# Test para vista crear usuario
Given(/^I visit new user page$/) do
  page.find("#createUser").click
end

When(/^I fill user form with valid parameters$/) do
  parametros = FactoryGirl.attributes_for(:user)
  fill_in 'InputName', with: parametros[:name]
  fill_in 'InputPassword', with: parametros[:password]
  fill_in 'InputPassword_confirmation', with: parametros[:password]
  fill_in 'InputFull_name', with: parametros[:full_name]
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

# Errores del formulario
When(/^I fill user form with invalid parameters$/) do
  parametros = FactoryGirl.attributes_for(:user)
  fill_in 'InputPassword_confirmation', with: parametros[:email]
  fill_in 'InputEmail', with: parametros[:email]
  fill_in 'InputTlf', with: parametros[:tlf]
  click_button 'InputSubmit'
end

Then(/^I should see tooltips for errors in create user form$/) do
  expect(page).to have_css ".has-error #InputName"
  expect(page).to have_css "#InputName ~ .tooltip", text:  I18n.t('mongoid.errors.messages.blank')
  expect(page).to have_css ".has-error #InputPassword"
  expect(page).to have_css "#InputPassword ~ .tooltip", text: I18n.t('mongoid.errors.messages.blank')
  expect(page).to have_css ".has-error #InputPassword_confirmation"
  expect(page).to have_css "#InputPassword_confirmation ~ .tooltip", text: I18n.t('mongoid.errors.messages.confirmation')
  expect(page).to have_css ".has-error #InputFull_name"
  expect(page).to have_css "#InputFull_name ~ .tooltip", text: I18n.t('mongoid.errors.messages.blank')
end

# Editar usuario

Given(/^There is (\d+) user in the platform$/) do |amount|
  FactoryGirl.create_list(:worker, amount.to_i)
end

Given(/^I click the view icon of a user in user list view$/) do
  usuario = User.first
  page.find("#user-show-#{usuario.id}").click
end

When(/^I click the edit user button$/) do
  page.find(".usuario__botones__edit").click
end

Then(/^I should see the edit user form$/) do
  expect(page).to have_css "#userForm"
end

Then(/^I should see the user information in the user form$/) do
@user = User.first
  find_field('InputName').value.should eq @user.name
  find_field('InputFull_name').value.should eq @user.full_name
  find_field('InputRole').value.should eq @user.role.to_s
  find_field('InputEmail').value.should eq @user.email
  find_field('InputTlf').value.should eq @user.tlf
end

When(/^I update the user form$/) do
@user = User.first
  page.find("#user-edit-#{@user.id}").click
  fill_in 'InputName', with: "pepe"
  fill_in 'InputFull_name', with: "pepe gonzalez"
  fill_in 'InputEmail', with: "prolibertas@prolibertas.es"
  fill_in 'InputTlf', with: "345345343"
  page.find("#InputSubmit").click
end

Then(/^I should see the user updated$/) do
  expect(page).to have_css "#user-edit-#{@user.id}"
  expect(page).to have_css "#user_username", text: "pepe"
  expect(page).to have_css "#user_full_name", text: "pepe gonzalez"
  expect(page).to have_css "#user_email", text: "prolibertas@prolibertas.es"
  expect(page).to have_css "#user_tlf", text: "345345343"
end

When(/^I fill user update form with invalid parameters$/) do
  @user = User.first
  page.find("#user-edit-#{@user.id}").click
  fill_in 'InputName', with: ""
  fill_in 'InputFull_name', with: ""
  fill_in 'InputPassword', with: ""
  fill_in 'InputPassword_confirmation', with: "1"
  page.find("#InputSubmit").click
end

Then(/^I should see the errors in the update user form$/) do
  expect(page).to have_css ".has-error #InputName"
  expect(page).to have_css "#InputName ~ .tooltip", text:  I18n.t('mongoid.errors.messages.blank')
  expect(page).to have_css ".has-error #InputPassword_confirmation"
  expect(page).to have_css "#InputPassword_confirmation ~ .tooltip", text: I18n.t('mongoid.errors.messages.confirmation')
  expect(page).to have_css ".has-error #InputFull_name"
  expect(page).to have_css "#InputFull_name ~ .tooltip", text: I18n.t('mongoid.errors.messages.blank')
end

When(/^I click the head icon in the layout$/) do
  page.find("#perfil").click
end

Then(/^I should go to a view of my profile$/) do
  expect(page).to have_css "#perfil-page"
end

When(/^I change my password$/) do
  page.find("#perfil").click
  fill_in 'InputPassword', with: "barfoobar"
  fill_in 'InputPassword_confirmation', with: "barfoobar"
  page.find("#perfil-submit").click
  page.find("#logout").click
  fill_in 'user_name', with: User.last.name
  fill_in 'user_password', with: 'barfoobar'
  page.find("#buttomlogin").click
end

Then(/^I should see my password changed$/) do
  expect(page).to have_css "#principal"
end

#Test permiso de Voluntario para ocultar las pestañas de Usuarios en el Layout, y Historia y Alertas en Persona
Given(/^There is (\d+) volunteer user in the platform$/) do |arg1|
  @voluntario = FactoryGirl.create(:volunteer)
end

Given(/^There is no user sesion$/) do
  page.find("#logout").click
end

When(/^I am loged in like volunteer$/) do
  visit new_user_session_path
  fill_in 'user_name', with: @voluntario.name
  fill_in 'user_password', with: 'foobarfoo'
  #click_button 'buttomlogin'
  #page.execute_script "$('body').scrollTo('#buttomlogin');"
  page.find("#buttomlogin").click
end

Then(/^I cannot view users tab$/) do
  expect(page).to_not have_css "#go-users"
end

Then(/^I shouldn't view history tab and alerts tab$/) do
  expect(page).to_not have_css "#person_histories"
  expect(page).to_not have_css "#person__alerts"
end
