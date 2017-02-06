port module ACCUSchedule.Storage exposing (..)

import ACCUSchedule.Types as Types

-- port for saving "starred" proposals
port store : List Types.ProposalId -> Cmd msg
