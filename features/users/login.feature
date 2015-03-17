@javascript
Feature: Login
  As an user
  I want to login
  In order to use the platform

  Scenario: Invalid login
    Given I visit login page
    When I fill user login form with invalid parameters
    Then I should see message to say that name and password are invalid

  Scenario: Valid login
    Given I visit login page
    When I fill user login form with valid parameters
    Then I should be in home info page
  
  Scenario: User not registered
    When I visit home page
    Then I should to be in login page
