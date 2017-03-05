module ACCUSchedule.Types.Days exposing (..)

type Day
    = Workshops
    | Day1
    | Day2
    | Day3
    | Day4


ordinal : Day -> Int
ordinal day =
    case day of
        Workshops ->
            0

        Day1 ->
            1

        Day2 ->
            2

        Day3 ->
            3

        Day4 ->
            4


toString : Day -> String
toString day =
    case day of
        Workshops ->
            "Workshop"

        Day1 ->
            "Wednesday"

        Day2 ->
            "Thursday"

        Day3 ->
            "Friday"

        Day4 ->
            "Saturday"

{-| The days to display in the app
-}
conferenceDays : List Day
conferenceDays =
    [ Day1, Day2, Day3, Day4 ]
