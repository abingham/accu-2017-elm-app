module ACCUSchedule exposing (..)

import ACCUSchedule.Comms as Comms
import ACCUSchedule.Model exposing (..)
import ACCUSchedule.Msg exposing (..)
import ACCUSchedule.Types exposing (ProposalId)
import ACCUSchedule.Update exposing (update)
import ACCUSchedule.View exposing (view)
import Material
import Navigation


type alias Flags =
    { bookmarks : List ProposalId
    , apiBaseUrl : String
    }


main : Program Flags Model Msg
main =
    Navigation.programWithFlags UrlChange
        { init =
            \flags loc ->
                let
                    model =
                        initialModel flags.apiBaseUrl flags.bookmarks loc
                in
                    ( model
                    , Cmd.batch
                        [ Material.init Mdl
                        , Comms.fetchProposals model
                        , Comms.fetchPresenters model
                        ]
                    )
        , view = view
        , update = update
        , subscriptions = Material.subscriptions Mdl
        }
