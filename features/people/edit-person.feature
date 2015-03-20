@javascript
Feature: Edit person
  As an user
  I want to edit person
  In order to update data

Background:
  Given There is 1 person in the platform
  Given I am loged in like user
  Given I click the view icon of a person in people list view
  Given I should go to a view of this person

Scenario: Visit edit form
  When I click the edit button
  Then I should see the edit form person
  And I should see the person information in the form

Scenario: edit update form
  When I edit the form
  Then I should see the person updated