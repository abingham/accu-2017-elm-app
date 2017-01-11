module ACCUSchedule.View exposing (view)

import ACCUSchedule.Model as Model
import ACCUSchedule.Msg as Msg
import ACCUSchedule.Types as Types
import Date
import Date.Format
import Html exposing (a, div, h1, Html, p, text)
import Html.Attributes exposing (style)
import List
import Material.Color as Color
import Material.Layout as Layout


-- import Html.Attributes exposing (..)
-- simpleStyle : Options.Property c Msg -> String -> Html Msg
-- simpleStyle property msg =
--     Options.styled p
--         [ property ]
--         [ text msg ]
-- title : String -> Html Msg
-- title =
--     simpleStyle Typography.title
-- caption : String -> Html Msg
-- caption =
--     simpleStyle Typography.caption
-- button : String -> Html Msg
-- button =
--     simpleStyle Typography.button
-- fullWidth : List (Options.Style Msg)
-- fullWidth =
--     [ Grid.size Grid.Desktop 12, Grid.size Grid.Tablet 8, Grid.size Grid.Phone 4 ]
-- halfWidth : List (Options.Style Msg)
-- halfWidth =
--     [ Grid.size Grid.Desktop 6, Grid.size Grid.Tablet 4, Grid.size Grid.Phone 2 ]
-- quarterWidth : List (Options.Style Msg)
-- quarterWidth =
--     [ Grid.size Grid.Desktop 3, Grid.size Grid.Tablet 2, Grid.size Grid.Phone 1 ]
-- conversionDetailsView : Types.ConversionDetails -> Html Msg
-- conversionDetailsView status =
--     case status of
--         Types.Initiated _ ->
--             Progress.indeterminate
--         Types.InProgress _ ->
--             Progress.indeterminate
--         Types.Complete data ->
--             let
--                 filename =
--                     data.locator.file_id ++ ".pdf"
--             in
--                 a [ href data.download_url, downloadAs filename ] [ text "Download" ]
--         Types.Error msg ->
--             text msg
-- submittedListView : ACCUSchedule.Model.Model -> Html Msg
-- submittedListView model =
--     let
--         make_item conversion =
--             List.li
--                 [ List.withSubtitle ]
--                 [ List.content
--                     []
--                     [ text conversion.source_url
--                     , List.subtitle [] [ conversionDetailsView conversion.details ]
--                     ]
--                 ]
--         items =
--             List.map make_item model.conversions
--     in
--         List.ul
--             []
--             items
-- submittedView : ACCUSchedule.Model.Model -> Html Msg
-- submittedView model =
--     if (List.isEmpty model.conversions) then
--         caption "No submissions"
--     else
--         submittedListView model
-- suggestionsListView : ACCUSchedule.Model.Model -> Html Msg
-- suggestionsListView model =
--     let
--         make_item cand =
--             List.li
--                 [ List.withSubtitle ]
--                 [ List.content
--                     []
--                     [ text cand.source_url
--                     , List.subtitle [] [ text cand.timestamp ]
--                     ]
--                 , a [ href cand.download_url, downloadAs (cand.file_id ++ ".pdf") ] [ button "Download" ]
--                 ]
--         items =
--             List.map make_item model.suggestions
--     in
--         List.ul
--             []
--             items
-- suggestionsView : ACCUSchedule.Model.Model -> Html Msg
-- suggestionsView model =
--     if (List.isEmpty model.suggestions) then
--         caption "No suggestions available"
--     else
--         suggestionsListView model
-- urlForm : ACCUSchedule.Model.Model -> Html Msg
-- urlForm model =
--     div
--         []
--         [ Layout.row
--             []
--             [ Textfield.render Mdl
--                 [ 0 ]
--                 model.mdl
--                 [ Textfield.label "URL"
--                 , Textfield.floatingLabel
--                 , Textfield.value model.current_url
--                 , Textfield.onInput SetCurrentUrl
--                 ]
--             ]
--         , Layout.row
--             []
--             [ Button.render Mdl
--                 [ 0 ]
--                 model.mdl
--                 [ Button.raised
--                 , Button.ripple
--                 , Button.onClick SubmitCurrentUrl
--                 ]
--                 [ text "Convert" ]
--             ]
--         ]
-- viewBody : ACCUSchedule.Model.Model -> Html Msg
-- viewBody model =
--     div
--         [ style [ ( "padding", "2rem" ) ] ]
--         [ Grid.grid
--             []
--             [ Grid.cell fullWidth
--                 [ urlForm model ]
--             , Grid.cell halfWidth
--                 [ title "Submissions"
--                 , submittedView model
--                 ]
--             , Grid.cell halfWidth
--                 [ title "Suggestions"
--                 , suggestionsView model
--                 ]
--             ]
--         ]


dayView : Types.Day -> Html Msg.Msg
dayView day =
    let
        texts =
            [ text (Date.Format.format "%A" day.date)
            ]
                ++ (List.map (.name >> text) day.rooms)
    in
        div []
            texts


sortedDays : Types.Schedule -> List Types.Day
sortedDays schedule =
    schedule.days
        |> List.sortBy (.date >> Date.toTime)


scheduleView : Model.Model -> Html Msg.Msg
scheduleView model =
    let
        getDay =
            sortedDays
                >> List.drop model.selectedTab
                >> List.head

        day =
            getDay model.schedule
    in
        case day of
            Just d ->
                dayView d

            Nothing ->
                text "oops! No such day!"


view : Model.Model -> Html Msg.Msg
view model =
    let
        tabs =
            model.schedule.days
                |> List.map .date
                |> List.sortBy Date.toTime
                |> List.map (Date.Format.format "%A" >> text)
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
                , main = [ scheduleView model ]
                }
            ]



--     Layout.render Mdl
--         model.mdl
--         [-- Layout.fixedHeader
--          -- , Layout.selectedTab model.selectedTab
--          -- , Layout.onSelectTab SelectTab
--         ]
--     { header = []
--     , drawer =
--           []
--     -- , tabs = ( [ text "Milk", text "Oranges" ], [ Color.background (Color.color Color.Teal Color.S400) ] )
--     , tabs = ( [], [] )
--     , main = [ viewBody model ]
--     }
