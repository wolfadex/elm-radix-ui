module Radix.Heading exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal


type Config msg
    = Config
        { content : String
        , node : String
        , color : Maybe Radix.Color
        , isHighContrast : Bool
        }


h1 : String -> Config msg
h1 =
    new "h1"


h2 : String -> Config msg
h2 =
    new "h2"


h3 : String -> Config msg
h3 =
    new "h3"


h4 : String -> Config msg
h4 =
    new "h4"


h5 : String -> Config msg
h5 =
    new "h5"


h6 : String -> Config msg
h6 =
    new "h6"


new : String -> String -> Config msg
new node content =
    Config
        { content = content
        , node = node
        , color = Nothing
        , isHighContrast = False
        }


view : Config msg -> Html msg
view (Config config) =
    Html.node config.node
        []
        [ Html.text config.content
        ]
