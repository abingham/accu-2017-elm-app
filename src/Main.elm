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
                ( initialModel flags.bookmarks loc
                , Cmd.batch
                    [ Material.init Mdl
                    , Comms.fetchProposals (flags.apiBaseUrl ++ "/proposals/api/scheduled_proposals")
                    , Comms.fetchPresenters (flags.apiBaseUrl ++ "/proposals/api/presenters")
                    ]
                )
        , view = view
        , update = update
        , subscriptions = Material.subscriptions Mdl
        }
