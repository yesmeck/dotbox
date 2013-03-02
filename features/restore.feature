Feature: restore backuped files

  I got a fresh system
  In order to restore all my backuped files
  I can use `dotbox restore`

  @announce
  Scenario: restore all backuped files
    Given a backup file named "foo/bar"
    Given a backup directory named "baz/bar"
    When I run `dotbox restore`
    Then a link named "foo/bar" should exist
    And the link named "foo/bar" should be a link of "dropbox/Apps/Dotbox/foo/bar"
    And a link named "baz/bar" should exist
    And the link named "baz/bar" should be a link of "dropbox/Apps/Dotbox/baz/bar"

