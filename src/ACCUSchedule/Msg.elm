module ACCUSchedule.Msg exposing (..)

import Material


type Msg
    = SelectTab Int
    | Mdl (Material.Msg Msg)
