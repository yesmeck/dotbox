Feature: remove a file from dotbox

  As a user
  I want to remove a file from dotbox

  @announce
  Scenario: remove a not exist file
    When I run `dotbox remove not_exist_file`
    Then the stdout should contain "not exist"

  @announce
  Scenario: remove a not backuped file
    Given an empty file named "foo/bar"
    When I run `dotbox remove foo/bar`
    Then the stdout should contain "not backuped"

  @announce
  Scenario: remove a backuped file
    Given a backuped file named "foo/bar"
    When I run `dotbox remove foo/bar`
    Then a file named "dropbox/Apps/Dotbox/foo/bar" should not exist
    Then a file named "dropbox/Apps/Dotbox/foo" should not exist
    And a file named "foo/bar" should exist
    And the file named "foo/bar" should not be a link

  @announce
  Scenario: remove a backuped directory
    Given a backuped directory named "foo/bar"
    When I run `dotbox remove foo/bar`
    Then a directory named "dropbox/Apps/Dotbox/foo/bar" should not exist
    And a directory named "dropbox/Apps/Dotbox/foo" should not exist
    And a directory named "foo/bar" should exist
    And the directory named "foo/bar" should not be a link
