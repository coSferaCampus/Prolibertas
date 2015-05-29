@javascript
Feature: Edit article
  As an user
  I want to edit article
  In order to update data

Background:
  Given There are 1 person in the platform
  Given There are 3 articles of this person
  Given I am loged in like user
  Given I click the view icon of a person in people list view
  Given I click the articles tab of the person
  Given I click the view icon of an article in articles list view

Scenario: Visit edit form
  When I click the edit article button
  Then I should see the edit form article
  And I should see the article information in the form

Scenario: update article form
  Given I click the edit article button
  When I update the article form
  Then I should see the article updated
