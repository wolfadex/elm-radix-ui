module Radix.Emphasis exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { content : String
        , truncate : Bool
        , wrap : Maybe Radix.Text.Wrap
        }


new : String -> Config msg
new content =
    Config
        { content = content
        , truncate = False
        , wrap = Nothing
        }


withTruncation : Config msg -> Config msg
withTruncation (Config config) =
    Config
        { config
            | truncate = True
        }


withWrap : Radix.Text.Wrap -> Config msg -> Config msg
withWrap wrap (Config config) =
    Config
        { config
            | wrap = Just wrap
        }


view : Config msg -> Html msg
view (Config config) =
    Html.em
        [ Html.Attributes.classList
            [ ( "rt-Em", True )
            , ( "rt-truncate", config.truncate )
            , Radix.Internal.classListMaybe
                (\wrap -> Radix.Text.wrapToCss wrap)
                config.wrap
            ]
        ]
        [ Html.text config.content ]
