module Radix.Button exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Radix
import Radix.Internal
import Radix.Spinner



-- CONFIG


type Config msg
    = Config
        { content : List (Html msg)
        , onClick : msg
        , size : Radix.Size
        , variant : Variant
        , isHighContrast : Bool
        , isDisabled : Bool
        , accentColor : Maybe Radix.Color
        , radiusOverride : Maybe Radix.Radius
        , isLoading : Bool
        }



-- OPTIONS


withSize : Radix.Size -> Config msg -> Config msg
withSize size (Config config) =
    Config
        { config
            | size = size
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
        , size = Radix.Size2
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
            , ( Radix.sizeToCss config.size, True )
            , ( variantToCss config.variant, True )
            , ( "rt-high-contrast", config.isHighContrast )
            , ( "rt-loading", config.isLoading )
            ]
        , Html.Attributes.type_ "button"
        , Html.Events.onClick config.onClick
        , Html.Attributes.attribute "data-disabled" ""
            |> Radix.Internal.attributeIf (config.isDisabled || config.isLoading)
        , Html.Attributes.disabled (config.isDisabled || config.isLoading)
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
        (if config.isLoading then
            [ Html.span
                [ Html.Attributes.style "display" "contents"
                , Html.Attributes.style "visibility" "hidden"
                , Html.Attributes.attribute "aria-hidden" "true"
                ]
                config.content
            , Html.span
                [ Html.Attributes.style "position" "absolute"
                , Html.Attributes.style "border" "0px"
                , Html.Attributes.style "width" "1px"
                , Html.Attributes.style "height" "1px"
                , Html.Attributes.style "padding" "0px"
                , Html.Attributes.style "margin" "-1px"
                , Html.Attributes.style "overflow" "hidden"
                , Html.Attributes.style "clip" "rect(0px, 0px, 0px, 0px)"
                , Html.Attributes.style "white-space" "nowrap"
                , Html.Attributes.style "overflow-wrap" "normal"
                ]
                config.content
            , Radix.Spinner.new
                |> Radix.Spinner.withLoading
                |> Radix.Spinner.withSize config.size
                |> Radix.Spinner.view
            ]

         else
            config.content
        )
