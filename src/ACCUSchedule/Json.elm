module ACCUSchedule.Json exposing (..)

import ACCUSchedule.Types as Types


-- import Http

import Json.Decode exposing (andThen, Decoder, fail, int, list, maybe, string, succeed)
import Json.Decode.Pipeline exposing (decode, optional, required)


day : Decoder Types.Day
day =
    let
        decoder s =
            case s of
                "workshops" ->
                    succeed Types.Workshops

                "day_1" ->
                    succeed Types.Day1

                "day_2" ->
                    succeed Types.Day2

                "day_3" ->
                    succeed Types.Day3

                "day_4" ->
                    succeed Types.Day4

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
        |> required "track" track



-- {-| Convert an HTTP error to human-readable string.
-- -}
-- errorToString : Http.Error -> String
-- errorToString err =
--     case err of
--         Http.UnexpectedPayload msg ->
--             msg
--         Http.NetworkError ->
--             "Network error"
--         Http.Timeout ->
--             "Timeout"
--         Http.BadResponse i r ->
--             r
-- suggestionDecoder : Decoder Types.Suggestion
-- suggestionDecoder =
--     decode Types.Suggestion
--         |> required "source_url" string
--         |> required "download_url" string
--         |> required "file_id" string
--         |> required "timestamp" string
-- -- Decodes the JSON response from a conversion request into an `Output`.
-- convertDecoder : Decoder Types.StatusLocator
-- convertDecoder =
--     decode Types.StatusLocator
--         |> required "file_id" string
--         |> required "status_url" string
-- statusDecoder : Types.FileID -> Types.URL -> Decoder Types.ConversionDetails
-- statusDecoder file_id status_url =
--     ("status" := string) `andThen` (conversionDetailsDecoder file_id status_url)
-- conversionDetailsDecoder : Types.FileID -> Types.URL -> String -> Decoder Types.ConversionDetails
-- conversionDetailsDecoder file_id status_url status =
--     case status of
--         "in-progress" ->
--             decode
--                 (\ts msg ->
--                     let
--                         locator =
--                             Types.StatusLocator file_id status_url
--                         details =
--                             Types.InProgressDetails ts msg locator
--                     in
--                         Types.InProgress details
--                 )
--                 |> required "timestamp" string
--                 |> required "status_msg" string
--         "complete" ->
--             decode
--                 (\ts dl ->
--                     let
--                         locator =
--                             Types.StatusLocator file_id status_url
--                         details =
--                             Types.CompleteDetails locator ts dl
--                     in
--                         Types.Complete details
--                 )
--                 |> required "timestamp" string
--                 |> required "download_url" string
--         "error" ->
--             decode Types.Error
--                 |> required "status_msg" string
--         _ ->
--             let
--                 msg =
--                     "Unknown status code: " ++ toString status
--                 details =
--                     Types.Error msg
--             in
--                 succeed details
