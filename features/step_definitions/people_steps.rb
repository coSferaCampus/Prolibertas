Given(/^There (?:are|is) (\d+) (?:people|person) in the platform$/) do |amount|
  FactoryGirl.create_list(:person, amount.to_i)
end

Then(/^I should see the list of the people$/) do
  expect(page).to have_css "#peopleTable"
  Person.each do |person|
    expect(page).to have_css "tr#person_#{person.id} td:nth-child(1)", text: person.name
    expect(page).to have_css "tr#person_#{person.id} td:nth-child(2)", text: person.surname
    expect(page).to have_css "tr#person_#{person.id} td:nth-child(3)", text: person.origin
    expect(page).to have_css "tr#person_#{person.id} td:nth-child(4)", text: 
      if person.genre == :man
        "H"
      else
        "M"
      end
    expect(page).to have_css "tr#person_#{person.id} td:nth-child(5)", text: person.menu
  end
end

Given(/^I have the following people$/) do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:person, name: hash['nombre'], surname: hash['apellidos'], origin: hash['origen'])
  end
end

When(/^I type "(.*?)" in the input surname search$/) do |surname|
  fill_in 'searchsurname', with: surname
end

Then(/^I should see the list of the people with "(.*?)" as surname$/) do |surname|
  Person.each do |person|  
    if surname == person.surname
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(1)", text: person.name
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(2)", text: person.surname
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(3)", text: person.origin
    else
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(1)", text: person.name
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(2)", text: person.surname
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(3)", text: person.origin
    end
  end
end

When(/^I type "(.*?)" in the input origin search$/) do |origin|
  fill_in 'searchorigin', with: origin
end

Then(/^I should see the list of the people with "(.*?)" as origin$/) do |origin|
  Person.each do |person|  
    if origin == person.origin
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(1)", text: person.name
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(2)", text: person.surname
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(3)", text: person.origin
    else
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(1)", text: person.name
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(2)", text: person.surname
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(3)", text: person.origin
    end
  end
end

Then(/^I should see the list of the people with "(.*?)" and "(.*?)" as surname and origin respectively$/) do |surname, origin|
  
  Person.each do |person|  
    if surname == person.surname and origin == person.origin
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(1)", text: person.name
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(2)", text: person.surname
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(3)", text: person.origin
    else
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(1)", text: person.name
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(2)", text: person.surname
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(3)", text: person.origin
    end
  end
end

# PERSON SHOW

When(/^I click the view icon of a person in people list view$/) do
  persona = Person.first 
  page.find("#person-show-#{persona.id}").click
end

Then(/^I should go to a view of this person$/) do
  expect(page).to have_css "#person-show-page"
end

When(/^I click the remove button in people view$/) do
  @persona = Person.first 
  page.find("#person-show-#{@persona.id}").click
  page.find("#remove-person-btn").click
  page.driver.browser.switch_to.alert.accept
end

Then(/^I should remove this person$/) do
  expect(page).to_not have_css "#person-show-#{@persona.id}"
end

# Test para Crear persona
Given(/^I visit new person page$/) do
  click_link 'createPerson'
end

When(/^I fill person form with valid parameters$/) do
  parametros = FactoryGirl.attributes_for(:person)
  fill_in 'InputName', with: parametros[:name]
  fill_in 'InputBirth', with: parametros[:birth]
  fill_in 'InputSurname', with: parametros[:surname]
  fill_in 'InputNif', with: parametros[:nif]
  if parametros[:genre] == :man
    select('Hombre', from: 'InputGenre')
  else
    select('Mujer', from: 'InputGenre')
  end
  fill_in 'InputSocialServices', with: parametros[:social_services]
  fill_in 'InputPhone', with: parametros[:phone]
  fill_in 'InputOrigin', with: parametros[:origin]
  fill_in 'InputMenu', with: parametros[:menu]
  fill_in 'InputAssistance', with: parametros[:assistance]
  fill_in 'InputIncome', with: parametros[:income]
  fill_in 'InputHome', with: parametros[:home]
  fill_in 'InputAddress', with: parametros[:address]
  fill_in 'InputFamilyStatus', with: parametros[:family_status]
  fill_in 'InputContactFamily', with: parametros[:contact_family]
  fill_in 'InputHealthStatus', with: parametros[:health_status]
  fill_in 'InputNotes', with: parametros[:notes]
  click_button 'InputSubmit'
end

Then(/^I should see the new person in people list$/) do
  expect(page).to have_css "#peopleTable"

  person = Person.last
  expect(page).to have_css "tr#person_#{person.id} td:nth-child(1)", text: person.name
  expect(page).to have_css "tr#person_#{person.id} td:nth-child(2)", text: person.surname
  expect(page).to have_css "tr#person_#{person.id} td:nth-child(3)", text: person.origin
  expect(page).to have_css "tr#person_#{person.id} td:nth-child(4)", text: 
    if person.genre == :man
      "H"
    else
      "M"
    end
  expect(page).to have_css "tr#person_#{person.id} td:nth-child(5)", text: person.menu  
end

Then(/^I should see person created message$/) do
  expect(page).to have_css ".leo-message", text:"¡Ha creado satisfactoriamente una nueva persona!"
end

# Test para los errores del formulario
When(/^I fill person form with invalid parameters$/) do
  parametros = FactoryGirl.attributes_for(:person)
  fill_in 'InputBirth', with: parametros[:birth]
  fill_in 'InputNif', with: parametros[:nif]
  fill_in 'InputSocialServices', with: parametros[:social_services]
  fill_in 'InputPhone', with: parametros[:phone]
  fill_in 'InputOrigin', with: parametros[:origin]
  fill_in 'InputMenu', with: parametros[:menu]
  fill_in 'InputAssistance', with: parametros[:assistance]
  fill_in 'InputIncome', with: parametros[:income]
  fill_in 'InputHome', with: parametros[:home]
  fill_in 'InputAddress', with: parametros[:address]
  fill_in 'InputFamilyStatus', with: parametros[:family_status]
  fill_in 'InputContactFamily', with: parametros[:contact_family]
  fill_in 'InputHealthStatus', with: parametros[:health_status]
  fill_in 'InputNotes', with: parametros[:notes]
  click_button 'InputSubmit'
end


Then(/^I should see the errors in the form$/) do
  expect(page).to have_css ".has-error #InputName"
  expect(page).to have_css "#InputName ~ .tooltip", text:  I18n.t('mongoid.errors.messages.blank')
  expect(page).to have_css ".has-error #InputSurname"
  expect(page).to have_css "#InputSurname ~ .tooltip", text: I18n.t('mongoid.errors.messages.blank')
  expect(page).to have_css ".has-error #InputGenre"
  expect(page).to have_css "#InputGenre ~ .tooltip", text: I18n.t('mongoid.errors.messages.inclusion')
end

When(/^I fill input "(.*?)" with "(.*?)"$/) do |key, value|
  if key == 'InputGenre'
   select(value, from: key)
   else
    fill_in key, with: value
  end
  click_button 'InputSubmit'  
end

Then(/^I should not see error on "(.*?)"$/) do |key|
  expect(page).to_not have_css "##{key} ~ .tooltip"

end

#Test de Editar persona

When(/^I click the edit button$/) do
  page.find(".persona__botones__edit").click
end

Then(/^I should see the edit form person$/) do
  person = Person.first 
  find_field('InputName').value.should eq person.name
  find_field('InputBirth').value.should eq person.birth
  find_field('InputSurname').value.should eq person.surname
  find_field('InputNif').value.should eq person.nif
  find_field('InputGenre').value.should eq person.genre
  find_field('InputSocialServices').value.should eq person.social_services
  find_field('InputPhone').value.should eq person.phone
  find_field('InputOrigin').value.should eq person.origin
  find_field('InputMenu').value.should eq person.menu
  find_field('InputAssistance').value.should eq person.assistance
  find_field('InputIncome').value.should eq person.income
  find_field('InputHome').value.should eq person.home
  find_field('InputAddress').value.should eq person.address
  find_field('InputFamilyStatus').value.should eq person.family_status
  find_field('InputContactFamily').value.should eq person.contact_family
  find_field('InputHealthStatus').value.should eq person.health_status
  find_field('InputNotes').value.should eq person.notes

end

Then(/^I should see the person information in the form$/) do
  pending # express the regexp above with the code you wish you had
end

