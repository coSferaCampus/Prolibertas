@javascript
Feature: Logout
  As an user
  I want to logout
  In order to exit from the platform

  Scenario: Logout
  Given I am loged in like user
  When I click the logout icon
  Then I should be in login page