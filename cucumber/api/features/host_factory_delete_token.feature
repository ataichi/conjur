@logged-in
Feature: Delete (revoke) a host factory token.

Background:
  Given I create a new user "alice"
  And a host factory for layer "the-layer"
  And a host factory token

  Scenario: Unauthorized users cannot delete host factory tokens.
    When I DELETE "/host_factory_tokens/@host_factory_token_token@"
    Then the HTTP response status code is 404

    Given I permit user "alice" to "execute" it
    When I login as "alice"
    And I DELETE "/host_factory_tokens/@host_factory_token_token@"
    Then the HTTP response status code is 403

  Scenario: "delete" privilege on the host factory allows a user to delete 
    tokens.

    Given I permit user "alice" to "update" it
    When I login as "alice"
    Then I can DELETE "/host_factory_tokens/@host_factory_token_token@"

  Scenario: Once the token has been deleted, subsequent attempts return 404 Not Found.

    Given I permit user "alice" to "update" it
    When I login as "alice"
    And I can DELETE "/host_factory_tokens/@host_factory_token_token@"
    And I DELETE "/host_factory_tokens/@host_factory_token_token@"
    Then the HTTP response status code is 404
