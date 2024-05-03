module Radix.Box exposing (..)

import Html exposing (Html)
import Html.Attributes


type Config msg
    = Config
        { content : List (Html msg)
        }


new : List (Html msg) -> Config msg
new content =
    Config
        { content = content
        }


view : Config msg -> Html msg
view (Config config) =
    Html.div
        [ Html.Attributes.class "rt-Box" ]
        config.content
