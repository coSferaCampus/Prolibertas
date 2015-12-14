Given(/^There (?:are|is) (\d+) (?:people|person) in the platform$/) do |amount|
  FactoryGirl.create_list(:person, amount.to_i)
end

Then(/^I should see the list of the people$/) do
  expect(page).to have_css "#peopleTable"
  Person.each do |person|
    expect(page).to have_css "tr#person_#{person.id} td:nth-child(2)", text: person.name
    expect(page).to have_css "tr#person_#{person.id} td:nth-child(1)", text: person.surname
    expect(page).to have_css "tr#person_#{person.id} td:nth-child(3)", text: person.origin
    expect(page).to have_css "tr#person_#{person.id} td:nth-child(4)", text:
      if person.genre == :man
        "H"
      else
        "M"
      end
    expect(page).to have_css "tr#person_#{person.id} td:nth-child(6)", text: person.menu
  end
end

Given(/^I have the following people$/) do |table|
  table.hashes.each do |hash|
    person = FactoryGirl.create(
    :person, name: hash['nombre'],
    surname: hash['apellidos'], origin: hash['origen']
    )

    %w( comida ducha ropa desayuno).each do | service_name |
      if hash[service_name] == 'true'
        service = Service.where(name: service_name).first
        FactoryGirl.create(:used_service, person: person, service: service, created_at: Date.today )
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
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(2)", text: person.name
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(1)", text: person.surname
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(3)", text: person.origin
    else
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(2)", text: person.name
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(1)", text: person.surname
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
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(2)", text: person.name
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(1)", text: person.surname
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(3)", text: person.origin
    else
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(2)", text: person.name
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(1)", text: person.surname
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(3)", text: person.origin
    end
  end
end

Then(/^I should see the list of the people with "(.*?)" and "(.*?)" as surname and origin respectively$/) do |surname, origin|

  Person.each do |person|
    if surname == person.surname and origin == person.origin
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(2)", text: person.name
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(1)", text: person.surname
      expect(page).to have_css "tr#person_#{person.id} td:nth-child(3)", text: person.origin
    else
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(2)", text: person.name
      expect(page).to_not have_css "tr#person_#{person.id} td:nth-child(1)", text: person.surname
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

Then(/^I should see a remove person success message$/) do
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
  select('NIF', from: 'InputId_type')
  fill_in 'InputIdentifier', with: parametros[:identifier]
  if parametros[:genre] == :man
    select('Hombre', from: 'InputGenre')
  else
    select('Mujer', from: 'InputGenre')
  end
  select('0 - No', from: 'InputSocial_services')
  fill_in 'InputPhone', with: parametros[:phone]
  select(parametros[:origin], from: 'InputOrigin')
  fill_in 'InputMenu', with: parametros[:menu]
  within '#InputAssistance' do
    find("option[value='1']").click
  end
  fill_in 'InputIncome', with: parametros[:income]
  within '#InputAddress_type' do
    find("option[value='1']").click
  end
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
  expect(page).to have_css "tr#person_#{person.id}"
end

Then(/^I should see person created message$/) do
  expect(page).to have_css ".leo-message", text:"¡Ha creado satisfactoriamente una nueva persona!"
end

# Test para los errores del formulario
When(/^I fill person form with invalid parameters$/) do
  parametros = FactoryGirl.attributes_for(:person)
  fill_in 'InputBirth', with: parametros[:birth]
  select('NIF', from: 'InputId_type')
  fill_in 'InputIdentifier', with: parametros[:identifier]
  select('0 - No', from: 'InputSocial_services')
  fill_in 'InputPhone', with: parametros[:phone]
  select(parametros[:origin], from: 'InputOrigin')
  fill_in 'InputMenu', with: parametros[:menu]
  within '#InputAssistance' do
    find("option[value='1']").click
  end
  fill_in 'InputIncome', with: parametros[:income]
  within '#InputAddress_type' do
    find("option[value='1']").click
  end
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
  find_field('InputIdentifier').value.should eq @person.identifier
  find_field('InputGenre').value.should eq @person.genre.to_s
  find_field('InputPhone').value.should eq @person.phone
  find_field('InputMenu').value.should eq @person.menu

  if @person.origin == "españa"
    find_field('InputCity').value.should eq @person.city.to_s
    else
    find_field('InputOrigin').value.should eq @person.origin
  end
  find_field('InputIncome').value.should eq @person.income
  find_field('InputAssistance').value.should eq @person.assistance.to_s
  find_field('InputSocial_have_income').value.should eq @person.have_income.to_s
  find_field('InputIncome').value.should eq @person.income
  find_field('InputAddress_type').value.should eq @person.address_type.to_s
  find_field('InputAddress').value.should eq @person.address
  find_field('InputSocial_residence').value.should eq @person.residence.to_s
  find_field('InputFamilyStatus').value.should eq @person.family_status
  find_field('InputContactFamily').value.should eq @person.contact_family
  find_field('InputHealthStatus').value.should eq @person.health_status
  find_field('InputDocumentation').value.should eq @person.documentation.to_s
  find_field('InputSocial_services').value.should eq @person.social_services.to_s
  find_field('InputNotes').value.should eq @person.notes
end


When(/^I update the form$/) do
  @person = Person.first
  page.find("#person-edit-#{@person.id}").click
  fill_in 'InputName', with: "pepe"
  fill_in 'InputBirth', with: "1982-09-13"
  fill_in 'InputSurname', with: "gonzalez"
  select('NIF', from: 'InputId_type')
  fill_in 'InputIdentifier', with: "23423423s"
  select('Hombre', from: 'InputGenre')
  fill_in 'InputPhone', with: "345345343"
  select('Albania', from: 'InputOrigin')
  fill_in 'InputMenu', with: "musulman"
  select('0 - Primera vez', from: 'InputAssistance')
  select('0 - No', from: 'InputSocial_have_income')
  fill_in 'InputIncome', with: "ninguno"
  select('0 - Sin vivienda', from: 'InputAddress_type')
  select('0 - De paso', from: 'InputSocial_residence')
  fill_in 'InputAddress', with: "lo mismo"
  fill_in 'InputFamilyStatus', with: "ninguno"
  fill_in 'InputContactFamily', with: "ninguna persona"
  fill_in 'InputHealthStatus', with: "esta genial"
  select('0 - Indocumentado', from: 'InputDocumentation')
  select('0 - No', from: 'InputSocial_services')
  fill_in 'InputNotes', with: "este hombre es un maquina"
  page.find("#InputSubmit").click
end

Then(/^I should see the person updated$/) do
  expect(page).to have_css "#person-edit-#{@person.id}"
  expect(page).to have_css "#person_name", text: "pepe"
  expect(page).to have_css "#person_surname", text: "gonzalez"
  expect(page).to have_css "#person_genre", text: "Hombre"
  expect(page).to have_css "#person_identifier", text: "23423423s"
  expect(page).to have_css "#person_social_services", text: "No"
  expect(page).to have_css "#person_phone", text: "345345343"
  expect(page).to have_css "#person_origin", text: "Albania"
  expect(page).to have_css "#person_menu", text: "musulman"
  expect(page).to have_css "#person_assistance", text: "Primera vez"
  expect(page).to have_css "#person_have_income", text: "No"
  expect(page).to have_css "#person_income", text: "ninguno"
  expect(page).to have_css "#person_address_type", text: "Sin vivienda"
  expect(page).to have_css "#person_residence", text: "De paso"
  expect(page).to have_css "#person_address", text: "lo mismo"
  expect(page).to have_css "#person_family", text: "ninguno"
  expect(page).to have_css "#person_contact", text: "ninguna persona"
  expect(page).to have_css "#person_health", text: "esta genial"
  expect(page).to have_css "#person_documentation", text: "Indocumentado"
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

#Test que comprueba que desayuno está marcado
Then(/^I see "(.*?)" has desayuno checked$/) do |apellido|
  persona = Person.where(surname: apellido).first
  expect(page).to have_checked_field("desayuno_#{persona.id}")
end

Then(/^I see "(.*?)" has desayuno unchecked$/) do |apellido|
  persona = Person.where(surname: apellido).first
  expect(page).to have_unchecked_field("desayuno_#{persona.id}")
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

#Test cuando selecciono desayuno
When(/^I select service desayuno for "(.*?)"$/) do |apellido|
  persona = Person.where(surname: apellido).first
  check("desayuno_#{persona.id}")
end

Then(/^I see that it has created a new use for desayuno service for "(.*?)"$/) do |apellido|
  persona = Person.where(surname: apellido).first
  page.driver.browser.navigate.refresh
  expect(page).to have_checked_field("desayuno_#{persona.id}")
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
