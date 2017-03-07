module ACCUSchedule.Types exposing (..)

import ACCUSchedule.Types.Days exposing (Day)
import ACCUSchedule.Types.QuickieSlots exposing (QuickieSlot)
import ACCUSchedule.Types.Rooms exposing (Room)
import ACCUSchedule.Types.Sessions exposing (Session)


type Track
    = CppTrack
    | OtherTrack


type alias PresenterId =
    Int


type alias ProposalId =
    Int


type alias Presenter =
    { id : PresenterId
    , firstName : String
    , lastName : String
    , bio : String
    , country : String
    , state : String
    }


type alias Proposal =
    { id : ProposalId
    , title : String
    , text : String
    , presenters : List PresenterId
    , day : Day
    , session : Session
    , quickieSlot : Maybe QuickieSlot
    , room : Room
    , raised : Bool
    }
