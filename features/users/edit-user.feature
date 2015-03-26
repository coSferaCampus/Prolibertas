@javascript
Feature: Edit user
  As an director
  I want to edit user
  In order to update data

  Background:
    Given There is 3 user in the platform
    And I am loged in like director
    And I go to users list page
    And I click the view icon of a user in users list view

  Scenario: Visit edit form
    When I click the edit button
    Then I should see the edit form user
    And I should see the user information in the form