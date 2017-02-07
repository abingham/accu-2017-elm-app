module ACCUSchedule.Update exposing (update)

import ACCUSchedule.Msg as Msg
import ACCUSchedule.Model exposing (Model)
import ACCUSchedule.Routing as Routing
import ACCUSchedule.Storage as Storage
import Material
import Navigation


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

        Msg.ToggleBookmark id ->
            let
                bookmarks =
                    if List.member id model.bookmarks then
                        List.filter (\pid -> pid /= id) model.bookmarks
                    else
                        id :: model.bookmarks
            in
                -- TODO: Store the new bookmarks array via the port
                {model | bookmarks = bookmarks } ! [Storage.store bookmarks]

        Msg.UrlChange location ->
            { model | location = Routing.parseLocation location } ! []

        Msg.Mdl mdlMsg ->
            Material.update Msg.Mdl mdlMsg model
