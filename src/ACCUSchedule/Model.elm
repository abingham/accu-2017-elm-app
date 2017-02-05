module ACCUSchedule.Model exposing (initialModel, Model)

{-| The overal application model.
-}

import ACCUSchedule.Types as Types
-- import Date exposing (Month(..))
-- import Date.Extra as Date
import Material


type alias Model =
    { proposals : List Types.Proposal
    , selectedTab : Int
    , mdl : Material.Model
    }

initialModel : Model
initialModel =
    { proposals = []
    , selectedTab = 0
    , mdl = Material.model
    }
