module ACCUSchedule.Comms exposing (..)

{-| High-level API for talking to the schedule server.

# Commands
@docs TODO
-}

import ACCUSchedule.Json as Json
import ACCUSchedule.Msg as Msg
import Json.Decode exposing (list)
import Http


fetchProposals : String -> Cmd Msg.Msg
fetchProposals url =
    let
        request =
            Http.get url (list Json.proposalDecoder)
    in
        Http.send Msg.ProposalsResult request
