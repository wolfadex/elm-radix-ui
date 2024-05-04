module Radix.Checkbox exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Flex
import Radix.Icon
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { content : List (Html msg)
        , size : Int
        , variant : Variant
        , color : Maybe Radix.Color
        , isHighContrast : Bool

        --
        , defaultChecked : Bool
        , checked : Bool
        , isDisabled : Bool
        , onChange : Bool -> msg
        }


type Variant
    = Classic
    | Surface
    | Soft


variantToCss : Variant -> String
variantToCss variant =
    case variant of
        Classic ->
            "rt-variant-classic"

        Surface ->
            "rt-variant-surface"

        Soft ->
            "rt-variant-soft"


new : { checked : Bool, onChange : Bool -> msg } -> Config msg
new options =
    Config
        { content = []
        , size = 2
        , variant = Surface
        , color = Nothing
        , isHighContrast = False

        --
        , defaultChecked = False
        , checked = options.checked
        , isDisabled = False
        , onChange = options.onChange
        }


withSize1 : Config msg -> Config msg
withSize1 (Config config) =
    Config { config | size = 1 }


withSize3 : Config msg -> Config msg
withSize3 (Config config) =
    Config { config | size = 3 }


withVariantClassic : Config msg -> Config msg
withVariantClassic (Config config) =
    Config { config | variant = Classic }


withVariantSoft : Config msg -> Config msg
withVariantSoft (Config config) =
    Config { config | variant = Soft }


withColor : Radix.Color -> Config msg -> Config msg
withColor color (Config config) =
    Config { config | color = Just color }


withHighContrast : Config msg -> Config msg
withHighContrast (Config config) =
    Config { config | isHighContrast = True }


withContent : List (Html msg) -> Config msg -> Config msg
withContent content (Config config) =
    Config { config | content = content }


withDefaultChecked : Config msg -> Config msg
withDefaultChecked (Config config) =
    Config { config | defaultChecked = True }


withDisabled : Config msg -> Config msg
withDisabled (Config config) =
    Config { config | isDisabled = True }


view : Config msg -> Html msg
view (Config config) =
    let
        button =
            Html.button
                [ Html.Attributes.classList
                    [ ( "rt-reset", True )
                    , ( "rt-BaseCheckboxRoot", True )
                    , ( "rt-CheckboxRoot", True )
                    , ( "rt-r-size-" ++ String.fromInt config.size, True )
                    , ( variantToCss config.variant, True )
                    ]
                , Html.Attributes.type_ "button"
                , Html.Attributes.attribute "role" "checkbox"
                , Html.Attributes.attribute "data-state"
                    (if config.checked then
                        "checked"

                     else
                        "unchecked"
                    )
                , Html.Attributes.attribute "aria-checked"
                    (if config.checked then
                        "true"

                     else
                        "false"
                    )
                , Html.Attributes.value "on"
                , Html.Attributes.attribute "data-accent-color"
                    (config.color
                        |> Maybe.map Radix.colorToString
                        |> Maybe.withDefault ""
                    )
                , Html.Attributes.attribute "data-disabled" ""
                    |> Radix.Internal.attributeIf config.isDisabled
                , Html.Attributes.disabled config.isDisabled
                ]
                (if config.checked then
                    [ Radix.Icon.check
                        |> Radix.Icon.withCustomClassList
                            [ ( "rt-BaseCheckboxIndicator", True )
                            , ( "rt-CheckboxIndicator", True )
                            ]
                        |> Radix.Icon.view
                    ]

                 else
                    []
                )
    in
    case config.content of
        [] ->
            button

        content ->
            Radix.Text.new
                [ Radix.Flex.new (button :: content)
                    |> Radix.Flex.withGapScale 2
                    |> Radix.Flex.view
                ]
                |> Radix.Text.withSize config.size
                |> Radix.Text.view
