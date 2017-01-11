module ACCUSchedule.Model exposing (initialModel, initialTestModel, Model)

{-| The overal application model.
-}

import ACCUSchedule.Types as Types
import Date exposing (Month(..))
import Date.Extra as Date
import Material


type alias Model =
    { schedule : Types.Schedule
    , selectedTab : Int
    , mdl : Material.Model
    }

initialModel : Model
initialModel =
    { schedule = Types.emptySchedule
    , selectedTab = 0
    , mdl = Material.model
    }

initialTestModel : Model
initialTestModel =
    let
        dates =
            [ Date.fromParts 1999 Dec 24 23 59 0 0
            , Date.fromParts 1999 Dec 23 23 59 0 0
            , Date.fromParts 1999 Dec 22 23 59 0 0
            ]

        days =
            List.map Types.emptyDay dates

        model = initialModel

        schedule =
            List.foldl Types.addDay model.schedule days
    in
        {model | schedule = schedule}
