module ACCUSchedule.View exposing (view)

import ACCUSchedule.Model as Model
import ACCUSchedule.Msg as Msg
import ACCUSchedule.Routing as Routing
import ACCUSchedule.Search as Search
import ACCUSchedule.Types as Types
import ACCUSchedule.Types.Days as Days
import ACCUSchedule.Types.QuickieSlots as QuickieSlots
import ACCUSchedule.Types.Rooms as Rooms
import ACCUSchedule.Types.Sessions as Sessions
import Html exposing (a, br, div, h1, Html, img, p, text)
import Html.Attributes exposing (src)
import List.Extra exposing (stableSortWith)
import Markdown
import Material.Button as Button
import Material.Card as Card
import Material.Chip as Chip
import Material.Color as Color
import Material.Elevation as Elevation
import Material.Footer as Footer
import Material.Icon as Icon
import Material.Layout as Layout
import Material.Options as Options
import Material.Textfield as Textfield
import Material.Typography as Typo


proposalCardGroup : Int
proposalCardGroup =
    0


bookmarksControlGroup : Int
bookmarksControlGroup =
    1


searchFieldControlGroup : Int
searchFieldControlGroup =
    2


{-| Find a proposal based on a string representation of its id.

   This is just convenience for parsing the route.
-}
findProposal : Model.Model -> Types.ProposalId -> Maybe Types.Proposal
findProposal model id =
    (List.filter (\p -> p.id == id) model.proposals) |> List.head


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
            Rooms.toString proposal.room

        time =
            Sessions.toString proposal.session

        location =
            String.join ", " <|
                case proposal.quickieSlot of
                    Just slot ->
                        [ time, QuickieSlots.toString slot, room ]

                    _ ->
                        [ time, room ]

        dayLink =
            Layout.link
                [ Layout.href (Routing.dayUrl proposal.day) ]
                [ text <| Days.toString proposal.day ]
    in
        Card.view
            [ Options.onClick (Msg.VisitProposal proposal)
            , Elevation.e2
            , Options.css "margin-right" "5px"
            , Options.css "margin-bottom" "5px"
            ]
            [ Card.title
                [ Color.text Color.black
                , Color.background Color.white
                ]
                [ Card.head [] [ text proposal.title ]
                , Card.subhead [] [ text (presenters proposal) ]
                ]
            , Card.text
                [ Card.expand ]
                []
            , Card.text
                [ Color.text Color.black
                , Color.background Color.white
                ]
                [ dayLink
                , text <| ", " ++ location
                ]
            , Card.actions
                [ Card.border
                , Color.background Color.primaryDark
                , Color.text Color.white
                , Typo.right
                ]
                [ bookmarkButton model proposal ]
            ]


flowCardView : Model.Model -> List Types.Proposal -> Html Msg.Msg
flowCardView model proposals =
    Options.div
        [ Options.css "display" "flex"
        , Options.css "flex-flow" "row wrap"
        ]
        (List.map (proposalCard model) proposals)


sessionView : Model.Model -> List Types.Proposal -> Sessions.Session -> List (Html Msg.Msg)
sessionView model props session =
    let
        room =
            .room >> Rooms.ordinal

        compareRooms p1 p2 =
            compare (room p1) (room p2)

        compareSlots p1 p2 =
            case ( p1.quickieSlot, p2.quickieSlot ) of
                ( Nothing, Nothing ) ->
                    EQ

                ( Nothing, _ ) ->
                    LT

                ( _, Nothing ) ->
                    GT

                ( Just s1, Just s2 ) ->
                    compare (QuickieSlots.ordinal s1) (QuickieSlots.ordinal s2)

        proposals =
            List.filter (.session >> (==) session) props
                |> stableSortWith compareSlots
                |> stableSortWith compareRooms
    in
        case List.head proposals of
            Nothing ->
                []

            Just prop ->
                let
                    s =
                        Sessions.toString prop.session

                    d =
                        Days.toString prop.day

                    label =
                        d ++ ", " ++ s
                in
                    [ Chip.span [ Options.css "margin-bottom" "5px" ]
                        [ Chip.content []
                            [ text label ]
                        ]
                    , flowCardView model proposals
                    ]


{-| Display all proposals for a particular day.
-}
dayView : Model.Model -> List Types.Proposal -> Days.Day -> List (Html Msg.Msg)
dayView model proposals day =
    let
        props =
            List.filter (.day >> (==) day) proposals

        sview =
            sessionView model props
                >> Options.styled div
                    [ Options.css "margin-bottom" "10px" ]
    in
        List.map
            sview
            Sessions.conferenceSessions


{-| Display all "bookmarked" proposals, i.e. the users personal agenda.
-}
agendaView : Model.Model -> List (Html Msg.Msg)
agendaView model =
    let
        props =
            List.filter (\p -> List.member p.id model.bookmarks) model.proposals
                |> List.sortBy (.session >> Sessions.ordinal)

        dview day =
            [ Chip.span
                [ Options.css "margin-bottom" "5px"
                , Elevation.e2
                ]
                [ Chip.content []
                    [ Layout.link
                        [ Layout.href <| Routing.dayUrl day ]
                        [ text <| Days.toString day ]
                    ]
                ]
            , flowCardView model <| List.filter (.day >> (==) day) props
            ]
    in
        List.concatMap dview Days.conferenceDays


bookmarkButton : Model.Model -> Types.Proposal -> Html Msg.Msg
bookmarkButton model proposal =
    let
        icon =
            if List.member proposal.id model.bookmarks then
                "bookmark"
            else
                "bookmark_border"
    in
        Button.render Msg.Mdl
            [ proposalCardGroup
            , bookmarksControlGroup
            , proposal.id
            ]
            model.mdl
            [ Button.icon
            , Button.ripple
            , Options.onClick <| Msg.ToggleBookmark proposal.id
            ]
            [ Icon.i icon ]


{-| Display a single proposal. This includes all of the details of the proposal,
including the full text of the abstract.
-}
proposalView : Model.Model -> Types.Proposal -> Html Msg.Msg
proposalView model proposal =
    let
        room =
            Rooms.toString proposal.room

        session =
            Sessions.toString proposal.session

        location =
            session ++ ", " ++ room
    in
        Options.div
            [ Options.css "display" "flex"
            , Options.css "flex-flow" "row wrap"
              -- , Options.css "justify" "center"
            , Options.css "justify-content" "flex-start"
            , Options.css "align-items" "flex-start"
            ]
            [ Options.styled p
                []
                [ proposalCard model proposal ]
            , Options.styled p
                [ Typo.body1
                , Options.css "width" "30em"
                , Options.css "margin-left" "10px"
                ]
                [ Markdown.toHtml [] proposal.text ]
            ]


searchView : String -> Model.Model -> Html Msg.Msg
searchView term model =
    Search.search term model
        |> flowCardView model


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
        [ text linkText ]


dayLink : Days.Day -> Html Msg.Msg
dayLink day =
    drawerLink (Routing.dayUrl day) (Days.toString day)


agendaLink : Html Msg.Msg
agendaLink =
    drawerLink Routing.agendaUrl "Your agenda"


footer : Html Msg.Msg
footer =
    Footer.mini []
        { left =
            Footer.left []
                [ Footer.logo [] [ Footer.html <| text "ACCU 2017 Schedule" ]
                , Footer.links []
                    [ Footer.linkItem
                        [ Footer.href "https://conference.accu.org/site" ]
                        [ Footer.html <| text "Conference" ]
                    , Footer.linkItem
                        [ Footer.href "https://github.com/abingham/accu-2017-elm-app" ]
                        [ Footer.html <| img [ src "./static/img/GitHub-Mark-Light-32px.png" ] [] ]
                    ]
                ]
        , right =
            Footer.right []
                [ Footer.links []
                    [ Footer.linkItem
                        [ Footer.href "https://sixty-north.com" ]
                        [ Footer.html <| text "© 2017 Sixty North AS "
                        , Footer.html <| Options.img
                            [ Options.css "height" "20px" ]
                            [ src "static/img/sixty-north-logo.png" ]
                        ]
                    ]
                ]
        }


view : Model.Model -> Html Msg.Msg
view model =
    let
        main =
            case model.location of
                Routing.Day day ->
                    dayView model model.proposals day

                Routing.Proposal id ->
                    case findProposal model id of
                        Just proposal ->
                            [ proposalView model proposal ]

                        Nothing ->
                            [ notFoundView ]

                Routing.Agenda ->
                    agendaView model

                Routing.Search term ->
                    [ searchView term model ]

                _ ->
                    [ notFoundView ]

        pageName =
            case model.location of
                Routing.Day day ->
                    Days.toString day

                Routing.Proposal id ->
                    ""

                Routing.Agenda ->
                    "Your agenda"

                Routing.Search term ->
                    ""

                _ ->
                    ""

        searchString =
            case model.location of
                Routing.Search x ->
                    x

                _ ->
                    ""
    in
        div
            []
            [ Layout.render Msg.Mdl
                model.mdl
                [ Layout.fixedHeader
                ]
                { header =
                    [ Layout.row
                        [ Color.background Color.primary ]
                        [ Layout.title
                            [ Typo.title, Typo.left ]
                            [ text "ACCU 2017" ]
                        , Layout.spacer
                        , Layout.title
                            [ Typo.title ]
                            [ text pageName ]
                        , Layout.spacer
                        , Layout.title
                            [ Typo.title
                            , Options.onInput Msg.VisitSearch
                            ]
                            [ Textfield.render Msg.Mdl
                                [ searchFieldControlGroup ]
                                model.mdl
                                [ Textfield.label "Search"
                                , Textfield.floatingLabel
                                , Textfield.value searchString
                                , Textfield.expandable "search-field"
                                , Textfield.expandableIcon "search"
                                ]
                                []
                            ]
                        ]
                    ]
                , drawer =
                    [ Layout.title [] [ text "ACCU 2017" ]
                    , Layout.navigation [] <|
                        (List.map
                            dayLink
                            Days.conferenceDays
                        )
                            ++ [ Html.hr [] []
                               , agendaLink
                               ]
                    ]
                , tabs = ( [], [] )
                , main =
                    [ Options.styled div
                        [ Options.css "margin-left" "10px"
                        , Options.css "margin-top" "10px"
                        , Options.css "margin-bottom" "10px"
                        ]
                        main
                    , footer
                    ]
                }
            ]
