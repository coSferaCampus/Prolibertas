Given(/^I visit login page$/) do
  visit new_user_session_path
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
  click_button 'buttomlogin'
end

Then(/^I should be in home info page$/) do
  expect(page).to have_css ".navbar-nav"
end