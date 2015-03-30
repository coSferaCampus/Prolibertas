@javascript
Feature: Edit History
  As an user
  I want to edit history
  In order to edit one history

  Background: 
   Given There are 1 person in the platform
   Given There are 3 histories of this person
   Given I am loged in like user
   Given I click the view icon of a person in people list view
   Given I click the histories tab of the person
   Given I click the view icon of a history in histories list view

  Scenario: Visit edit form
   When I click the edit history button
   Then I should see the edit form history
   And I should see the history information in the form

  Scenario: update alert form
   Given I click the edit history button
   When I update the history form
   Then I should see the history updated

  Scenario: Update alert form with no text
   Given I click the edit history button
   When I fill history update form with invalid parameters
   Then I should see the errors in the update history form

  