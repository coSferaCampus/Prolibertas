@javascript
Feature: Alert Show
  As an user
  I want to see one alert page
  In order to display all data of this alert this person

  Background:
    Given There are 1 person in the platform
    Given There are 3 alerts of this person
    Given I am loged in like director
    Given I click the view icon of a person in people list view
    Given I click the alerts tab of the person

  Scenario: Open alert view
    When I click the view icon of an alert in alerts list view
    Then I should go to a view of this alert

  Scenario: Remove alert
    Given I click the view icon of an alert in alerts list view
    When I click the remove button in alert view
    Then I should remove this alert
    And I should see a success message of delete alert
