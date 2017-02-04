module ACCUSchedule exposing (..)

import ACCUSchedule.Comms as Comms
import ACCUSchedule.Model as Model
import ACCUSchedule.Msg as Msg
import ACCUSchedule.Update exposing (update)
import ACCUSchedule.View exposing (view)
import Html
import Material


main : Program Never Model.Model Msg.Msg
main =
    Html.program
        { init = (Model.initialTestModel, Cmd.batch [Material.init Msg.Mdl, Comms.fetchProposals])
        , view = view
        , update = update
        , subscriptions = Material.subscriptions Msg.Mdl
        }
