module ACCUSchedule exposing (..)

import ACCUSchedule.Comms as Comms
import ACCUSchedule.Model as Model
import ACCUSchedule.Msg as Msg
import ACCUSchedule.Update exposing (update)
import ACCUSchedule.View exposing (view)
import Material
import Navigation


main =
    Navigation.programWithFlags Msg.UrlChange
        { init =
            \starred loc ->
                ( Model.initialModel starred loc
                , Cmd.batch
                    [ Material.init Msg.Mdl
                    , Comms.fetchProposals
                    ]
                )
        , view = view
        , update = update
        , subscriptions = Material.subscriptions Msg.Mdl
        }
