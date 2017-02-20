module ACCUSchedule.Types.Sessions exposing (..)

type Session
    = Session1
    | Session2
    | Session3


toString : Session -> String
toString session =
    case session of
        Session1 ->
            "Session 1"

        Session2 ->
            "Session 2"

        Session3 ->
            "Session 3"


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
