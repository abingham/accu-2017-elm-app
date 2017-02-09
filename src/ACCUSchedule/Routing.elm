module ACCUSchedule.Routing exposing (..)

import ACCUSchedule.Days as Days
import ACCUSchedule.Types as Types
import Http
import Navigation
import UrlParser exposing (..)


{-| All of the possible routes that we can display
-}
type RoutePath
    = Day Types.Day
    | Proposal Types.ProposalId
    | Agenda
    | Search String
    | NotFound


dayUrl : Types.Day -> String
dayUrl day =
    let
        dayNum =
            Days.ordinal day |> toString
    in
        "#/day/" ++ dayNum


agendaUrl : String
agendaUrl =
    "#/agenda"


proposalUrl : Types.Proposal -> String
proposalUrl proposal =
    "#/session/" ++ (toString proposal.id)


searchUrl : String -> String
searchUrl term =
    "#/search/" ++ (Http.encodeUri term)


{-| Parse the string form of a day ordinal to a result.
-}
parseDay : String -> Result String Types.Day
parseDay path =
    let
        matchDayOrd day rslt =
            if (day |> (Days.ordinal >> toString)) == path then
                Ok day
            else
                rslt
    in
        List.foldl
            matchDayOrd
            (Err "Invalid day")
            Days.conferenceDays


{-| Location parser for days encoded as integers
-}
day : Parser (Types.Day -> b) b
day =
    custom "DAY" parseDay


{-| Location parser for uri-encoded strings.
-}
uriEncoded : Parser (String -> b) b
uriEncoded =
    let
        decode x =
            case Http.decodeUri x of
                Just dx ->
                    Ok dx

                Nothing ->
                    Err "Invalid URI-encoded string"
    in
        custom "URI_ENCODED" decode


matchers : Parser (RoutePath -> a) a
matchers =
    oneOf
        [ map (Day Types.Day1) top
        , map Day (s "day" </> day)
        , map Proposal (s "session" </> int)
        , map Agenda (s "agenda")
        , map Search (s "search" </> uriEncoded)
        ]


parseLocation : Navigation.Location -> RoutePath
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFound
