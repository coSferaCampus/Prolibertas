@javascript
Feature: Article Show
  As an user
  I want to see one article page
  In order to display all data of this article this person

  Background:
    Given There are 1 person in the platform
    Given There are 3 articles of this person
    Given I am loged in like director
    Given I click the view icon of a person in people list view
    Given I click the articles tab of the person

  Scenario: Articles list
   Then I should see the list of the articles

  Scenario: Open article view
    When I click the view icon of an article in articles list view
    Then I should go to a view of this article

  Scenario: Remove article
    Given I click the view icon of an article in articles list view
    When I click the remove button in article view
    Then I should remove this article
    And I should see a success message of delete article