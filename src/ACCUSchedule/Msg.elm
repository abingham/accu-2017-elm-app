module ACCUSchedule.Msg exposing (..)

import ACCUSchedule.Types as Types
import Http
import Material
import Navigation


type Msg
    = ProposalsResult (Result Http.Error (List Types.Proposal))
    | PresentersResult (Result Http.Error (List Types.Presenter))
    | VisitProposal Types.Proposal
    | VisitPresenter Types.Presenter
    | VisitSearch String
    | ToggleBookmark Types.ProposalId
    | RaiseProposal Bool Types.ProposalId
    | Mdl (Material.Msg Msg)
    | UrlChange Navigation.Location
