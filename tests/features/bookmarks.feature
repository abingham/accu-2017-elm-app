Feature: Bookmarking proposals

  Scenario: Agenda is empty if there are no bookmarks
    When we visit the agenda
    And we clear all bookmarks
    Then there are 0 proposals displayed

  Scenario: Agenda includes bookmarked proposals
    Given we visit the agenda
    And we clear all bookmarks
    When we visit the view for day 1
    And we bookmark 1 proposal(s)
    Then we visit the view for day 2
    And we bookmark 1 proposal(s)
    Then we visit the view for day 3
    And we bookmark 1 proposal(s)
    When we visit the agenda
    Then there are 3 proposals displayed
    And 3 proposals are bookmarked
