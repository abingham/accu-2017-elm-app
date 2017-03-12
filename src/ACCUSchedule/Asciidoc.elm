module ACCUSchedule.Asciidoc exposing (toHtml)

import ACCUSchedule.Native.Asciidoc as Native

toHtml : List (Attribute msg) -> String -> Html msg
toHtml attrs string =
    Native.toHtml attrs string
