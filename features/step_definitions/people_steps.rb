Given(/^There are (\d+) people in the platform$/) do |amount|
  FactoryGirl.create_list(:person, amount.to_i)
end

Given(/^I am loged in like user$/) do
  usuario = FactoryGirl.create(:user)
  visit new_user_session_path
  fill_in 'user_name', with: usuario.name
  fill_in 'user_password', with: 'foobarfoo'
  click_button 'buttomlogin'
end

Then(/^I should see the list of the people$/) do
  expect(page).to have_css "#peopleTable"
  Person.each do |person|
    expect(page).to have_css "tr#person_#{person.id}", text: person.name
    expect(page).to have_css "tr#person_#{person.id}", text: person.surname
  end
end
