module ACCUSchedule.Msg exposing (..)

import ACCUSchedule.Types as Types
import Http
import Material
import Navigation


type Msg
    = ProposalsResult (Result Http.Error (List Types.Proposal))
    | VisitProposal Types.Proposal
    | ToggleStarred Types.ProposalId
    | Mdl (Material.Msg Msg)
    | UrlChange Navigation.Location
