module Radix.Card exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { content : List (Html msg)
        , size : Int
        , variant : Variant
        }


type Variant
    = Surface
    | Classic
    | Ghost


variantToCss : Variant -> String
variantToCss variant =
    case variant of
        Surface ->
            "rt-variant-surface"

        Classic ->
            "rt-variant-classic"

        Ghost ->
            "rt-variant-ghost"


new : List (Html msg) -> Config msg
new content =
    Config
        { content = content
        , size = 1
        , variant = Surface
        }


withSize2 : Config msg -> Config msg
withSize2 (Config config) =
    Config { config | size = 2 }


withSize3 : Config msg -> Config msg
withSize3 (Config config) =
    Config { config | size = 3 }


withSize4 : Config msg -> Config msg
withSize4 (Config config) =
    Config { config | size = 4 }


withSize5 : Config msg -> Config msg
withSize5 (Config config) =
    Config { config | size = 5 }


withVariantClassic : Config msg -> Config msg
withVariantClassic (Config config) =
    Config { config | variant = Classic }


withVariantGhost : Config msg -> Config msg
withVariantGhost (Config config) =
    Config { config | variant = Ghost }


view : Config msg -> Html msg
view (Config config) =
    Html.span
        [ Html.Attributes.classList
            [ ( "rt-BaseCard", True )
            , ( "rt-Card", True )
            , ( variantToCss config.variant, True )
            , ( "rt-r-size-" ++ String.fromInt config.size, True )
            ]
        ]
        config.content
