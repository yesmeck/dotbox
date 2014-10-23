Feature: add file to dropbox

  In order to backup the file
  As a user
  I want to add the file to dropbox and link it back

  @announce
  Scenario: add a not exists file
    When I run `dotbox add not_exist_file`
    Then the stdout should contain "not exist"

  @announce
  Scenario: add a exists file
    Given an empty file named "foo/bar"
    When I run `dotbox add foo/bar`
    Then a file named "dropbox/Apps/Dotbox/foo/bar" should exist
    And the link named "foo/bar" should be a link of "dropbox/Apps/Dotbox/foo/bar"
    And the record file should contain "foo/bar" => "file"

  @announce
  Scenario: add a directory
    Given a directory named "foo/bar"
    Given an empty file named "foo/bar/example"
    When I run `dotbox add foo/bar`
    Then a directory named "dropbox/Apps/Dotbox/foo/bar"
    And a directory named "dropbox/Apps/Dotbox/foo/bar" should exist
    And the link named "foo/bar" should be a link of "dropbox/Apps/Dotbox/foo/bar"
    And the record file should contain "foo/bar" => "directory"

  @announce
  Scenario: add multi-files
    Given an empty file named "foo/bar"
    Given an empty file named "foo/baz"
    When I run `dotbox add foo/bar foo/baz`
    Then a file named "dropbox/Apps/Dotbox/foo/bar" should exist
    And the link named "foo/bar" should be a link of "dropbox/Apps/Dotbox/foo/bar"
    And the record file should contain "foo/bar" => "file"
    And a file named "dropbox/Apps/Dotbox/foo/baz" should exist
    And the link named "foo/baz" should be a link of "dropbox/Apps/Dotbox/foo/baz"
    And the record file should contain "foo/baz" => "file"

  @announce
  Scenario: add file using pattern
    Given an empty file named "foo/bar"
    Given an empty file named "foo/baz"
    When I run `dotbox add foo/*`
    Then a file named "dropbox/Apps/Dotbox/foo/bar" should exist
    And the link named "foo/bar" should be a link of "dropbox/Apps/Dotbox/foo/bar"
    And the record file should contain "foo/bar" => "file"
    And a file named "dropbox/Apps/Dotbox/foo/baz" should exist
    And the link named "foo/baz" should be a link of "dropbox/Apps/Dotbox/foo/baz"
    And the record file should contain "foo/baz" => "file"

  @announce
  Scenario: add a file twice
    Given a backup file named "foo/bar"
    Given an empty file named "foo/bar"
    When I run `dotbox add foo/bar`
    Then the stdout should contain "foo/bar has been backuped."

