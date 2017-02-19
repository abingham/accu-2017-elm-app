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
