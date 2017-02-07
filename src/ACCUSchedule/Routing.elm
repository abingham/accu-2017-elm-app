module ACCUSchedule.Routing exposing (..)

import ACCUSchedule.Types as Types
import Navigation


type RoutePath
    = Day Types.Day
    | Proposal Types.ProposalId
    | Agenda
    | NotFound


parseDayRoute : List String -> RoutePath
parseDayRoute path =
    case path of
        [ "1" ] ->
            Day Types.Day1

        [ "2" ] ->
            Day Types.Day2

        [ "3" ] ->
            Day Types.Day3

        [ "4" ] ->
            Day Types.Day4

        _ ->
            NotFound


parseSessionRoute : List String -> RoutePath
parseSessionRoute path =
    let
        nums =
            List.map String.toInt path
    in
        case nums of
            [ Ok id ] ->
                Proposal id

            _ ->
                NotFound


parseLocation : Navigation.Location -> RoutePath
parseLocation location =
    let
        path =
            (String.split "/" >> List.drop 1) location.hash

        head =
            List.head path
    in
        case head of
            Nothing ->
                Day Types.Day1

            Just "day" ->
                parseDayRoute (List.drop 1 path)

            Just "session" ->
                parseSessionRoute (List.drop 1 path)

            Just "agenda" ->
                case List.length path of
                    1 -> Agenda
                    _ -> NotFound

            _ ->
                NotFound
