module ACCUSchedule.View exposing (view)

import ACCUSchedule.Model as Model
import ACCUSchedule.Msg as Msg
import ACCUSchedule.Routing as Routing
import ACCUSchedule.Types as Types
import Html exposing (a, br, div, h1, Html, p, text)
import Html.Attributes exposing (href, style)
import Material.Button as Button
import Material.Card as Card
import Material.Color as Color
import Material.Elevation as Elevation
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


dayOrd : Types.Day -> Int
dayOrd day =
    case day of
        Types.Workshops ->
            0

        Types.Day1 ->
            1

        Types.Day2 ->
            2

        Types.Day3 ->
            3

        Types.Day4 ->
            4


dayString : Types.Day -> String
dayString day =
    case day of
        Types.Workshops ->
            "Workshop"

        Types.Day1 ->
            "Tuesday"

        Types.Day2 ->
            "Wednesday"

        Types.Day3 ->
            "Thursday"

        Types.Day4 ->
            "Friday"


{-| Find a proposal based on a string representation of its id.

   This is just convenience for parsing the route.
-}
findProposal : Model.Model -> Types.ProposalId -> Maybe Types.Proposal
findProposal model id =
    (List.filter (\p -> p.id == id) model.proposals) |> List.head


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


{-| Create a display-ready string of the names of all presenters for a proposal.
-}
presenters : Types.Proposal -> String
presenters proposal =
    let
        fullName =
            \p -> p.firstName ++ " " ++ p.lastName

        presenterNames =
            List.map fullName proposal.presenters
    in
        String.join ", " presenterNames


{-| A card-view of a single proposal. This displays the title, presenters,
location, and potentially other information about a proposal, though not the
full text of the abstract. This includes a clickable icon for "starring" a
propposal.
-}
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
            [ Options.onClick (Msg.VisitProposal proposal)
            , Elevation.e2
            ]
            [ Card.title
                [ Color.text Color.black
                , Color.background Color.white
                ]
                ([ Card.head [] [ text proposal.title ]
                 ]
                )
            , Card.title
                [ Color.text Color.black
                , Color.background Color.white
                ]
                ([ Card.subhead
                    []
                    [ text (presenters proposal) ]
                 , Card.subhead
                    []
                    [ text location ]
                 ]
                )
            , Card.actions
                [ Card.border
                , Color.background Color.accent
                , Color.text Color.white
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


{-| Create a grid view of a subset of the proposals in a model. This displays a
card for each proposal `p` in `model` for which `predicate p` is `true`.
-}
filteredCardView : Model.Model -> (Types.Proposal -> Bool) -> Html Msg.Msg
filteredCardView model predicate =
    let
        proposals =
            List.filter predicate model.proposals

        makeCell p =
            Grid.cell [ Grid.size Grid.All 4 ]
                [ proposalCard model p ]
    in
        List.map makeCell proposals |> Grid.grid []


{-| Display all proposals for a particular day.
-}
dayView : Model.Model -> Types.Day -> Html Msg.Msg
dayView model day =
    let
        forToday =
            \p -> p.day == day
    in
        filteredCardView model forToday


{-| Display all "starred" proposals, i.e. the users personal agenda.
-}
agendaView : Model.Model -> Html Msg.Msg
agendaView model =
    let
        starred =
            \p -> List.member p.id model.starred
    in
        filteredCardView model starred


{-| Display a single proposal. This includes all of the details of the proposal,
including the full text of the abstract.
-}
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
                    ]
                    [ text proposal.title ]
                , Options.styled p
                    [ Typo.subhead
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


drawerLink : String -> String -> Html Msg.Msg
drawerLink url linkText =
    Layout.link
        [ Layout.href url
        , Options.onClick <| Layout.toggleDrawer Msg.Mdl
        ]
    [ text linkText]



dayLink : Model.Model -> Types.Day -> Html Msg.Msg
dayLink model day =
    let
        dayNum =
            dayOrd day |> toString
    in
        drawerLink ("#/day/" ++ dayNum) (dayString day)


agendaLink : Html Msg.Msg
agendaLink =
    drawerLink "#/agenda" "Agenda"


view : Model.Model -> Html Msg.Msg
view model =
    let
        main =
            case model.location of
                Routing.Day day ->
                    dayView model day

                Routing.Proposal id ->
                    case findProposal model id of
                        Just proposal ->
                            proposalView proposal

                        Nothing ->
                            notFoundView

                Routing.Agenda ->
                    agendaView model

                Routing.NotFound ->
                    notFoundView

        pageName =
            case model.location of
                Routing.Day day ->
                    dayString day

                Routing.Proposal id ->
                    ""

                Routing.Agenda ->
                    "Agenda"

                Routing.NotFound ->
                    ""
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
                            [ Typo.title, Typo.left ]
                            [ text "ACCU 2017" ]
                        , Layout.spacer
                        , Layout.title
                            [ Typo.title ]
                            [ text pageName ]
                        ]
                    ]
                , drawer =
                    [ Layout.title [] [ text "ACCU 2017" ]
                    , Layout.navigation []
                        <| (List.map
                                (dayLink model)
                                [ Types.Day1, Types.Day2, Types.Day3, Types.Day4 ]
                           )
                        ++ [ drawerLink "#/agenda" "Agenda"]
                    ]
                , tabs = ( [], [] )
                , main = [ main ]
                }
            ]
