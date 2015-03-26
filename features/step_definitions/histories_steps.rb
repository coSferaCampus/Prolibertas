Given(/^There (?:are|is) (\d+) (?:histories|history) of this person$/) do |amount|
  history_person = Person.first
  FactoryGirl.create_list(:history, amount.to_i, person: history_person)
end

When(/^I click the histories tab of the person$/) do
  page.find("#person_histories").click
end

Then(/^I should see the list of the histories$/) do
  expect(page).to have_css "#list_histories"
  Person.first.histories.each do |history|
    expect(page).to have_css "tr#history_#{history.id} td:nth-child(2)", text:history.description
    expect(page).to have_css "tr#history_#{history.id} td:nth-child(3)", text:history.liabilities
    expect(page).to have_css "tr#history_#{history.id} td:nth-child(4)", text:history.date.strftime("%Y-%m-%d")
    expect(page).to have_css "tr#history_#{history.id} td:nth-child(5)", text:history.time
  end
end

When(/^I click the view icon of a history in histories list view$/) do
  historia = Person.first.histories.first 
  page.find("#history-show-#{historia.id}").click
end

Then(/^I should go to a view of this history$/) do
   expect(page).to have_css "#history-show-page"
end

#crear historia
Given (/^I visit new history page$/) do
  click_link 'createhistory'
end

When(/^I fill history form with valid parameters$/) do
  parametros = FactoryGirl.attributes_for(:history)
  fill_in 'InputDescriptionHistory', with: parametros[:description]
  fill_in 'InputLiabilities', with: parametros[:liabilities]
  fill_in 'InputDateHistory', with: parametros[:date]
  fill_in 'InputTime', with: parametros[:time]
  fill_in 'InputDatenew', with: parametros[:newdate]
  fill_in 'InputTimenew', with: parametros[:newtime]
end

Then(/^I should see the new history in histories list$/) do
  expect(page).to have_css "#List_histories"

  historia = Person.first.histories.last

  expect(page).to have_css "tr#history_#{history.id} td:nth-child(2)", text:history.description
  expect(page).to have_css "tr#history_#{history.id} td:nth-child(3)", text:history.liabilities
  expect(page).to have_css "tr#history_#{history.id} td:nth-child(4)", text:history.date.strftime("%Y-%m-%d")
  expect(page).to have_css "tr#history_#{history.id} td:nth-child(5)", text:history.time
end

Then(/^I should see history created message$/) do
  expect(page).to have_css ".leo-message", text:"¡Ha creado satisfactoriamente una nueva historia!"
end
