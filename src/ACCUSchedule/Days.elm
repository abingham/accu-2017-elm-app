module ACCUSchedule.Days exposing (..)

import ACCUSchedule.Types as Types


ordinal : Types.Day -> Int
ordinal day =
    case day of
        Types.Workshops ->
            0

        Types.Day1 ->
            1

        Types.Day2 ->
            2

        Types.Day3 ->
            3

        Types.Day4 ->
            4


toString : Types.Day -> String
toString day =
    case day of
        Types.Workshops ->
            "Workshop"

        Types.Day1 ->
            "Tuesday"

        Types.Day2 ->
            "Wednesday"

        Types.Day3 ->
            "Thursday"

        Types.Day4 ->
            "Friday"

{-| The days to display in the app
-}
conferenceDays : List Types.Day
conferenceDays =
    [ Types.Day1, Types.Day2, Types.Day3, Types.Day4 ]
