module Radix.Blockquote exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { content : String
        , size : Maybe Int
        , weight : Maybe Radix.Text.Weight
        , color : Maybe Radix.Color
        , isHighContrast : Bool
        , truncate : Bool
        , wrap : Maybe Radix.Text.Wrap
        }


new : String -> Config msg
new content =
    Config
        { content = content
        , size = Nothing
        , weight = Nothing
        , color = Nothing
        , isHighContrast = False
        , truncate = False
        , wrap = Nothing
        }


withSize : Int -> Config msg -> Config msg
withSize size (Config config) =
    Config
        { config
            | size = Just size
        }


withWeight : Radix.Text.Weight -> Config msg -> Config msg
withWeight weight (Config config) =
    Config
        { config
            | weight = Just weight
        }


withColor : Radix.Color -> Config msg -> Config msg
withColor color (Config config) =
    Config
        { config
            | color = Just color
        }


withHighContrast : Config msg -> Config msg
withHighContrast (Config config) =
    Config
        { config
            | isHighContrast = True
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
    Html.blockquote
        [ Html.Attributes.classList
            [ ( "rt-Text", True )
            , ( "rt-Blockquote", True )
            , ( "rt-truncate", config.truncate )
            , ( "rt-high-contrast", config.isHighContrast )
            , Radix.Internal.classListMaybe
                (\wrap -> Radix.Text.wrapToCss wrap)
                config.wrap
            , Radix.Internal.classListMaybe
                (\size -> "rt-r-size-" ++ String.fromInt size)
                config.size
            , Radix.Internal.classListMaybe
                Radix.Text.weightToCss
                config.weight
            ]
        , Radix.Internal.attributeMaybe
            (\color -> Html.Attributes.attribute "data-accent-color" (Radix.colorToString color))
            config.color
        ]
        [ Html.text config.content ]
