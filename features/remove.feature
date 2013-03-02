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
    And a file named "dropbox/Apps/Dotbox/foo" should not exist
    And a file named "foo/bar" should exist
    And the file named "foo/bar" should not be a link
    And the record file should not contain "foo/bar"

  @announce
  Scenario: remove a backuped directory
    Given a backuped directory named "foo/bar"
    When I run `dotbox remove foo/bar`
    Then a directory named "dropbox/Apps/Dotbox/foo/bar" should not exist
    And a directory named "dropbox/Apps/Dotbox/foo" should not exist
    And a directory named "foo/bar" should exist
    And the directory named "foo/bar" should not be a link
    And the record file should not contain "foo/bar"

  @announce
  Scenario: remove a backuped file in which directory has two files
    Given a backuped file named "foo/bar"
    And a backuped file named "foo/baz"
    When I run `dotbox remove foo/bar`
    Then a file named "dropbox/Apps/Dotbox/foo/bar" should not exist
    And a file named "dropbox/Apps/Dotbox/foo/baz" should exist
    And a file named "foo/bar" should exist
    And the file named "foo/bar" should not be a link
    And the record file should not contain "foo/bar"
    And the record file should contain "foo/baz" => "file"

