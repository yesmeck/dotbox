Feature: add file to dropbox

  In order backup the file
  As a user
  I want to add the file to dropbox and link it back

  Scenario: add a not exist file
    When I run `backbox add not_exist_file`
    Then the stdout should contain "not exist"

  Scenario: add a exists file
    Given an empty file named "foo/bar/example"
    When I run `backbox add foo/bar/example`
    Then a file named "dropbox/Apps/Backbox/foo/bar/example" should exist

