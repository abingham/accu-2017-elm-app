module Model exposing (..)

import Msg exposing (Msg)


-- MODEL


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )
