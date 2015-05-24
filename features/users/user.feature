@javascript
Feature: User Show
  As an user
  I want to see one user page
  In order to display all data of this user

  Background:
    Given There are 3 workers users in the platform
    And I am loged in like director
    And I go to users list page

  Scenario: Open user view
    When I click the view icon of a user in users list view
    Then I should go to a view of this user

  Scenario: Remove user
    When I click the remove button in users view
    Then I should remove this user
    And  I should see a remove user success message

  Scenario: Not view users tab
    Given There is 1 volunteer user in the platform
    And There is no user sesion
    When I am loged in like volunteer
    Then I cannot view users tab

  Scenario: Volunteer tabs
    Given There is 1 person in the platform
    Given There is 1 volunteer user in the platform
    And There is no user sesion
    When I am loged in like volunteer
    And I click the view icon of a person in people list view
    Then I should go to a view of this person
    And I shouldn't view history tab and alerts tab