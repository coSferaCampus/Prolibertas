Given(/^There (?:are|is) (\d+) (?:alerts|alert) of this person$/) do |amount|
  persona_con_alertas = Person.first
  FactoryGirl.create_list(:alert, amount.to_i, person: persona_con_alertas)
end

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
