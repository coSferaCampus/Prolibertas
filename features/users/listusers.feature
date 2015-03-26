@javascript
Feature: Users
  As an user
  I want to see users list
  In order to process users

  Scenario: Users list
    Given There are 3 workers users in the platform
    Given I am loged in like director
    When I go to users list page
    Then I should see the list of all users