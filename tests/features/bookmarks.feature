Feature: Bookmarking proposals

  Scenario: Agenda is empty if there are no bookmarks
    Given we clear all bookmarks
    Then the agenda has 0 proposals

  @wip
  Scenario: Agenda includes bookmarked proposals
    Given we clear all bookmarks
    When we visit the view for day 1
    And we bookmark 1 proposal(s)
    Then we visit the view for day 2
    And we bookmark 1 proposal(s)
    Then we visit the view for day 3
    And we bookmark 1 proposal(s)
    Then the agenda has 3 proposals
    And all agenda proposals are bookmarked
