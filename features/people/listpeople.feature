@javascript
Feature: People
  As an user
  I want to see people list
  In order to assign services to people

  Scenario: People list
    Given There are 3 people in the platform
    Given I am loged in like user
    Then I should see the list of the people
