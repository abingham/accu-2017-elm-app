module ACCUSchedule.Update exposing (update)

import ACCUSchedule.Msg as Msg
import ACCUSchedule.Model exposing (Model)
import Material
import Return exposing (command, map, Return, return, singleton, zero)


update : Msg.Msg -> Model -> Return Msg.Msg Model
update msg model =
    case msg of
        Msg.ProposalsResult (Ok proposals) ->
            { model | proposals = proposals } ! []

        Msg.ProposalsResult (Err msg) ->
            let
                x =
                    Debug.log "err" msg
            in
                -- TODO: display error message or something...maybe a button for
                -- re-fetching the proposals.
                model ! []

        Msg.SelectTab idx ->
            { model | selectedTab = idx } ! []

        Msg.Mdl mdlMsg ->
            Material.update Msg.Mdl mdlMsg model
