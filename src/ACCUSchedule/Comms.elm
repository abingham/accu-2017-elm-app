module ACCUSchedule.Comms exposing (..)

{-| High-level API for talking to the schedule server.

# Commands
@docs TODO
-}

import ACCUSchedule.Json as Json
import ACCUSchedule.Msg as Msg
import Json.Decode exposing (list)
import Http


fetchProposals : Cmd Msg.Msg
fetchProposals =
    let
        -- TODO: We need to get this URL through configuration or something, I guess.
        url =
            "http://localhost:4000/proposals/api/scheduled_proposals"

        request =
            Http.get url (list Json.proposalDecoder)
    in
        Http.send Msg.ProposalsResult request
