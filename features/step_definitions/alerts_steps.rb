Given(/^There (?:are|is) (\d+) (?:alerts|alert) of this person$/) do |amount|
  persona_con_alertas = Person.first
  FactoryGirl.create_list(:alert, amount.to_i, person: persona_con_alertas)
end

#Test para ver la lista de alertas
When(/^I click the alerts tab of the person$/) do
  page.find("#person__alerts").click
end

Then(/^I should see the list of the alerts$/) do
  expect(page).to have_css "#alertsTable"
  Person.first.alerts.each do |alert|
    expect(page).to have_css "tr#alert_#{alert.id} td:nth-child(1)", text:
      if alert.type == :punishment
        "castigo"
      elsif alert.type == :warning
        "advertencia"
      elsif alert.type == :advice
        "consejo"
      end
    expect(page).to have_css "tr#alert_#{alert.id} td:nth-child(2)", text: alert.description
    expect(page).to have_css "tr#alert_#{alert.id} td:nth-child(3)", text: alert.cause
    expect(page).to have_css "tr#alert_#{alert.id} td:nth-child(4)", text: alert.pending.strftime("%Y-%m-%d")
  end
end

#Test para ver una alerta
When(/^I click the view icon of an alert in alerts list view$/) do
  @persona = Person.first
  @alerta = Alert.where(person: @persona).first
  page.find("#alert-show-#{@alerta.id}").click
end

Then(/^I should go to a view of this alert$/) do
  expect(page).to have_css "#alert-show-page"
end

#Test para crear alerta
When(/^I click the new alert button$/) do
  page.find("#nuevaAlerta").click
end

Then(/^I visit new alert form page$/) do
  expect(page).to have_css "#alertForm"
end

When(/^I fill alert form with valid parameters$/) do
parametros = FactoryGirl.attributes_for(:alert)
  if parametros[:type] == :punishment
    select('castigo', from: 'InputType')
  elsif parametros[:type] == :warning
    select('advertencia', from: 'InputType')
  elsif parametros[:type] == :advice
    select('consejo', from: 'InputType')
  end
  fill_in 'InputDescription', with: parametros[:description]
  fill_in 'InputCause', with: parametros[:cause]
  fill_in 'InputPending', with: parametros[:pending].strftime('%d/%m/%Y')
  click_button 'InputSubmit'
end

Then(/^I should see the new alert in alerts list$/) do
  expect(page).to have_css "#alertsTable"

  alert = Alert.last
  expect(page).to have_css "tr#alert_#{alert.id} td:nth-child(1)", text:
    if alert.type == :punishment
      "castigo"
    elsif alert.type == :warning
      "advertencia"
    elsif alert.type == :advice
      "consejo"
    end
  expect(page).to have_css "tr#alert_#{alert.id} td:nth-child(2)", text: alert.description
  expect(page).to have_css "tr#alert_#{alert.id} td:nth-child(3)", text: alert.cause
  expect(page).to have_css "tr#alert_#{alert.id} td:nth-child(4)", text: alert.pending.strftime("%Y-%m-%d")

end

Then(/^I should see alert created message$/) do
  expect(page).to have_css ".leo-message", text:"¡Ha creado satisfactoriamente una nueva alerta!"
end

#Test para errores de formulario
When(/^I fill alert form with invalid parameters$/) do
parametros = FactoryGirl.attributes_for(:alert)
  fill_in 'InputDescription', with: parametros[:description]
  fill_in 'InputCause', with: parametros[:cause]
  click_button 'InputSubmit'
end

Then(/^I should see the errors in the alert form$/) do
  expect(page).to have_css ".has-error #InputType"
  expect(page).to have_css "#InputType ~ .tooltip", text: I18n.t('mongoid.errors.messages.inclusion')
  expect(page).to have_css ".has-error #InputPending"
  expect(page).to have_css "#InputPending ~ .tooltip", text: I18n.t('mongoid.errors.messages.blank')
end

When(/^I fill input "(.*?)" with valid parameters$/) do |arg1|
parametros = FactoryGirl.attributes_for(:alert)
  if parametros[:type] == :punishment
    select('castigo', from: 'InputType')
  elsif parametros[:type] == :warning
    select('advertencia', from: 'InputType')
  elsif parametros[:type] == :advice
    select('consejo', from: 'InputType')
  end
end

#Test para borrar alerta
When(/^I click the remove button in alert view$/) do
  persona = Person.first
  alert = Alert.where(person: persona).first
  page.find("#remove-alert-btn").click
  page.driver.browser.switch_to.alert.accept
end

Then(/^I should remove this alert$/) do
  persona = Person.first
  alert = Alert.where(person: persona).first
  expect(page).to_not have_css "tr#alert_#{alert.id}"
end

Then(/^I should see a success message of delete alert$/) do
  expect(page).to have_css ".leo-message", text:"¡Borrada satisfactoriamente!"
end

#Test de editar alerta
When(/^I click the edit alert button$/) do
  page.find("#edit_alert_button").click
end

Then(/^I should see the edit form alert$/) do
  expect(page).to have_css "#alertForm"
end

Then(/^I should see the alert information in the form$/) do
  find_field('InputType').value.should eq @alerta.type.to_s
  find_field('InputDescription').value.should eq @alerta.description
  find_field('InputCause').value.should eq @alerta.cause
  find_field('InputPending').value.should eq @alerta.pending.to_s
end

When(/^I update the alert form$/) do
  select('advertencia', from: 'InputType')
  fill_in 'InputDescription', with: "Tuvo un problema"
  fill_in 'InputCause', with: "Por el turno"
  page.find("#InputSubmit").click
end

Then(/^I should see the alert updated$/) do
  expect(page).to have_css "#alert-show-page"

  expect(page).to have_css "#alert_type", text: "advertencia"
  expect(page).to have_css "#alert_description", text: "Tuvo un problema"
  expect(page).to have_css "#alert_cause", text: "Por el turno"
end

When(/^I fill alert update form with invalid parameters$/) do
  select('Seleccione Tipo', from: 'InputType')
  fill_in 'InputPending', with: ""
  page.find("#InputSubmit").click
end

Then(/^I should see the errors in the update alert form$/) do
  expect(page).to have_css ".has-error #InputType"
  expect(page).to have_css "#InputType ~ .tooltip", text: I18n.t('mongoid.errors.messages.inclusion')
  expect(page).to have_css ".has-error #InputPending"
  expect(page).to have_css "#InputPending ~ .tooltip", text: I18n.t('mongoid.errors.messages.blank')
end

#Test para los colores de la lita de alertas
Given(/^I have the following alerts$/) do |table|
  persona = FactoryGirl.create(:person)
  table.hashes.each do |hash|
    alert = FactoryGirl.create(
    :alert, type: hash['tipo'], person: persona)
  end
end

Then(/^I should see colours over alerts$/) do
  persona = Person.first
  persona.alerts.each do |alerta|
    if alerta.type == :punishment
      expect(page).to have_css "tr#alert_#{alerta.id}.danger"
    elsif alerta.type == :warning
      expect(page).to have_css "tr#alert_#{alerta.id}.warning"
    elsif alerta.type == :advice
      expect(page).to have_css "tr#alert_#{alerta.id}.success"
    end
  end
end
