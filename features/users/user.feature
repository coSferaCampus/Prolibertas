@javascript
Feature: User Show
  As an user
  I want to see one user page
  In order to display all data of this user

  Background:
    Given There are 3 workers users in the platform
    And I am loged in like director
    And I go to users list page

  Scenario: Open user view
    When I click the view icon of a user in users list view
    Then I should go to a view of this user

  Scenario: Remove user
    When I click the remove button in users view
    Then I should remove this user
    And  I should see a success message