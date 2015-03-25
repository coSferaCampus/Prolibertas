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
    expect(page).to have_css "tr#history_#{history.id} td:nth-child(1)", text:history.description
    expect(page).to have_css "tr#history_#{history.id} td:nth-child(2)", text:history.liabilities
    expect(page).to have_css "tr#history_#{history.id} td:nth-child(3)", text:history.date.strftime("%Y-%m-%d")
    expect(page).to have_css "tr#history_#{history.id} td:nth-child(4)", text:history.time
  end
end