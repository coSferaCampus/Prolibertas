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
    person = FactoryGirl.create(
    :person, name: hash['nombre'],
    surname: hash['apellidos'], origin: hash['origen']
    )

    %w( comida ducha ropa).each do | service_name |
      if hash[service_name] == 'true'
        service = Service.where(name: service_name).first
        FactoryGirl.create(:used_service, person: person, service: service)
      end
    end

    if hash['alerta'].present?
      FactoryGirl.create(:alert, person: person, type: hash['alerta'])
    end

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
#eliminar persona
When(/^I click the remove button in people view$/) do
  @persona = Person.first
  page.find("#person-show-#{@persona.id}").click
  page.find("#remove-person-btn").click
  page.driver.browser.switch_to.alert.accept
end

# Remove person
Then(/^I should remove this person$/) do
  expect(page).to_not have_css "#person-show-#{@persona.id}"
end

Then(/^I should see a success message$/) do
  expect(page).to have_css ".leo-message", text:"¡Borrado satisfactoriamente!"
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
  if key == 'InputGenre' || key == 'InputType'
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
 expect(page).to have_css "#personform"
end

Then(/^I should see the person information in the form$/) do
  @person = Person.first
  find_field('InputName').value.should eq @person.name
  find_field('InputSurname').value.should eq @person.surname
  find_field('InputNif').value.should eq @person.nif
  find_field('InputGenre').value.should eq @person.genre.to_s
  find_field('InputSocialServices').value.should eq @person.social_services
  find_field('InputPhone').value.should eq @person.phone
  find_field('InputOrigin').value.should eq @person.origin
  find_field('InputMenu').value.should eq @person.menu
  find_field('InputAssistance').value.should eq @person.assistance
  find_field('InputIncome').value.should eq @person.income
  find_field('InputHome').value.should eq @person.home
  find_field('InputAddress').value.should eq @person.address
  find_field('InputFamilyStatus').value.should eq @person.family_status
  find_field('InputContactFamily').value.should eq @person.contact_family
  find_field('InputHealthStatus').value.should eq @person.health_status
  find_field('InputNotes').value.should eq @person.notes
end


When(/^I update the form$/) do
  @person = Person.first
  page.find("#person-edit-#{@person.id}").click
  fill_in 'InputName', with: "pepe"
  fill_in 'InputSurname', with: "gonzalez"
  fill_in 'InputNif', with: "23423423s"
  fill_in 'InputSocialServices', with: "prolibertas"
  fill_in 'InputPhone', with: "345345343"
  fill_in 'InputOrigin', with: "congo"
  fill_in 'InputMenu', with: "musulman"
  fill_in 'InputAssistance', with: "asiste muchisimo"
  fill_in 'InputIncome', with: "ninguno"
  fill_in 'InputHome', with: "debajo del puente"
  fill_in 'InputAddress', with: "lo mismo"
  fill_in 'InputFamilyStatus', with: "ninguno"
  fill_in 'InputContactFamily', with: "ninguna persona"
  fill_in 'InputHealthStatus', with: "esta genial"
  fill_in 'InputNotes', with: "este hombre es un maquina"
  page.find("#InputSubmit").click
end

Then(/^I should see the person updated$/) do
  expect(page).to have_css "#person-edit-#{@person.id}"
  expect(page).to have_css "#person_name", text: "pepe"
  expect(page).to have_css "#person_surname", text: "gonzalez"
  expect(page).to have_css "#person_nif", text: "23423423s"
  expect(page).to have_css "#person_social", text: "prolibertas"
  expect(page).to have_css "#person_phone", text: "345345343"
  expect(page).to have_css "#person_origin", text: "congo"
  expect(page).to have_css "#person_menu", text: "musulman"
  expect(page).to have_css "#person_assistance", text: "asiste muchisimo"
  expect(page).to have_css "#person_income", text: "ninguno"
  expect(page).to have_css "#person_home", text: "debajo del puente"
  expect(page).to have_css "#person_address", text: "lo mismo"
  expect(page).to have_css "#person_family", text: "ninguno"
  expect(page).to have_css "#person_contact", text: "ninguna persona"
  expect(page).to have_css "#person_health", text: "esta genial"
  expect(page).to have_css "#person_notes", text: "este hombre es un maquina"
end

# Test para los errores del formulario
When(/^I fill person update form with invalid parameters$/) do
  @person = Person.first
  page.find("#person-edit-#{@person.id}").click
  fill_in 'InputName', with: ""
  fill_in 'InputSurname', with: ""
  page.find("#InputSubmit").click
end


Then(/^I should see the errors in the update form$/) do
  expect(page).to have_css ".has-error #InputName"
  expect(page).to have_css "#InputName ~ .tooltip", text:  I18n.t('mongoid.errors.messages.blank')
  expect(page).to have_css ".has-error #InputSurname"
  expect(page).to have_css "#InputSurname ~ .tooltip", text: I18n.t('mongoid.errors.messages.blank')
end


# Test para asignar servicios
# Test que comprueba que comida está marcada
Then(/^I see "(.*?)" has food checked$/) do |apellido|
  persona = Person.where(surname: apellido).first
  expect(page).to have_checked_field("comida_#{persona.id}")
end

Then(/^I see "(.*?)" has food unchecked$/) do |apellido|
  persona = Person.where(surname: apellido).first
  expect(page).to have_unchecked_field("comida_#{persona.id}")
end

#Test que comprueba que ropa está marcada
Then(/^I see "(.*?)" has clothes checked$/) do |apellido|
  persona = Person.where(surname: apellido).first
  expect(page).to have_checked_field("ropa_#{persona.id}")
end

Then(/^I see "(.*?)" has clothes unchecked$/) do |apellido|
  persona = Person.where(surname: apellido).first
  expect(page).to have_unchecked_field("ropa_#{persona.id}")
end

#Test que comprueba que ducha está marcada
Then(/^I see "(.*?)" has shower checked$/) do |apellido|
  persona = Person.where(surname: apellido).first
  expect(page).to have_checked_field("ducha_#{persona.id}")
end

Then(/^I see "(.*?)" has shower unchecked$/) do |apellido|
  persona = Person.where(surname: apellido).first
  expect(page).to have_unchecked_field("ducha_#{persona.id}")
end


# Test cuando selecciono comida
When(/^I select service food for "(.*?)"$/) do |apellido|
  persona = Person.where(surname: apellido).first
  check("comida_#{persona.id}")
end

Then(/^I see that it has created a new use for food service for "(.*?)"$/) do |apellido|
  persona = Person.where(surname: apellido).first
  page.driver.browser.navigate.refresh
  expect(page).to have_checked_field("comida_#{persona.id}")
end

#Test cuando selecciono ropa
When(/^I select service clothes for "(.*?)"$/) do |apellido|
  persona = Person.where(surname: apellido).first
  check("ropa_#{persona.id}")
end

Then(/^I see that it has created a new use for clothes service for "(.*?)"$/) do |apellido|
  persona = Person.where(surname: apellido).first
  page.driver.browser.navigate.refresh
  expect(page).to have_checked_field("ropa_#{persona.id}")
end

#Test cuando selecciono ducha
When(/^I select service shower for "(.*?)"$/) do |apellido|
  persona = Person.where(surname: apellido).first
  check("ducha_#{persona.id}")
end

Then(/^I see that it has created a new use for shower service for "(.*?)"$/) do |apellido|
  persona = Person.where(surname: apellido).first
  page.driver.browser.navigate.refresh
  expect(page).to have_checked_field("ducha_#{persona.id}")
end

# Alertas en la lista de personas 

Then(/^I should see colours over people that have any alert$/) do
  Person.each do |persona|
    alerta = persona.alerts.first
    if alerta 
      if alerta.type == :punishment
        expect(page).to have_css "tr#person_#{persona.id}.danger"
      elsif alerta.type == :warning
        expect(page).to have_css "tr#person_#{persona.id}.warning"
      elsif alerta.type == :advice
        expect(page).to have_css "tr#person_#{persona.id}.success"
      end
    else 
      expect(page).to have_css "tr#person_#{persona.id}"
    end
  end
end
