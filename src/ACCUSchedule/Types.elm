module ACCUSchedule.Types exposing (..)



type Day
    = Workshops
    | Day1
    | Day2
    | Day3
    | Day4


type Session
    = Session1
    | Session2
    | Session3


type QuickieSlot
    = QuickieSlot1
    | QuickieSlot2
    | QuickieSlot3
    | QuickieSlot4


type Room
    = BristolSuite
    | Bristol1
    | Bristol2
    | Bristol3
    | Empire
    | GreatBritain


type Track
    = CppTrack
    | OtherTrack


type alias Presenter =
    { id : Int
    , firstName : String
    , lastName : String
    }


type alias Proposal =
    { id : Int
    , title : String
    , text : String
    , presenters : List Presenter
    , day : Day
    , session : Session
    , quickieSlot : Maybe QuickieSlot
    , room : Room
    }
