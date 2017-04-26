module ACCUSchedule.Types.Sessions exposing (..)

type Session
    = Session1
    | Session2
    | Session3


toString : Session -> String
toString session =
    case session of
        Session1 ->
            "11:00"

        Session2 ->
            "14:00"

        Session3 ->
            "16:00"


ordinal : Session -> Int
ordinal s =
    case s of
        Session1 ->
            1

        Session2 ->
            2

        Session3 ->
            3


conferenceSessions : List Session
conferenceSessions =
    [ Session1, Session2, Session3 ]
