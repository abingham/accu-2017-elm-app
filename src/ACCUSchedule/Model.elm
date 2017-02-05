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
    , selectedTab : Int
    , mdl : Material.Model
    , location: Routing.RoutePath
    }


initialModel : Navigation.Location -> Model
initialModel location =
    { proposals = []
    , selectedTab = 0
    , mdl = Material.model
    , location = Routing.parseLocation location
    }
