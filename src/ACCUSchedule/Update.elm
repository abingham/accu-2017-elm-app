module ACCUSchedule.Update exposing (update)

import ACCUSchedule.Msg as Msg
import ACCUSchedule.Model exposing (Model)
import Material
import Return exposing (command, map, Return, return, singleton, zero)


-- handleSubmissionSuccess : Types.StatusLocator -> Model -> Types.URL -> ( Model, Cmd Msg.Msg )
-- handleSubmissionSuccess locator model source_url =
--     let
--         conversion =
--             Types.Conversion source_url (Types.Initiated locator)
--         poller =
--             Polling.statusPoller locator.file_id locator.status_url
--     in
--         ( { model
--             | conversions = conversion :: model.conversions
--             , pollers = Dict.insert locator.file_id poller model.pollers
--           }
--         , TaskRepeater.start poller
--         )
-- handleSubmissionError : String -> Model -> Types.URL -> ( Model, Cmd Msg.Msg )
-- handleSubmissionError msg model source_url =
--     let
--         conversion =
--             Types.Conversion source_url (Types.Error msg)
--     in
--         { model | conversions = conversion :: model.conversions } ! []
-- statusDetails : Result String Types.ConversionDetails -> Types.ConversionDetails
-- statusDetails result =
--     case result of
--         Result.Err msg ->
--             Types.Error msg
--         Result.Ok details ->
--             details
-- updateDetails : Types.ConversionDetails -> Types.FileID -> Types.Conversion -> Types.Conversion
-- updateDetails details file_id conv =
--     let
--         new_details =
--             case conv.details of
--                 Types.Initiated locator ->
--                     if locator.file_id == file_id then
--                         details
--                     else
--                         conv.details
--                 Types.InProgress ipd ->
--                     if ipd.locator.file_id == file_id then
--                         details
--                     else
--                         conv.details
--                 Types.Complete cd ->
--                     if cd.locator.file_id == file_id then
--                         details
--                     else
--                         conv.details
--                 _ ->
--                     conv.details
--     in
--         { conv | details = new_details }
-- handleStatus_ : Types.ConversionDetails -> Bool -> Types.FileID -> Model -> ( Model, Cmd Msg.Msg )
-- handleStatus_ details removePoller fileId model =
--     let
--         updater =
--             updateDetails details fileId
--         conversions =
--             List.map updater model.conversions
--         pollers =
--             if removePoller then
--                 Dict.remove fileId model.pollers
--             else
--                 model.pollers
--     in
--         { model
--             | conversions = conversions
--             , pollers = pollers
--         }
--             ! []
-- handleStatusSuccess : Types.ConversionDetails -> Types.FileID -> Model -> ( Model, Cmd Msg.Msg )
-- handleStatusSuccess details =
--     let
--         removePoller =
--             case details of
--                 Types.Complete _ ->
--                     True
--                 _ ->
--                     False
--     in
--         handleStatus_ details removePoller
-- handleStatusError : String -> Types.FileID -> Model -> ( Model, Cmd Msg.Msg )
-- handleStatusError msg =
--     handleStatus_ (Types.Error msg) False
-- handleSetCurrentUrl : Model -> Types.URL -> ( Model, Cmd Msg.Msg )
-- handleSetCurrentUrl model url =
--     let
--         new_model =
--             { model | current_url = url }
--     in
--         if String.length url < 5 then
--             { new_model | suggestions = [] } ! []
--         else
--             new_model ! [ getSuggestions url ]
-- {-| Central update function.
-- -}


update : Msg.Msg -> Model -> Return Msg.Msg Model
update msg model =
    case msg of
        Msg.ProposalsResult (Ok proposals) ->
            { model | proposals = proposals } ! []

        Msg.ProposalsResult (Err msg) ->
            -- TODO: display error message or something...maybe a button for
            -- re-fetching the proposals.
            model ! []

        Msg.SelectTab idx ->
            { model | selectedTab = idx } ! []

        Msg.Mdl mdlMsg ->
            Material.update Msg.Mdl mdlMsg model



--     case action of
--         Msg.SetCurrentUrl url ->
--             handleSetCurrentUrl model url
--         Msg.SubmitCurrentUrl ->
--             { model | current_url = "" }
--                 ! [ Msg.SetCurrentUrl "" |> send
--                   , submitUrl model.current_url
--                   ]
--         Msg.SubmissionSuccess source_url locator ->
--             handleSubmissionSuccess locator model source_url
--         Msg.SubmissionError source_url msg ->
--             handleSubmissionError msg model source_url
--         Msg.StatusSuccess file_id details ->
--             handleStatusSuccess details file_id model
--         Msg.StatusError file_id msg ->
--             handleStatusError msg file_id model
--         Msg.SuggestionsSuccess source_url suggestions ->
--             { model | suggestions = suggestions } ! []
--         Msg.SuggestionsError source_url msg ->
--             model ! []
--         Msg.Mdl msg' ->
--             Material.update msg' model
--         Msg.Poll fileID msg ->
--             let
--                 (pollers, cmd) = Polling.update model.pollers fileID msg
--             in
--                 {model | pollers = pollers} ! [cmd]
