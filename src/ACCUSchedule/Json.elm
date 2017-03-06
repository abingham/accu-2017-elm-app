module ACCUSchedule.Json exposing (..)

import ACCUSchedule.Types as Types
import ACCUSchedule.Types.Days as Days
import ACCUSchedule.Types.QuickieSlots as QuickieSlots
import ACCUSchedule.Types.Rooms as Rooms
import ACCUSchedule.Types.Sessions as Sessions
import Json.Decode exposing (andThen, Decoder, fail, int, list, maybe, string, succeed)
import Json.Decode.Pipeline exposing (decode, hardcoded, optional, required)
import List


day : Decoder Days.Day
day =
    let
        decoder s =
            case s of
                "workshops" ->
                    succeed Days.Workshops

                "day_1" ->
                    succeed Days.Day1

                "day_2" ->
                    succeed Days.Day2

                "day_3" ->
                    succeed Days.Day3

                "day_4" ->
                    succeed Days.Day4

                _ ->
                    fail ("invalid day: " ++ s)
    in
        string |> andThen decoder


session : Decoder Sessions.Session
session =
    let
        decoder s =
            case s of
                "session_1" ->
                    succeed Sessions.Session1

                "session_2" ->
                    succeed Sessions.Session2

                "session_3" ->
                    succeed Sessions.Session3

                _ ->
                    fail ("invalid session" ++ s)
    in
        string |> andThen decoder


quickieSlot : Decoder QuickieSlots.QuickieSlot
quickieSlot =
    let
        decode s =
            case s of
                "slot_1" ->
                    succeed QuickieSlots.Slot1

                "slot_2" ->
                    succeed QuickieSlots.Slot2

                "slot_3" ->
                    succeed QuickieSlots.Slot3

                "slot_4" ->
                    succeed QuickieSlots.Slot4

                _ ->
                    fail ("invalid quickie slot: " ++ s)
    in
        string |> andThen decode


room : Decoder Rooms.Room
room =
    let
        decode s =
            case s of
                "bristol_suite" ->
                    succeed Rooms.BristolSuite

                "bristol_1" ->
                    succeed Rooms.Bristol1

                "bristol_2" ->
                    succeed Rooms.Bristol2

                "bristol_3" ->
                    succeed Rooms.Bristol3

                "empire" ->
                    succeed Rooms.Empire

                "great_britain" ->
                    succeed Rooms.GreatBritain

                _ ->
                    fail ("invalid room: " ++ s)
    in
        string |> andThen decode


track : Decoder Types.Track
track =
    let
        decode s =
            case s of
                "cpp" ->
                    succeed Types.CppTrack

                "other" ->
                    succeed Types.OtherTrack

                _ ->
                    fail ("invalid track: " ++ s)
    in
        string |> andThen decode


listDecoder : Decoder a -> Decoder (List a)
listDecoder dec =
    let
        removeFailures =
            List.foldl
                (\m l ->
                    case m of
                        Just p ->
                            p :: l

                        Nothing ->
                            l
                )
                []
                >> succeed
    in
        list (maybe dec) |> andThen removeFailures


presenterDecoder : Decoder Types.Presenter
presenterDecoder =
    decode Types.Presenter
        |> required "id" int
        |> required "first_name" string
        |> required "last_name" string
        |> required "bio" string


{-| Decode a list of Presenters, taking care to dispose of invalid presenters that
may have come from the server.
-}
presentersDecoder : Decoder (List Types.Presenter)
presentersDecoder =
    listDecoder presenterDecoder


proposalDecoder : Decoder Types.Proposal
proposalDecoder =
    decode Types.Proposal
        |> required "id" int
        |> required "title" string
        |> required "text" string
        |> required "presenters" (list int)
        |> required "day" day
        |> required "session" session
        |> optional "quickie_slot" (maybe quickieSlot) Nothing
        |> required "room" room
        |> hardcoded False


{-| Decode a list of Proposals, taking care to dispose of invalid proposals that
may have come from the server.
-}
proposalsDecoder : Decoder (List Types.Proposal)
proposalsDecoder =
    listDecoder proposalDecoder



-- |> required "track" track
