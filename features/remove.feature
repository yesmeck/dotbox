Feature: remove a file from dotbox

  As a user
  I want to remove a file from dotbox

  @announce
  Scenario: remove a not exist file
    When I run `dotbox remove not_exist_file`
    Then the stdout should contain "not exist"

  @announce
  Scenario: remove a backuped file
    Given a backuped file named "foo/bar"
    When I run `dotbox remove foo/bar`
    Then a file named "dropbox/Apps/Dotbox/files/foo/bar" should not exist
    And the file named "foo/bar" should not be a link
