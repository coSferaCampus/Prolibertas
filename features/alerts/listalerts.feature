@javascript
Feature: Alerts
  As an user
  I want to see person alerts list
  In order to display all data of alerts of this person

  Scenario: Alerts list
    Given There are 1 person in the platform
    Given There are 3 alerts of this person
    Given I am loged in like user
    Given I click the view icon of a person in people list view
    When I click the alerts tab of the person
    Then I should see the list of the alerts
