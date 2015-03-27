@javascript
Feature: Edit History
  As an user
  I want to edit history
  In order to edit one history

  Background: 
   Given There are 1 person in the platform
   Given There are 3 histories of this person
   Given I am loged in like user
   Given I click the view icon of a person in people list view
   Given I click the histories tab of the person
   Given I click the view icon of a history in history list view
   Given I should go to a view of this history