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

  Scenario: Visit edit user form 
    When I click the edit user button
    Then I should see the edit user form
    And I should see the user information in the user form

  Scenario: Update user form
    When I update the user form
    Then I should see the user updated

  Scenario: Update user form with no text
    When I fill user update form with invalid parameters
    Then I should see the errors in the update user form