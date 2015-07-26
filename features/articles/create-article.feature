@javascript
Feature: Create article
  As an user
  I want to create people
  In order to add to articles list

  Background:
    Given There are 1 person in the platform
    Given There are 3 articles of this person
    Given I am loged in like user
    Given I click the view icon of a person in people list view
    Given I click the articles tab of the person
    Given I click the new articles button

  Scenario: Articles form
    Then I visit new articles form page

  Scenario: Parameters ok
    When I fill article form with valid parameters
    Then I should see the new article in articles list
    And  I should see article created message

  Scenario: Error parameters
    When I fill article form with invalid parameters
    Then I should see the errors in the article form

  Scenario: Correct error parameters on InputType
    When I fill article form with invalid parameters
    And  I fill input "InputType" with "chaqueta"
    Then I should not see error on "InputType"

  Scenario: Correct error parameters on InputRequested
    When I fill article form with invalid parameters
    And  I fill input "InputRequested" with "20/03/2016"
    Then I should not see error on "InputRequested"
