module ACCUSchedule.View exposing (view)

import ACCUSchedule.Model as Model
import ACCUSchedule.Msg as Msg
import ACCUSchedule.Types as Types
import Html exposing (a, div, h1, Html, p, text)
import Html.Attributes exposing (style)
import Material.Button as Button
import Material.Card as Card
import Material.Color as Color
import Material.Elevation as Elevation
import Material.Layout as Layout
import Material.Options as Options exposing (cs, css)


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
        Types.BristolSuite -> "Bristol Suite"
        Types.Bristol1 -> "Bristol 1"
        Types.Bristol2 -> "Bristol 2"
        Types.Bristol3 -> "Bristol 3"
        Types.Empire -> "Empire"
        Types.GreatBritain -> "Great Britain"

sessionToString : Types.Session -> String
sessionToString session =
    case session of
        Types.Session1 -> "Session 1"
        Types.Session2 -> "Session 2"
        Types.Session3 -> "Session 3"


tabToDay : Int -> Types.Day
tabToDay tab =
    case tab of
        0 ->
            Types.Workshops

        1 ->
            Types.Day1

        2 ->
            Types.Day2

        3 ->
            Types.Day3

        -- TODO: This is sloppy. We should handle an invalid tab better.
        _ ->
            Types.Day4


margin2 : Options.Property a b
margin2 =
    css "margin" "4px 8px 4px 0px"


proposalCard : Types.Proposal -> Html Msg.Msg
proposalCard proposal =
    let
        fullName =
            \p -> p.firstName ++ " " ++ p.lastName

        presenterNames =
            List.map fullName proposal.presenters

        presenters =
            String.join ", " presenterNames

        room =
            roomToString proposal.room

        time =
            sessionToString proposal.session

        location = time ++ ", " ++ room
    in
        Card.view
            [ margin2
              --, Color.background (Color.color Color.DeepPurple Color.S300)
            , Elevation.e2
            , css "width" (toString 400 ++ "px")
            , Card.border
            ]
            [ Card.title []
                ([ Card.head [] [ text proposal.title ]
                 , Card.subhead [] [ text presenters ]
                 , Card.subhead [] [text location]
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
    in
        div [] (List.map proposalCard proposals)

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
                , tabs = ( tabs, [ Color.background (Color.color Color.Teal Color.S400) ] )
                , main = [ proposalsView model ]
                }
            ]
