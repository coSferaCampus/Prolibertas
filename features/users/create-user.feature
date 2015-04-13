@javascript
Feature: Create user
  As an user
  I want to create users
  In order to add to users list

  Background: 
    Given I am loged in like director
    And I go to users list page

  Scenario: Parameters ok
    When I fill user form with valid parameters
    Then I should see the new user in users list
    And  I should see user created message

  Scenario: Error parameters
    When I fill user form with invalid parameters
    Then I should see tooltips for errors in create user form

  Scenario: Correct error parameters on InputName
    When I fill user form with invalid parameters
    And  I fill input "InputName" with "Name"
    Then I should not see error on "InputName"

  Scenario: Correct error parameters on InputPassword
    When I fill user form with invalid parameters
    And  I fill input "InputPassword" with "Password"
    Then I should not see error on "InputPassword"

  Scenario: Correct error parameters on InputPassword_confirmation
    When I fill user form with invalid parameters
    And  I fill input "InputPassword" with "Password"
    And  I fill input "InputPassword_confirmation" with "Password"
    Then I should not see error on "InputPassword_confirmation"

  Scenario: Correct error parameters on InputFull_name
    When I fill user form with invalid parameters
    And  I fill input "InputFull_name" with "Full_name"
    Then I should not see error on "InputFull_name"