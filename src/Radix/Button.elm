module Radix.Button exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Radix
import Radix.Internal



-- CONFIG


type Config msg
    = Config
        { content : List (Html msg)
        , onClick : msg
        , size : Size
        , variant : Variant
        , isHighContrast : Bool
        , isDisabled : Bool
        , accentColor : Maybe Radix.Color
        , radiusOverride : Maybe Radix.Radius
        , isLoading : Bool
        }



-- OPTIONS


type Size
    = S1
    | S2
    | S3
    | S4


sizeToCss : Size -> String
sizeToCss size =
    "rt-r-size-"
        ++ (case size of
                S1 ->
                    "1"

                S2 ->
                    "2"

                S3 ->
                    "3"

                S4 ->
                    "4"
           )


withSize1 : Config msg -> Config msg
withSize1 (Config config) =
    Config
        { config
            | size = S1
        }


withSize3 : Config msg -> Config msg
withSize3 (Config config) =
    Config
        { config
            | size = S3
        }


withSize4 : Config msg -> Config msg
withSize4 (Config config) =
    Config
        { config
            | size = S4
        }


type Variant
    = VClassic
    | VSolid
    | VSoft
    | VSurface
    | VOutline
    | VGhost


variantToCss : Variant -> String
variantToCss variant =
    "rt-variant-"
        ++ (case variant of
                VClassic ->
                    "classic"

                VSolid ->
                    "solid"

                VSoft ->
                    "soft"

                VSurface ->
                    "surface"

                VOutline ->
                    "outline"

                VGhost ->
                    "ghost"
           )


withVariantClassic : Config msg -> Config msg
withVariantClassic (Config config) =
    Config
        { config
            | variant = VClassic
        }


withVariantSoft : Config msg -> Config msg
withVariantSoft (Config config) =
    Config
        { config
            | variant = VSoft
        }


withVariantSurface : Config msg -> Config msg
withVariantSurface (Config config) =
    Config
        { config
            | variant = VSurface
        }


withVariantOutline : Config msg -> Config msg
withVariantOutline (Config config) =
    Config
        { config
            | variant = VOutline
        }


withVariantGhost : Config msg -> Config msg
withVariantGhost (Config config) =
    Config
        { config
            | variant = VGhost
        }


withHighContrast : Config msg -> Config msg
withHighContrast (Config config) =
    Config
        { config
            | isHighContrast = True
        }


withIsDisabled : Config msg -> Config msg
withIsDisabled (Config config) =
    Config
        { config
            | isDisabled = True
        }


withAccentColor : Radix.Color -> Config msg -> Config msg
withAccentColor color (Config config) =
    Config
        { config
            | accentColor = Just color
        }


withRadius : Radix.Radius -> Config msg -> Config msg
withRadius radius (Config config) =
    Config
        { config
            | radiusOverride = Just radius
        }


withIsLoading : Config msg -> Config msg
withIsLoading (Config config) =
    Config
        { config
            | isLoading = True
        }



-- CREATE


new : { content : List (Html msg), onClick : msg } -> Config msg
new options =
    Config
        { content = options.content
        , onClick = options.onClick
        , size = S2
        , variant = VSolid
        , isHighContrast = False
        , isDisabled = False
        , accentColor = Nothing
        , radiusOverride = Nothing
        , isLoading = False
        }



-- VIEW


view : Config msg -> Html msg
view (Config config) =
    Html.button
        [ Html.Attributes.classList
            [ ( "rt-reset", True )
            , ( "rt-BaseButton", True )
            , ( "rt-Button", True )
            , ( sizeToCss config.size, True )
            , ( variantToCss config.variant, True )
            , ( "rt-high-contrast", config.isHighContrast )
            , ( "rt-loading", config.isLoading )
            ]
        , Html.Attributes.type_ "button"
        , Html.Events.onClick config.onClick
        , Html.Attributes.attribute "data-disabled" ""
            |> Radix.Internal.attributeIf config.isDisabled
        , Html.Attributes.attribute "highContrast" ""
            |> Radix.Internal.attributeIf config.isHighContrast
        , Html.Attributes.attribute "data-accent-color"
            (config.accentColor
                |> Maybe.map Radix.colorToString
                |> Maybe.withDefault ""
            )
        , Radix.Internal.attributeMaybe
            (\radiusOverride ->
                Html.Attributes.attribute "data-radius" <| Radix.radiusToString radiusOverride
            )
            config.radiusOverride
        ]
        config.content
