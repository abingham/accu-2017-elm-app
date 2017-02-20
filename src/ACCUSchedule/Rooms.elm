module ACCUSchedule.Rooms exposing (..)


type Room
    = BristolSuite
    | Bristol1
    | Bristol2
    | Bristol3
    | Empire
    | GreatBritain


toString : Room -> String
toString room =
    case room of
        BristolSuite ->
            "Bristol Suite"

        Bristol1 ->
            "Bristol 1"

        Bristol2 ->
            "Bristol 2"

        Bristol3 ->
            "Bristol 3"

        Empire ->
            "Empire"

        GreatBritain ->
            "Great Britain"


ordinal : Room -> Int
ordinal r =
    case r of
        BristolSuite ->
            0

        Bristol1 ->
            1

        Bristol2 ->
            2

        Bristol3 ->
            3

        Empire ->
            4

        GreatBritain ->
            5
