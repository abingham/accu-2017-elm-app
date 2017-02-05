module ACCUSchedule.Comms exposing (..)

{-| High-level API for talking to the schedule server.

# Commands
@docs TODO
-}

import ACCUSchedule.Json as Json
import ACCUSchedule.Msg as Msg
-- import ACCUSchedule.Types as Types
import Json.Decode exposing (list)
-- import Json.Encode
import Http
-- import Platform.Cmd exposing (Cmd)
-- import Task

fetchProposals : Cmd Msg.Msg
fetchProposals =
    let
        -- TODO: We need to get this URL through configuration or something, I guess.
        url =
            "http://localhost:4000/proposals/api/scheduled_proposals"

        request = Http.get url (list Json.proposalDecoder)

    in
        Http.send Msg.ProposalsResult request




-- Process the result of submitting a Types.URL for conversion.
--
-- This results in a `HandleCompletion` action which will be handled
-- separately.
-- {"status_msg": "in progress", "status": 1, "file_id": "1c186f0a-7db5-11e6-8f7c-34363bc75ac6", "url": "w3.org/Talks/Tools/Slidy", "timestamp": "2016-09-18T17:32:29.529000"}


-- {-| Submit a URL for conversion.
-- -}
-- submitUrl : Types.URL -> Platform.Cmd.Cmd Msg.Msg
-- submitUrl presentationUrl =
--     let
--         url =
--             Http.url "/convert" []

--         bodyObj =
--             Json.Encode.object [ ( "url", Json.Encode.string presentationUrl ) ]

--         body =
--             (Http.string (Json.Encode.encode 2 bodyObj))

--         task =
--             Http.post
--                 Json.convertDecoder
--                 url
--                 body
--     in
--         Task.perform
--             (Json.errorToString >> Msg.SubmissionError presentationUrl)
--             (Msg.SubmissionSuccess presentationUrl)
--             task


-- {-| Get suggestions for a partial URL.
-- -}
-- getSuggestions : Types.URL -> Cmd Msg.Msg
-- getSuggestions source_url =
--     let
--         url =
--             Http.url "/suggestions" [ ( "url", source_url ) ]

--         task =
--             Http.get (list Json.suggestionDecoder) url
--     in
--         Task.perform
--             (Json.errorToString >> Msg.SuggestionsError source_url)
--             (Msg.SuggestionsSuccess source_url)
--             task
