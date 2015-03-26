@javascript
Feature: Histories
 As an user
 I want to see person histories list
 In order to display all data of histories of this person

 Background:
   Given There are 1 person in the platform
   Given There are 3 histories of this person
   Given I am loged in like user
   Given I click the view icon of a person in people list view
   When I click the histories tab of the person

 Scenario: Histories list
   Then I should see the list of the histories

  Scenario: Open history view
    When I click the view icon of a history in histories list view
    Then I should go to a view of this history