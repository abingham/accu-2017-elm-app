Feature: Day view

  Scenario: Day view shows only talks from the right day
     Given we visit the view for day 1
     Then 2 proposal cards are displayed
     And all proposals are for day 1
