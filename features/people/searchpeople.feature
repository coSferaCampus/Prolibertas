@javascript
Feature: Search
  As an user
  I want to search people
  In order to display data of a person

  Background:
    Given I have the following people
      | nombre | apellidos | origen | 
      | isa | gonzalez | españa |
      | javi | gonzalez | marruecos |
      | emilio | contreras | españa |
    Given I am loged in like user

  Scenario: Search person by surname
    When I type "gonzalez" in the input surname search
    Then I should see the list of the people with "gonzalez" as surname

  Scenario: Search person by origin
    When I type "marruecos" in the input origin search
    Then I should see the list of the people with "marruecos" as origin

  Scenario: Search person by surname and origin
    When I type "gonzalez" in the input surname search
    When I type "marruecos" in the input origin search
    Then I should see the list of the people with "gonzalez" and "marruecos" as surname and origin respectively
