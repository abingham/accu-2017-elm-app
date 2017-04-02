Feature: Bookmarking proposals

  Scenario: Agenda is empty if there are no bookmarks
    Given we clear all bookmarks
    Then the agenda has 0 proposals
