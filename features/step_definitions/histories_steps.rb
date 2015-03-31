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
  fill_in 'InputDescription', with: parametros[:description]
  fill_in 'InputLiabilities', with: parametros[:liabilities]
  fill_in 'InputDate', with: parametros[:date].strftime('%d/%m/%Y')
  fill_in 'InputTime', with: parametros[:time]
  fill_in 'InputDatenew', with: parametros[:newdate].strftime('%d/%m/%Y')
  fill_in 'InputTimenew', with: parametros[:newtime]
  attach_file('InputFile', "#{Rails.root}/spec/samples/file.pdf")
  click_button 'InputSubmit'
end

Then(/^I should see the new history in histories list$/) do
  expect(page).to have_css "#list_histories"

  historia = Person.first.histories.last

  expect(page).to have_css "tr#history_#{historia.id} td:nth-child(2)", text:historia.description
  expect(page).to have_css "tr#history_#{historia.id} td:nth-child(3)", text:historia.liabilities
  expect(page).to have_css "tr#history_#{historia.id} td:nth-child(4)", text:historia.date.strftime("%Y-%m-%d")
  expect(page).to have_css "tr#history_#{historia.id} td:nth-child(5)", text:historia.time
end

Then(/^I should see history created message$/) do
  expect(page).to have_css ".leo-message", text:"¡Ha creado satisfactoriamente una nueva historia!"
end

When(/^I fill history form with invalid parameters$/) do
  parametros = FactoryGirl.attributes_for(:history)
  fill_in 'InputLiabilities', with: parametros[:liabilities]
  fill_in 'InputDatenew', with: parametros[:newdate].strftime('%d/%m/%Y')
  fill_in 'InputTimenew', with: parametros[:newtime]
  attach_file('InputFile', "#{Rails.root}/spec/samples/file.pdf")
  click_button 'InputSubmit'
end
Then(/^I should see the errors in the history form$/) do
  expect(page).to have_css ".has-error #InputDescription"
  expect(page).to have_css "#InputDescription ~ .tooltip", text:  I18n.t('mongoid.errors.messages.blank')
  expect(page).to have_css ".has-error #InputDate"
  expect(page).to have_css "#InputDate ~ .tooltip", text: I18n.t('mongoid.errors.messages.blank')
  expect(page).to have_css ".has-error #InputTime"
  expect(page).to have_css "#InputTime ~ .tooltip", text: I18n.t('mongoid.errors.messages.blank')

end

#editar historia

When(/^I click the edit history button$/) do
  page.find(".historia__btn__edit").click
end

Then(/^I should see the edit form history$/) do
  expect(page).to have_css "#historyform"
end

Then(/^I should see the history information in the form$/) do
  historia = Person.first.histories.first 
  find_field('InputDescription').value.should eq historia.description
  find_field('InputLiabilities').value.should eq historia.liabilities
end

When(/^I update the history form$/) do
  fill_in 'InputDescription', with: "Descripcion de la historia"
  fill_in 'InputLiabilities', with: "Estos son los compromisos"
  page.find("#InputSubmit").click
end

Then(/^I should see the history updated$/) do
  expect(page).to have_css "#history-show-page"

  expect(page).to have_css "#descripcionhistoria", text: "Descripcion de la historia"
  expect(page).to have_css "#compromisos", text: "Estos son los compromisos"
end

When(/^I fill history update form with invalid parameters$/) do
  fill_in 'InputDescription', with: ""
  fill_in 'InputDate', with: ""
  fill_in 'InputTime', with: ""
  page.find("#InputSubmit").click
end

Then(/^I should see the errors in the update history form$/) do
  
end


When(/^I click the remove button in history view$/) do
  @historia = History.first
  page.find("#remove-history-btn").click
  page.driver.browser.switch_to.alert.accept
end

Then(/^I should see history list$/) do
  expect(page).to have_css "#list_histories" 
end

Then(/^I should see a history destroy message$/) do
  expect(page).to have_css ".leo-message", text: "¡Historia borrada satisfactoriamente!"
end