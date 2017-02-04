module ACCUSchedule.Model exposing (initialModel, initialTestModel, Model)

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

initialTestModel : Model
initialTestModel =
    let
        presenter = Types.Presenter 0 "Joe" "Blow"
        proposal = Types.Proposal 0 "Title" "Some text" [presenter] Types.Day1 Types.Session1 Nothing Types.Empire Types.CppTrack
        model = initialModel
    in
        {model | proposals = [proposal]}
