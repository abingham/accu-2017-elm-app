module ACCUSchedule.Routing exposing (..)

import ACCUSchedule.Types as Types
import Navigation


type alias RoutePath =
    List String


parseLocation : Navigation.Location -> RoutePath
parseLocation =
    .hash >> String.split "/" >> List.drop 1
