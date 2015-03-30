@javascript
Feature: Edit alert
  As an user
  I want to edit alert
  In order to update data

Background:
  Given There are 1 person in the platform
  Given There are 3 alerts of this person
  Given I am loged in like user
  Given I click the view icon of a person in people list view
  Given I click the alerts tab of the person
  Given I click the view icon of an alert in alerts list view

Scenario: Visit edit form
  When I click the edit alert button
  Then I should see the edit form alert
  And I should see the alert information in the form

Scenario: update alert form
  Given I click the edit alert button
  When I update the alert form
  Then I should see the alert updated

Scenario: Update alert form with no text
  Given I click the edit alert button
  When I fill alert update form with invalid parameters
  Then I should see the errors in the update alert form