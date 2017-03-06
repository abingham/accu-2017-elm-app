module ACCUSchedule.Comms exposing (..)

{-| High-level API for talking to the schedule server.

# Commands
@docs TODO
-}

import ACCUSchedule.Json as Json
import ACCUSchedule.Msg as Msg
import Http


fetchProposals : String -> Cmd Msg.Msg
fetchProposals url =
    let
        request =
            Http.get url Json.proposalsDecoder
    in
        Http.send Msg.ProposalsResult request

fetchPresenters : String -> Cmd Msg.Msg
fetchPresenters url =
    let
        request =
            Http.get url Json.presentersDecoder
    in
        Http.send Msg.PresentersResult request
