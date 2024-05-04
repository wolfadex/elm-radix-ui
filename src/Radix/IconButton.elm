module Radix.IconButton exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Radix
import Radix.Icon
import Radix.Internal
import Radix.Spinner
import Radix.Text


type Config msg
    = Config
        { icon : Radix.Icon.Config msg
        , onClick : msg
        , size : Int
        , variant : Variant
        , color : Maybe Radix.Color
        , isHighContrast : Bool
        , radius : Maybe Radix.Radius
        , isLoading : Bool
        , isDisabled : Bool
        }


type Variant
    = Classic
    | Solid
    | Soft
    | Surface
    | Outline
    | Ghost


variantToCss : Variant -> String
variantToCss variant =
    case variant of
        Classic ->
            "rt-variant-classic"

        Solid ->
            "rt-variant-solid"

        Soft ->
            "rt-variant-soft"

        Surface ->
            "rt-variant-surface"

        Outline ->
            "rt-variant-outline"

        Ghost ->
            "rt-variant-ghost"


new : { icon : Radix.Icon.Config msg, onClick : msg } -> Config msg
new options =
    Config
        { icon = options.icon
        , onClick = options.onClick
        , size = 2
        , variant = Solid
        , color = Nothing
        , isHighContrast = False
        , radius = Nothing
        , isLoading = False
        , isDisabled = False
        }


withSize1 : Config msg -> Config msg
withSize1 (Config config) =
    Config { config | size = 1 }


withSize3 : Config msg -> Config msg
withSize3 (Config config) =
    Config { config | size = 3 }


withSize4 : Config msg -> Config msg
withSize4 (Config config) =
    Config { config | size = 4 }


withVariantClassic : Config msg -> Config msg
withVariantClassic (Config config) =
    Config
        { config
            | variant = Classic
        }


withVariantSoft : Config msg -> Config msg
withVariantSoft (Config config) =
    Config
        { config
            | variant = Soft
        }


withVariantSurface : Config msg -> Config msg
withVariantSurface (Config config) =
    Config
        { config
            | variant = Surface
        }


withVariantOutline : Config msg -> Config msg
withVariantOutline (Config config) =
    Config
        { config
            | variant = Outline
        }


withVariantGhost : Config msg -> Config msg
withVariantGhost (Config config) =
    Config
        { config
            | variant = Ghost
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


withRadius : Radix.Radius -> Config msg -> Config msg
withRadius radius (Config config) =
    Config
        { config
            | radius = Just radius
        }


withLoading : Config msg -> Config msg
withLoading (Config config) =
    Config
        { config
            | isLoading = True
        }


withDisabled : Config msg -> Config msg
withDisabled (Config config) =
    Config
        { config
            | isDisabled = True
        }


view : Config msg -> Html msg
view (Config config) =
    let
        viewIcon =
            [ config.icon
                |> Radix.Icon.view
            ]
    in
    Html.button
        [ Html.Attributes.classList
            [ ( "rt-reset", True )
            , ( "rt-BaseButton", True )
            , ( "rt-IconButton", True )
            , ( variantToCss config.variant, True )
            , ( "rt-high-contrast", config.isHighContrast )
            , ( "rt-r-size-" ++ String.fromInt config.size, True )
            , ( "rt-r-loading", config.isLoading )
            ]
        , Html.Attributes.type_ "button"
        , Html.Events.onClick config.onClick
        , Radix.Internal.attributeMaybe
            (\color -> Html.Attributes.attribute "data-accent-color" (Radix.colorToString color))
            config.color
        , Radix.Internal.attributeMaybe
            (\radius ->
                Html.Attributes.attribute "data-radius" <| Radix.radiusToString radius
            )
            config.radius
        , Html.Attributes.attribute "data-disabled" "true"
            |> Radix.Internal.attributeIf (config.isDisabled || config.isLoading)
        , Html.Attributes.disabled (config.isDisabled || config.isLoading)
        ]
        (if config.isLoading then
            [ Html.span
                [ Html.Attributes.style "display" "contents"
                , Html.Attributes.style "visibility" "hidden"
                , Html.Attributes.attribute "aria-hidden" "true"
                ]
                viewIcon
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
                viewIcon
            , Radix.Spinner.new
                |> Radix.Spinner.withLoading
                |> Radix.Spinner.withSize
                    (case config.size of
                        1 ->
                            Radix.Size1

                        2 ->
                            Radix.Size2

                        3 ->
                            Radix.Size3

                        4 ->
                            Radix.Size4

                        _ ->
                            Radix.Size2
                    )
                |> Radix.Spinner.view
            ]

         else
            viewIcon
        )
