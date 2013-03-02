@wip
Feature: restore backuped files

  I got a fresh system
  In order to restore all my backuped files
  I can use `dotbox restore`

  Scenario: restore all backuped files
    Given an empty file named "dropbox/Apps/Dotbox/files/foo/bar"
    Given a directory named "dropbox/Apps/Dotbox/directories/baz/bar"
    When I run `dotbox restore`
    Then a link named "foo/bar" should exist
    And the link named "foo/bar" should be a link of "dropbox/Apps/Dotbox/files/foo/bar"
    And a link named "baz" should exist
    And the link named "baz" should be a link of "dropbox/Apps/Dotbox/directories/baz"

