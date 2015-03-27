@javascript
Feature: People
  As an user
  I want to see people list
  In order to assign services to people

  Scenario: People list
    Given There are 3 people in the platform
    And I am loged in like user
    Then I should see the list of the people

  Scenario: Show alert
    Given I have the following people
      | nombre | apellidos | origen | alerta |
      | Joao | Coelho | Portugal | punishment |
      | Luis | Mohamed | Marruecos | |
      | Pepe | Reina | España | warning |
      | Baúl | González | Chiquitistán | advice |

    And I am loged in like user
    Then I should see colours over people that have any alert