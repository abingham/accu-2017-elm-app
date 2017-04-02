Feature: Day view

  Scenario Outline: Day view shows only talks from the right day
     Given we visit the view for day <day>
     Then <count> proposal cards are displayed
     And all proposals are for day <day>

    Examples: Days
      | day | count |
      |   1 |     4 |
      |   2 |     4 |
      |   3 |     4 |
      |   4 |     4 |
