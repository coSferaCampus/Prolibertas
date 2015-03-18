Given(/^There are (\d+) people in the platform$/) do |amount|
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

