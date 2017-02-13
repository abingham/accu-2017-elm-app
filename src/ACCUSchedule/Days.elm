module ACCUSchedule.Days exposing (..)

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
            "Tuesday"

        Day2 ->
            "Wednesday"

        Day3 ->
            "Thursday"

        Day4 ->
            "Friday"

{-| The days to display in the app
-}
conferenceDays : List Day
conferenceDays =
    [ Day1, Day2, Day3, Day4 ]
