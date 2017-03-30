module ACCUSchedule.Asciidoc exposing (toHtml)

import Native.Asciidoc

import Html exposing (Attribute, Html)

toHtml : List (Attribute msg) -> String -> Html msg
toHtml attrs string =
    Native.Asciidoc.toHtml attrs string
