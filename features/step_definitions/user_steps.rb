Given(/^I visit login page$/) do
  visit new_user_session_path
end

Given(/^I am loged in like user$/) do
  usuario = FactoryGirl.create(:user)
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
  expect(page).to have_css ".navbar-nav"
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
