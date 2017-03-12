module ACCUSchedule.Comms exposing (..)

{-| High-level API for talking to the schedule server.

# Commands
@docs TODO
-}

import ACCUSchedule.Json as Json
import ACCUSchedule.Model  exposing (Model)
import ACCUSchedule.Msg as Msg
import Http


fetchProposals : Model -> Cmd Msg.Msg
fetchProposals model =
    let
        url =
            model.apiBaseUrl ++ "/proposals/api/scheduled_proposals"
        request =
            Http.get url Json.proposalsDecoder
    in
        Http.send Msg.ProposalsResult request

fetchPresenters : Model -> Cmd Msg.Msg
fetchPresenters model =
    let
        url =
            model.apiBaseUrl ++ "/proposals/api/presenters"

        request =
            Http.get url Json.presentersDecoder
    in
        Http.send Msg.PresentersResult request
