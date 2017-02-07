port module ACCUSchedule.Storage exposing (..)

import ACCUSchedule.Types as Types

-- port for saving "bookmarked" proposals
port store : List Types.ProposalId -> Cmd msg
