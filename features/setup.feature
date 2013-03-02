Feature: setup dotbox

  This is my first time to use dotbox
  So I want to setup it

  @announce
  Scenario: setup dotbox
    Given a directory named "dropbox"
    When I run `dotbox setup` interactively
    And I type "dropbox"
    Then a file named ".dotbox" should exist
    And the file ".dotbox" should contain exactly:
    """
    dropbox
    """
