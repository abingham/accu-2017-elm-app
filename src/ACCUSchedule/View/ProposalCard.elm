module ACCUSchedule.View.ProposalCard exposing (proposalCard)

import ACCUSchedule.Model as Model
import ACCUSchedule.Msg as Msg
import ACCUSchedule.Routing as Routing
import ACCUSchedule.Types as Types
import ACCUSchedule.Types.Days as Days
import ACCUSchedule.Types.QuickieSlots as QuickieSlots
import ACCUSchedule.Types.Rooms as Rooms
import ACCUSchedule.Types.Sessions as Sessions
import ACCUSchedule.View.Theme as Theme
import Html exposing (a, br, div, h1, Html, img, p, text)
import Material.Button as Button
import Material.Card as Card
import Material.Color as Color
import Material.Elevation as Elevation
import Material.Icon as Icon
import Material.Layout as Layout
import Material.Options as Options
import Material.Typography as Typo


presenterDetailsControlGroup : Int
presenterDetailsControlGroup =
    0


proposalDetailsControlGroup : Int
proposalDetailsControlGroup =
    1


bookmarksControlGroup : Int
bookmarksControlGroup =
    2


proposalInfoButton : Int -> Model.Model -> Types.Proposal -> Html Msg.Msg
proposalInfoButton controlGroup model proposal =
    Button.render Msg.Mdl
        [ controlGroup
        , proposalDetailsControlGroup
        , proposal.id
        ]
        model.mdl
        [ Button.ripple
        , Button.link <| Routing.proposalUrl proposal.id
        ]
        [ text "details" ]


bookmarkButton : Int -> Model.Model -> Types.Proposal -> Html Msg.Msg
bookmarkButton controlGroup model proposal =
    let
        icon =
            if List.member proposal.id model.bookmarks then
                "bookmark"
            else
                "bookmark_border"
    in
        Button.render Msg.Mdl
            [ controlGroup
            , bookmarksControlGroup
            , proposal.id
            ]
            model.mdl
            [ Button.icon
            , Button.ripple
            , Options.cs "bookmark-button"
            , Options.onClick <| Msg.ToggleBookmark proposal.id
            ]
            [ Icon.i icon ]


{-| A card-view of a single proposal. This displays the title, presenters,
location, and potentially other information about a proposal, though not the
full text of the abstract. This includes a clickable icon for "starring" a
propposal.
-}
proposalCard : Int -> Model.Model -> Types.Proposal -> Html Msg.Msg
proposalCard controlGroup model proposal =
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

        presenterLink presenter =
            Layout.link
                [ Layout.href (Routing.presenterUrl presenter.id) ]
                [ text <| presenter.firstName ++ " " ++ presenter.lastName ]

        presenterLinks =
            List.map presenterLink (Model.presenters model proposal)
                |> List.intersperse (text ", ")

        dayLink =
            Layout.link
                [ Layout.href (Routing.dayUrl proposal.day)
                , Options.cs "day-link"
                ]
                [ text <| Days.toString proposal.day ]

        presenterInfoButton presenter =
            Button.render Msg.Mdl
                [ controlGroup
                , presenterDetailsControlGroup
                , presenter.id
                ]
                model.mdl
                [ Button.ripple
                , Button.link <| Routing.presenterUrl presenter.id
                ]
                [ text <| Types.fullName presenter ]
    in
        Card.view
            [ case model.view.raisedProposal of
                Just id ->
                    if id == proposal.id then
                        Elevation.e8
                    else
                        Elevation.e2

                _ ->
                    Elevation.e2
            , Options.cs "proposal-card"
            , Options.css "margin-right" "5px"
            , Options.css "margin-bottom" "10px"
            , Options.onMouseEnter (Msg.RaiseProposal True proposal.id)
            , Options.onMouseLeave (Msg.RaiseProposal False proposal.id)
            , Color.background Theme.background
            , Options.css "border-width" "1px"
            , Options.css "border-color" "#aaaaaa"
            , Options.css "border-style" "solid"
            ]
            [ Card.title
                [ Color.text Color.black
                ]
                [ Card.head
                    [ Options.onClick <| Msg.VisitProposal proposal
                    ]
                    [ text proposal.title ]
                , Card.subhead []
                    [ dayLink
                    , text <| ", " ++ location
                    ]
                ]
            , Card.text [ Card.expand ] []
            , Card.actions
                [ Typo.left
                ]
                (List.map
                    presenterInfoButton
                    (Model.presenters model proposal)
                )
            , Card.actions
                [ Color.background Theme.accent
                , Typo.left
                , Options.css "justify-content" "space-between"
                , Options.css "display" "flex"
                ]
                [ proposalInfoButton controlGroup model proposal
                , bookmarkButton controlGroup model proposal
                ]
            ]
