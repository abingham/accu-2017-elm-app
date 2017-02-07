module ACCUSchedule exposing (..)

import ACCUSchedule.Comms as Comms
import ACCUSchedule.Model exposing (..)
import ACCUSchedule.Msg exposing (..)
import ACCUSchedule.Types exposing (ProposalId)
import ACCUSchedule.Update exposing (update)
import ACCUSchedule.View exposing (view)
import Material
import Navigation


main : Program (List ProposalId) Model Msg
main =
    Navigation.programWithFlags UrlChange
        { init =
            \bookmarks loc ->
                ( initialModel bookmarks loc
                , Cmd.batch
                    [ Material.init Mdl
                    , Comms.fetchProposals
                    ]
                )
        , view = view
        , update = update
        , subscriptions = Material.subscriptions Mdl
        }
