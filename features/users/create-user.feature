@javascript
Feature: Create user
  As an user
  I want to create users
  In order to add to users list

  Background: 
    Given I am loged in like director
    And I go to users list page
    And I visit new person page

  Scenario: Parameters ok
    When I fill user form with valid parameters
    Then I should see the new user in users list
    And  I should see user created message



