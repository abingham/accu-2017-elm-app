Feature: Day view

  Scenario: Day view shows only talks from the right day
     Given we visit the Wednesday day view
     Then 15 proposal cards are displayed
     And all proposals are for Wednesday
