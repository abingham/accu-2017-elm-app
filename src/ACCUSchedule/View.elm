module ACCUSchedule.View exposing (view)

import ACCUSchedule.Model as Model
import ACCUSchedule.Msg as Msg
import ACCUSchedule.Types as Types
import Html exposing (a, br, div, h1, Html, p, text)
import Html.Attributes exposing (href, style)
import Material.Button as Button
import Material.Card as Card
import Material.Color as Color
import Material.Grid as Grid
import Material.Icon as Icon
import Material.Layout as Layout
import Material.Options as Options
import Material.Typography as Typo


proposalCardGroup : Int
proposalCardGroup =
    0


starredControlGroup : Int
starredControlGroup =
    0


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


stringToDay : String -> Result String Types.Day
stringToDay s =
    case s of
        "1" ->
            Ok Types.Day1

        "2" ->
            Ok Types.Day2

        "3" ->
            Ok Types.Day3

        "4" ->
            Ok Types.Day4

        _ ->
            Err <| "no such day: " ++ s



{- ! Find a proposal based on a string representation of its id.

   This is just convenienve for parsing the route.
-}


findProposal : Model.Model -> String -> Maybe Types.Proposal
findProposal model id =
    case String.toInt id of
        Ok pid ->
            (List.filter (\p -> p.id == pid) model.proposals) |> List.head

        Err _ ->
            Nothing


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


proposalCard : Model.Model -> Types.Proposal -> Html Msg.Msg
proposalCard model proposal =
    let
        room =
            roomToString proposal.room

        time =
            sessionToString proposal.session

        location =
            time ++ ", " ++ room

        icon =
            if List.member proposal.id model.starred then
                "favorite"
            else
                "favorite_border"
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
            , Card.actions
                [ Card.border
                , Color.background infoBackgroundColor
                , Color.text Color.black
                , Typo.right
                ]
                [ Button.render Msg.Mdl
                    [ proposalCardGroup
                    , starredControlGroup
                    , proposal.id
                    ]
                    model.mdl
                    [ Button.icon
                    , Button.ripple
                    , Options.onClick <| Msg.ToggleStarred proposal.id
                    ]
                    [ Icon.i icon ]
                ]
            ]


dayView : Model.Model -> Types.Day -> Html Msg.Msg
dayView model day =
    let
        forToday =
            \p -> p.day == day

        proposals =
            List.filter forToday model.proposals

        makeCell p =
            Grid.cell [ Grid.size Grid.All 4 ]
                [ proposalCard model p ]
    in
        List.map makeCell proposals |> Grid.grid []


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


notFoundView : Html Msg.Msg
notFoundView =
    div []
        [ text "view not found :("
        ]


view : Model.Model -> Html Msg.Msg
view model =
    let
        main =
            case model.location of
                [] ->
                    dayView model Types.Day1

                [ "day", day ] ->
                    case (stringToDay day) of
                        Ok d ->
                            dayView model d

                        Err _ ->
                            notFoundView

                [ "session", id ] ->
                    case findProposal model id of
                        Just proposal ->
                            proposalView proposal

                        Nothing ->
                            notFoundView

                _ ->
                    notFoundView
    in
        div
            [ style [ ( "padding", "2rem" ) ] ]
            [ Layout.render Msg.Mdl
                model.mdl
                [ Layout.fixedHeader
                ]
                { header =
                    [ Layout.row
                        []
                        [ Layout.title
                            [ Typo.title ]
                            [ text "ACCU 2017" ]
                        , Layout.navigation
                            []
                            [ Layout.link [ Layout.href "#/day/1" ] [ text "Day 1" ]
                            , Layout.link [ Layout.href "#/day/2" ] [ text "Day 2" ]
                            , Layout.link [ Layout.href "#/day/3" ] [ text "Day 3" ]
                            , Layout.link [ Layout.href "#/day/4" ] [ text "Day 4" ]
                            ]
                        ]
                    ]
                , drawer = []
                , tabs = ( [], [] )
                , main = [ main ]
                }
            ]
