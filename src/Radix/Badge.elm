module Radix.Badge exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { content : String
        , size : Int
        , variant : Variant
        , color : Maybe Radix.Color
        , isHighContrast : Bool
        , radius : Maybe Radix.Radius
        }


type Variant
    = Solid
    | Soft
    | Surface
    | Outline


variantToCss : Variant -> String
variantToCss variant =
    case variant of
        Solid ->
            "rt-variant-solid"

        Soft ->
            "rt-variant-soft"

        Surface ->
            "rt-variant-surface"

        Outline ->
            "rt-variant-outline"


new : String -> Config msg
new content =
    Config
        { content = content
        , size = 1
        , variant = Soft
        , color = Nothing
        , isHighContrast = False
        , radius = Nothing
        }


withSize2 : Config msg -> Config msg
withSize2 (Config config) =
    Config { config | size = 2 }


withSize3 : Config msg -> Config msg
withSize3 (Config config) =
    Config { config | size = 3 }


withVariantSolid : Config msg -> Config msg
withVariantSolid (Config config) =
    Config { config | variant = Solid }


withColor : Radix.Color -> Config msg -> Config msg
withColor color (Config config) =
    Config { config | color = Just color }


withRadius : Radix.Radius -> Config msg -> Config msg
withRadius radius (Config config) =
    Config { config | radius = Just radius }


withHighContrast : Config msg -> Config msg
withHighContrast (Config config) =
    Config { config | isHighContrast = True }


view : Config msg -> Html msg
view (Config config) =
    Html.span
        [ Html.Attributes.classList
            [ ( "rt-Badge", True )
            , ( variantToCss config.variant, True )
            , ( "rt-r-size-" ++ String.fromInt config.size, True )
            , ( "rt-high-contrast", config.isHighContrast )
            ]
        , Radix.Internal.attributeMaybe
            (\color ->
                Html.Attributes.attribute "data-accent-color" (Radix.colorToString color)
            )
            config.color
        , Radix.Internal.attributeMaybe
            (\radius ->
                Html.Attributes.attribute "data-radius" <| Radix.radiusToString radius
            )
            config.radius
        ]
        [ Html.text config.content ]
