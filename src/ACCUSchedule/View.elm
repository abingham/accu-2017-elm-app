module ACCUSchedule.View exposing (view)

import ACCUSchedule.Model as Model
import ACCUSchedule.Msg as Msg
import ACCUSchedule.Types as Types
import Html exposing (a, div, h1, Html, p, text)
import Html.Attributes exposing (style)
import Material.Color as Color
import Material.Layout as Layout


proposalView : Types.Proposal -> Html Msg.Msg
proposalView proposal =
    div []
        [ text proposal.title ]


proposalsView : List Types.Proposal -> Html Msg.Msg
proposalsView =
    List.map proposalView >> div []


view : Model.Model -> Html Msg.Msg
view model =
    let
        tabs =
            [ text "Workshops"
            , text "Day 1"
            , text "Day 2"
            , text "Day 3"
            , text "Day 4"
            ]
    in
        div
            [ style [ ( "padding", "2rem" ) ] ]
            [ text "Not much here yet..."
            , Layout.render Msg.Mdl
                model.mdl
                [ Layout.fixedHeader
                , Layout.selectedTab model.selectedTab
                , Layout.onSelectTab Msg.SelectTab
                ]
                { header = []
                , drawer =
                    []
                    -- , tabs = ( [ text "Milk", text "Oranges" ], [ Color.background (Color.color Color.Teal Color.S400) ] )
                , tabs = ( tabs, [ Color.background (Color.color Color.Teal Color.S400) ] )
                , main = [ proposalsView model.proposals ]
                }
            ]
