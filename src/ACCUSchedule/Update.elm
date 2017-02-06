module ACCUSchedule.Update exposing (update)

import ACCUSchedule.Msg as Msg
import ACCUSchedule.Model exposing (Model)
import ACCUSchedule.Routing as Routing
import ACCUSchedule.Storage as Storage
import Material
import Navigation
import Return exposing (command, singleton)


update : Msg.Msg -> Model -> (Model, Cmd Msg.Msg)
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

        Msg.VisitProposal proposal ->
            let
                url = "#/session/" ++ toString proposal.id
            in
                (model, Navigation.newUrl url)

        Msg.ToggleStarred id ->
            let
                starred =
                    if List.member id model.starred then
                        List.filter (\pid -> pid /= id) model.starred
                    else
                        id :: model.starred
            in
                -- TODO: Store the new starred array via the port
                {model | starred = starred } ! [Storage.store starred]

        Msg.UrlChange location ->
            { model | location = Routing.parseLocation location } ! []

        Msg.SelectTab idx ->
            { model | selectedTab = idx } ! []

        Msg.Mdl mdlMsg ->
            Material.update Msg.Mdl mdlMsg model
