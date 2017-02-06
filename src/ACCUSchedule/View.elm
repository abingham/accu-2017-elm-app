module ACCUSchedule.View exposing (view)

import ACCUSchedule.Model as Model
import ACCUSchedule.Msg as Msg
import ACCUSchedule.Types as Types
import Html exposing (a, br, div, h1, Html, p, text)
import Html.Attributes exposing (href, style)
import Material.Card as Card
import Material.Color as Color
import Material.Grid as Grid
import Material.Layout as Layout
import Material.Options as Options
import Material.Typography as Typo


type alias Tabs =
    ( List (Html.Html Msg.Msg), List (Options.Style Msg.Msg) )


titleBackgroundColor : Color.Color
titleBackgroundColor =
    Color.color Color.LightBlue Color.S100


infoBackgroundColor : Color.Color
infoBackgroundColor =
    Color.color Color.Grey Color.S100


dayString : Types.Day -> String
dayString day =
    case day of
        Types.Workshops ->
            "Workshop"

        Types.Day1 ->
            "Day 1"

        Types.Day2 ->
            "Day 2"

        Types.Day3 ->
            "Day 3"

        Types.Day4 ->
            "Day 4"


roomToString : Types.Room -> String
roomToString room =
    case room of
        Types.BristolSuite ->
            "Bristol Suite"

        Types.Bristol1 ->
            "Bristol 1"

        Types.Bristol2 ->
            "Bristol 2"

        Types.Bristol3 ->
            "Bristol 3"

        Types.Empire ->
            "Empire"

        Types.GreatBritain ->
            "Great Britain"


sessionToString : Types.Session -> String
sessionToString session =
    case session of
        Types.Session1 ->
            "Session 1"

        Types.Session2 ->
            "Session 2"

        Types.Session3 ->
            "Session 3"


tabToDay : Int -> Types.Day
tabToDay tab =
    case tab of
        0 ->
            Types.Day1

        1 ->
            Types.Day2

        2 ->
            Types.Day3

        -- TODO: This is sloppy. We should handle an invalid tab better.
        _ ->
            Types.Day4


presenters : Types.Proposal -> String
presenters proposal =
    let
        fullName =
            \p -> p.firstName ++ " " ++ p.lastName

        presenterNames =
            List.map fullName proposal.presenters
    in
        String.join ", " presenterNames


proposalCard : Types.Proposal -> Html Msg.Msg
proposalCard proposal =
    let
        room =
            roomToString proposal.room

        time =
            sessionToString proposal.session

        location =
            time ++ ", " ++ room
    in
        Card.view
            [ Options.onClick (Msg.VisitProposal proposal) ]
            [ Card.title [ Color.background titleBackgroundColor ]
                ([ Card.head [] [ text proposal.title ]
                 ]
                )
            , Card.title [ Color.background infoBackgroundColor ]
                ([ Card.subhead [] [ text (presenters proposal) ]
                 , Card.subhead [] [ text location ]
                 ]
                )
            ]


proposalsView : Model.Model -> Html Msg.Msg
proposalsView model =
    let
        day =
            tabToDay model.selectedTab

        forToday =
            \p -> p.day == day

        proposals =
            List.filter forToday model.proposals

        makeCell p =
            Grid.cell [ Grid.size Grid.All 4 ]
                [ proposalCard p ]
    in
        List.map makeCell proposals |> Grid.grid []


scheduleView : Model.Model -> ( Tabs, Html Msg.Msg )
scheduleView model =
    let
        tabs =
            [ text "Day 1"
            , text "Day 2"
            , text "Day 3"
            , text "Day 4"
            ]
    in
        ( ( tabs, [ Color.background (Color.color Color.Teal Color.S400) ] )
        , proposalsView model
        )


proposalIdView : Model.Model -> Int -> ( Tabs, Html Msg.Msg )
proposalIdView model proposalId =
    let
        prop =
            (List.filter (\p -> p.id == proposalId) model.proposals) |> List.head
    in
        case prop of
            Just proposal ->
                ( ( [], [] ), proposalView proposal )

            Nothing ->
                notFoundView


proposalView : Types.Proposal -> Html Msg.Msg
proposalView proposal =
    let
        room =
            roomToString proposal.room

        session =
            sessionToString proposal.session

        location =
            session ++ ", " ++ room
    in
        Grid.grid []
            [ Grid.cell [ Grid.size Grid.All 8 ]
                [ Options.styled p
                    [ Typo.title
                    , Color.background titleBackgroundColor
                    , Options.css "padding" "25px"
                    ]
                    [ text proposal.title ]
                , Options.styled p
                    [ Typo.subhead
                    , Options.css "padding" "10px"
                    , Color.background infoBackgroundColor
                    ]
                    [ text (presenters proposal)
                    , br [] []
                    , text location
                    ]
                , Options.styled p
                    [ Typo.body1 ]
                    [ text proposal.text ]
                ]
            ]


notFoundView : ( Tabs, Html Msg.Msg )
notFoundView =
    ( ( [], [] )
    , div []
        [ text "view not found :("
        , br [] []
        , a [ href "#" ] [ text "return to app" ]
        ]
    )


view : Model.Model -> Html Msg.Msg
view model =
    let
        ( tabs, main ) =
            case model.location of
                [] ->
                    scheduleView model

                [ "session", id ] ->
                    case (String.toInt id) of
                        Ok id ->
                            proposalIdView model id

                        Err _ ->
                            notFoundView

                _ ->
                    notFoundView
    in
        div
            [ style [ ( "padding", "2rem" ) ] ]
            [ Layout.render Msg.Mdl
                model.mdl
                [ Layout.fixedHeader
                , Layout.selectedTab model.selectedTab
                , Layout.onSelectTab Msg.SelectTab
                ]
                { header =
                    [ Layout.row
                        []
                        [ Layout.title
                            [ Typo.title ]
                            [ text "ACCU 2017" ]
                        , Layout.navigation
                            []
                            [ Layout.link [ Layout.href "#" ] [ text "Schedule" ] ]
                        ]
                    ]
                , drawer = []
                , tabs = tabs
                , main = [ main ]
                }
            ]
