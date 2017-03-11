module ACCUSchedule.View.PresenterCard exposing (presenterCard)

{-| Implements a card view for a single presenter.
-}

import ACCUSchedule.ISO3166 as ISO3166
import ACCUSchedule.Model as Model
import ACCUSchedule.Msg as Msg
import ACCUSchedule.Routing as Routing
import ACCUSchedule.Types as Types
import ACCUSchedule.View.Theme as Theme
import Html exposing (a, br, div, h1, Html, img, p, text)
import Material.Button as Button
import Material.Card as Card
import Material.Color as Color
import Material.Elevation as Elevation
import Material.Layout as Layout
import Material.List as Lists
import Material.Options as Options
import Material.Typography as Typo


{-| The control group for presenter-details buttons.
-}
presenterDetailsControlGroup : Int
presenterDetailsControlGroup =
    0


{-| A card view for a single presenter. The `controlGroup` argument is the first
element in the `Index` argument for MDL controls; use it to differentiate
presenter-card buttons from buttons in other parts of the view.

    div [] [presenterCard 0 model presenter]
-}
presenterCard : Int -> Model.Model -> Types.Presenter -> Html Msg.Msg
presenterCard controlGroup model presenter =
    let
        proposalLink proposal =
            Lists.li []
                [ Lists.content []
                    [ Layout.link
                        [ Layout.href (Routing.proposalUrl proposal.id) ]
                        [ text <| proposal.title ]
                    ]
                ]

        country =
            case ISO3166.countryName presenter.country of
                Just name ->
                    name

                Nothing ->
                    presenter.country

        detailsButton =
            Button.render Msg.Mdl
                [ controlGroup
                , presenterDetailsControlGroup
                , presenter.id
                ]
                model.mdl
                [ Button.ripple
                , Button.link <| Routing.presenterUrl presenter.id
                ]
                [ text "details" ]
    in
        Card.view
            [ Options.css "margin-right" "5px"
            , Options.css "margin-bottom" "10px"
            , Elevation.e2
            , Color.background Theme.background
            , Options.css "border-width" "1px"
            , Options.css "border-color" "black"
            , Options.css "border-style" "solid"

            ]
            [ Card.title
                [ Color.text Color.black
                , Card.border
                ]
                [ Card.head [] [ text <| Types.fullName presenter ]
                , Card.subhead [] [ text country ]
                ]
            , Card.text
                [ Color.text Color.black
                ]
                [ Lists.ul [] (List.map proposalLink (Model.proposals model presenter)) ]
            , Card.text
                [ Card.expand ]
                []
            , Card.actions
                [ Color.background Theme.accent
                , Typo.left
                , Options.css "justify-content" "space-between"
                , Options.css "display" "flex"
                ]
                [ detailsButton
                ]
            ]
