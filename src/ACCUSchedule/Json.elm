module ACCUSchedule.Json exposing (..)

import ACCUSchedule.Days as Days
import ACCUSchedule.Types as Types
import Json.Decode exposing (andThen, Decoder, fail, int, list, maybe, string, succeed)
import Json.Decode.Pipeline exposing (decode, optional, required)


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


session : Decoder Types.Session
session =
    let
        decoder s =
            case s of
                "session_1" ->
                    succeed Types.Session1

                "session_2" ->
                    succeed Types.Session2

                "session_3" ->
                    succeed Types.Session3

                _ ->
                    fail ("invalid session" ++ s)
    in
        string |> andThen decoder


quickieSlot : Decoder Types.QuickieSlot
quickieSlot =
    let
        decode s =
            case s of
                "slot_1" ->
                    succeed Types.QuickieSlot1

                "slot_2" ->
                    succeed Types.QuickieSlot2

                "slot_3" ->
                    succeed Types.QuickieSlot3

                "slot_4" ->
                    succeed Types.QuickieSlot4

                _ ->
                    fail ("invalid quickie slot: " ++ s)
    in
        string |> andThen decode


room : Decoder Types.Room
room =
    let
        decode s =
            case s of
                "bristol_suite" ->
                    succeed Types.BristolSuite

                "bristol_1" ->
                    succeed Types.Bristol1

                "bristol_2" ->
                    succeed Types.Bristol2

                "bristol_3" ->
                    succeed Types.Bristol3

                "empire" ->
                    succeed Types.Empire

                "great_britain" ->
                    succeed Types.GreatBritain

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


presenterDecoder : Decoder Types.Presenter
presenterDecoder =
    decode Types.Presenter
        |> required "id" int
        |> required "first_name" string
        |> required "last_name" string


proposalDecoder : Decoder Types.Proposal
proposalDecoder =
    decode Types.Proposal
        |> required "id" int
        |> required "title" string
        |> required "text" string
        |> required "presenters" (list presenterDecoder)
        |> required "day" day
        |> required "session" session
        |> optional "quickie_slot" (maybe quickieSlot) Nothing
        |> required "room" room



-- |> required "track" track
