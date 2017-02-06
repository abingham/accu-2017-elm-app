module ACCUSchedule.Model exposing (initialModel, Model)

{-| The overal application model.
-}

import ACCUSchedule.Msg as Msg
import ACCUSchedule.Routing as Routing
import ACCUSchedule.Types as Types
import Material
import Navigation


type alias Model =
    { proposals : List Types.Proposal
    , starred : List Types.ProposalId
    , mdl : Material.Model
    , location : Routing.RoutePath
    }


initialModel : List Types.ProposalId -> Navigation.Location -> Model
initialModel starred location =
    { proposals = []
    , starred = starred
    , mdl = Material.model
    , location = Routing.parseLocation location
    }
