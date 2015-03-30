@javascript
Feature: Create alert
  As an user
  I want to create people
  In order to add to alerts list

  Background:
    Given There are 1 person in the platform
    Given There are 3 alerts of this person
    Given I am loged in like user
    Given I click the view icon of a person in people list view
    Given I click the alerts tab of the person
    Given I click the new alert button

  Scenario: Alert form
    Then I visit new alert form page

  Scenario: Parameters ok
    When I fill alert form with valid parameters
    Then I should see the new alert in alerts list
    And  I should see alert created message

  Scenario: Error parameters
    When I fill alert form with invalid parameters
    Then I should see the errors in the alert form

  Scenario: Correct error parameters on InputType
    When I fill alert form with invalid parameters
    And  I fill input "InputType" with "consejo"
    Then I should not see error on "InputType"

  Scenario: Correct error parameters on InputPending
    When I fill alert form with invalid parameters
    And  I fill input "InputPending" with "InputPending"
    Then I should not see error on "InputPending"