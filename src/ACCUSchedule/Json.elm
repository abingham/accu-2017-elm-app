module ACCUSchedule.Json exposing (..)

{-| Json en/decoders (and a few other converters) for various data types in the
app.

# JSON decoders
@docs conversionDetailsDecoder, convertDecoder, statusDecoder, suggestionDecoder

# HTTP helpers
@docs statusDecoder

-}

-- import ACCUSchedule.Types as Types
-- import Http
-- import Json.Decode exposing ((:=), andThen, Decoder, string, succeed)
-- import Json.Decode.Pipeline exposing (decode, required)

foo : Int -> Int
foo x = x

-- {-| Convert an HTTP error to human-readable string.
-- -}
-- errorToString : Http.Error -> String
-- errorToString err =
--     case err of
--         Http.UnexpectedPayload msg ->
--             msg

--         Http.NetworkError ->
--             "Network error"

--         Http.Timeout ->
--             "Timeout"

--         Http.BadResponse i r ->
--             r


-- suggestionDecoder : Decoder Types.Suggestion
-- suggestionDecoder =
--     decode Types.Suggestion
--         |> required "source_url" string
--         |> required "download_url" string
--         |> required "file_id" string
--         |> required "timestamp" string



-- -- Decodes the JSON response from a conversion request into an `Output`.


-- convertDecoder : Decoder Types.StatusLocator
-- convertDecoder =
--     decode Types.StatusLocator
--         |> required "file_id" string
--         |> required "status_url" string


-- statusDecoder : Types.FileID -> Types.URL -> Decoder Types.ConversionDetails
-- statusDecoder file_id status_url =
--     ("status" := string) `andThen` (conversionDetailsDecoder file_id status_url)


-- conversionDetailsDecoder : Types.FileID -> Types.URL -> String -> Decoder Types.ConversionDetails
-- conversionDetailsDecoder file_id status_url status =
--     case status of
--         "in-progress" ->
--             decode
--                 (\ts msg ->
--                     let
--                         locator =
--                             Types.StatusLocator file_id status_url

--                         details =
--                             Types.InProgressDetails ts msg locator
--                     in
--                         Types.InProgress details
--                 )
--                 |> required "timestamp" string
--                 |> required "status_msg" string

--         "complete" ->
--             decode
--                 (\ts dl ->
--                     let
--                         locator =
--                             Types.StatusLocator file_id status_url

--                         details =
--                             Types.CompleteDetails locator ts dl
--                     in
--                         Types.Complete details
--                 )
--                 |> required "timestamp" string
--                 |> required "download_url" string

--         "error" ->
--             decode Types.Error
--                 |> required "status_msg" string

--         _ ->
--             let
--                 msg =
--                     "Unknown status code: " ++ toString status

--                 details =
--                     Types.Error msg
--             in
--                 succeed details
