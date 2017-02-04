module ACCUSchedule.Msg exposing (..)

import ACCUSchedule.Types as Types
import Http
import Material


type Msg
    = ProposalsResult (Result Http.Error (List Types.Proposal))
    | SelectTab Int
    | Mdl (Material.Msg Msg)
