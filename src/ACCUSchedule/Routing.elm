module ACCUSchedule.Routing exposing (..)

import ACCUSchedule.Types as Types
import ACCUSchedule.Types.Days as Days
import Http
import Navigation
import UrlParser exposing (..)


{-| All of the possible routes that we can display
-}
type RoutePath
    = Day Days.Day
    | Proposal Types.ProposalId
    | Presenter Types.PresenterId
    | Presenters
    | Agenda
    | Search String
    | NotFound


dayUrl : Days.Day -> String
dayUrl day =
    let
        dayNum =
            Days.ordinal day |> toString
    in
        "#/day/" ++ dayNum


agendaUrl : String
agendaUrl =
    "#/agenda"


proposalUrl : Types.ProposalId -> String
proposalUrl proposalId =
    "#/session/" ++ (toString proposalId)

presenterUrl : Types.PresenterId -> String
presenterUrl presenterId =
    "#/presenter/" ++ (toString presenterId)


presentersUrl : String
presentersUrl = "#/presenters"

searchUrl : String -> String
searchUrl term =
    "#/search/" ++ (Http.encodeUri term)


{-| Parse the string form of a day ordinal to a result.
-}
parseDay : String -> Result String Days.Day
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
day : Parser (Days.Day -> b) b
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
        [ map (Day Days.Day1) top
        , map Day (s "day" </> day)
        , map Proposal (s "session" </> int)
        , map Presenter (s "presenter" </> int)
        , map Presenters (s "presenters")
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
