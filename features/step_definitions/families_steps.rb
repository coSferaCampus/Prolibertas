# Index

Given(/^There are (\d+) families in the platform$/) do |amount|
  FactoryGirl.create_list(:family, amount.to_i)
end

When(/^I click the families button of the menu$/) do
  click_link 'go-families'
end

Then(/^I should see the list of the families$/) do
    expect(page).to have_css "#familiesTable"
end

# Create

Given(/^I click the new family button of the menu$/) do
  page.find("#createFamily").click
end

When(/^I fill family form with valid parameters$/) do
  parametros = FactoryGirl.attributes_for(:family)
  fill_in 'InputName', with: parametros[:name]
  fill_in 'InputSurname', with: parametros[:surname]
  fill_in 'InputAdults', with: parametros[:adults]
  fill_in 'InputChildren', with: parametros[:children]
  fill_in 'InputCenter', with: parametros[:center]
  click_button 'InputSubmit'
end

Then(/^I should see the new family in users list$/) do
  expect(page).to have_css "#familiesTable"

  family = Family.last
  expect(page).to have_css "tr#family_#{family.id} td:nth-child(1)", text: family.surname
  expect(page).to have_css "tr#family_#{family.id} td:nth-child(2)", text: family.name
end

Then(/^I should see family created message$/) do
  expect(page).to have_css ".leo-message", text:"¡Ha creado satisfactoriamente una nueva familia!"
end

# Show

When(/^I click the view icon of a family in families list view$/) do
  family = Family.first
  page.find("#family-show-#{family.id}").click
end

Then(/^I should go to a view of this family$/) do
  expect(page).to have_css "#family-show-page"
end

# Delete

When(/^I click the remove button in family view$/) do
  @family = Family.first
  page.find("#family-show-#{@family.id}").click
  page.find("#remove-family-btn").click
  page.driver.browser.switch_to.alert.accept
end

Then(/^I should remove this family$/) do
  expect(page).to_not have_css "#family-show-#{@family.id}"
end

Then(/^I should see a remove family success message$/) do
  expect(page).to have_css ".leo-message", text:"¡Familia borrada satisfactoriamente!"
end

# Update

When(/^I click the family edit button$/) do
  page.find(".persona__botones__edit").click
end

Then(/^I should see the family edit form$/) do
  expect(page).to have_css "#familyform"
end

When(/^I update the family form$/) do
  @family = Family.first
  page.find("#family-edit-#{@family.id}").click
  parametros = FactoryGirl.attributes_for(:family)
  fill_in 'InputName', with: "pepe"
  fill_in 'InputSurname', with: "gonzalez"
  fill_in 'InputAdults', with: parametros[:adults]
  fill_in 'InputChildren', with: parametros[:children]
  fill_in 'InputCenter', with: parametros[:center]
  click_button 'InputSubmit'
end

Then(/^I should see the family updated$/) do
  expect(page).to have_css "#family-edit-#{@family.id}"
  expect(page).to have_css "#family_name", text: "pepe"
  expect(page).to have_css "#family_surname", text: "gonzalez"
end

When(/^I fill person update family form with invalid parameters$/) do
   @family = Family.first
  page.find("#family-edit-#{@family.id}").click
  fill_in 'InputName', with: ""
  fill_in 'InputSurname', with: ""
  click_button 'InputSubmit'
end
