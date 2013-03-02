Feature: add file to dropbox

  In order backup the file
  As a user
  I want to add the file to dropbox and link it back

  @announce
  Scenario: add a not exist file
    When I run `backbox add not_exist_file`
    Then the stdout should contain "not exist"

  @announce
  Scenario: add a exists file
    Given an empty file named "foo/bar"
    When I run `backbox add foo/bar`
    Then a file named "dropbox/Apps/Backbox/files/foo/bar" should exist
    And the file named "foo/bar" should be a link of "dropbox/Apps/Backbox/files/foo/bar"

  @announce
  Scenario: add a directory
    Given a directory named "foo/bar"
    Given an empty file named "foo/bar/example"
    When I run `backbox add foo/bar`
    Then a directory named "dropbox/Apps/Backbox/directories/foo/bar"
    And a file named "dropbox/Apps/Backbox/directories/foo/bar/example" should exist
    And the directory named "foo/bar" should be a link of "dropbox/Apps/Backbox/directories/foo/bar"

