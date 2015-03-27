@javascript
Feature: User Profile
  As an user
  I want to see the current user profile
  In order to change this password

  Background:
    Given I am loged in like director

  Scenario: Open profile view
    When I click the head icon in the layout
    Then I should go to a view of my profile

  Scenario: Change own password
    When I change my password
    Then I should see my password changed