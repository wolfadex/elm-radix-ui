module Radix.Callout exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { content : List (Html msg)
        , icon : Html msg
        , size : Int
        , variant : Variant
        , color : Maybe Radix.Color
        , isHighContrast : Bool
        , isAlert : Bool
        }


type Variant
    = Soft
    | Surface
    | Outline


variantToCss : Variant -> String
variantToCss variant =
    case variant of
        Soft ->
            "rt-variant-soft"

        Surface ->
            "rt-variant-surface"

        Outline ->
            "rt-variant-outline"


new : { content : List (Html msg), icon : Html msg } -> Config msg
new options =
    Config
        { content = options.content
        , icon = options.icon
        , size = 2
        , variant = Soft
        , color = Nothing
        , isHighContrast = False
        , isAlert = False
        }


withSize1 : Config msg -> Config msg
withSize1 (Config config) =
    Config { config | size = 1 }


withSize3 : Config msg -> Config msg
withSize3 (Config config) =
    Config { config | size = 3 }


withVariantSurface : Config msg -> Config msg
withVariantSurface (Config config) =
    Config { config | variant = Surface }


withVariantOutline : Config msg -> Config msg
withVariantOutline (Config config) =
    Config { config | variant = Outline }


withColor : Radix.Color -> Config msg -> Config msg
withColor color (Config config) =
    Config { config | color = Just color }


withHighContrast : Config msg -> Config msg
withHighContrast (Config config) =
    Config { config | isHighContrast = True }


withIsAlert : Config msg -> Config msg
withIsAlert (Config config) =
    Config { config | isAlert = True }


view : Config msg -> Html msg
view (Config config) =
    Html.span
        [ Html.Attributes.classList
            [ ( "rt-CalloutRoot", True )
            , ( variantToCss config.variant, True )
            , ( "rt-r-size-" ++ String.fromInt config.size, True )
            , ( "rt-high-contrast", config.isHighContrast )
            ]
        , Radix.Internal.attributeMaybe
            (\color ->
                Html.Attributes.attribute "data-accent-color" (Radix.colorToString color)
            )
            config.color
        , Html.Attributes.attribute "role" "alert"
            |> Radix.Internal.attributeIf config.isAlert
        ]
        [ Html.div
            [ Html.Attributes.classList
                [ ( "rt-Text", True )
                , ( "rt-CalloutIcon", True )
                , ( variantToCss config.variant, True )
                , ( "rt-r-size-" ++ String.fromInt config.size, True )
                ]
            ]
            [ config.icon ]
        , Html.p
            [ Html.Attributes.classList
                [ ( "rt-Text", True )
                , ( "rt-CalloutText", True )
                , ( "rt-r-size-" ++ String.fromInt config.size, True )
                ]
            ]
            config.content
        ]
