@javascript
Feature: Search
  As an user
  I want to see one person page
  In order to display all data of this person

  Background: 
    Given I am loged in like user

  Scenario: Open person view
    When I click the view icon of a person in people list view
    Then I should go to a view of this person