@javascript
Feature: Assign service
  As an user
  I want to assign service to person
  In order to know that services are used by a person or family

  Background:
    Given I have the following people
      | nombre | apellidos | origen | comida | ropa | ducha |
      | Joao | Coelho | Portugal | true | true | false |
      | Luis | Mohamed | Marruecos | false | false | true |
      | Pepe | Reina | España |  true | false | false |

    Given I am loged in like user

Scenario: See used services for food checked
  Then I see "Coelho" has food checked
  And I see "Mohamed" has food unchecked
  And I see "Reina" has food checked

Scenario: See used services for clothes checked
  Then I see "Coelho" has clothes checked
  And I see "Mohamed" has clothes unchecked
  And I see "Reina" has clothes unchecked

Scenario: See used services for shower checked
  Then I see "Coelho" has shower unchecked
  And I see "Mohamed" has shower checked
  And I see "Reina" has shower unchecked

@wip
Scenario: Choose service food

  When I select service food for "Mohamed"
  Then I see that it has created a new use for food service for "Mohamed"



Scenario: Choose service clothes

  When I select service clothes for "Mohamed"
  Then I see that it has created a new use for clothes service for "Mohamed"

Scenario: Choose service shower

  When I select service shower for "Reina"
  Then I see that it has created a new use for shower service for "Reina"
