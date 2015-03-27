@javascript
Feature: Create person
  As an user
  I want to create people
  In order to add to people list

  Background: 
    Given I am loged in like user
    And I visit new person page

  Scenario: Parameters ok
    When I fill person form with valid parameters
    Then I should see the new person in people list
    And  I should see person created message

  Scenario: Error parameters
    When I fill person form with invalid parameters
    Then I should see the errors in the form

  Scenario: Correct error parameters on InputName
    When I fill person form with invalid parameters
    And  I fill input "InputName" with "Name"
    Then I should not see error on "InputName"
@wip
  Scenario: Correct error parameters on InputSurname
    When I fill person form with invalid parameters
    And  I fill input "InputSurname" with "Surname"
    Then I should not see error on "InputSurname"

  Scenario: Correct error parameters on InputGenre
    When I fill person form with invalid parameters
    And  I fill input "InputGenre" with "Hombre"
    Then I should not see error on "InputGenre"


