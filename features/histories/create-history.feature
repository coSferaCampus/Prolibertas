@javascript
Feature: Create History
  As an user
  I want to create history
  In order to add to histories list

  Background: 
   Given There are 1 person in the platform
   Given There are 3 histories of this person
   Given I am loged in like user
   Given I click the view icon of a person in people list view
   Given I click the histories tab of the person
   Given I visit new history page

  Scenario: Parameters ok
   When I fill history form with valid parameters
   Then I should see the new history in histories list
   And  I should see history created message

  Scenario: Error parameters
    When I fill history form with invalid parameters
    Then I should see the errors in the history form

  Scenario: Correct error parameters on InputDescription
    When I fill history form with invalid parameters
    And  I fill input "InputDescription" with "Description"
    Then I should not see error on "InputDescription"
