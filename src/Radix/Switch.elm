module Radix.Switch exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Radix
import Radix.Internal



-- CONFIG


type Config msg
    = Config
        { onToggle : Bool -> msg
        , checked : Bool
        , size : Size
        , variant : Variant
        , isHighContrast : Bool
        , isDisabled : Bool
        , accentColor : Maybe Radix.Color
        , radiusOverride : Maybe Radix.Radius

        --
        , customClassList : List ( String, Bool )
        , customStyles : List ( String, String )
        , customAttributes : List (Html.Attribute msg)
        }



-- OPTIONS


type Size
    = Size1
    | Size2
    | Size3


sizeToCss : Size -> String
sizeToCss size =
    "rt-r-size-"
        ++ (case size of
                Size1 ->
                    "1"

                Size2 ->
                    "2"

                Size3 ->
                    "3"
           )


withSize1 : Config msg -> Config msg
withSize1 (Config config) =
    Config { config | size = Size1 }


withSize3 : Config msg -> Config msg
withSize3 (Config config) =
    Config { config | size = Size3 }


type Variant
    = Classic
    | Surface
    | Soft


variantToCss : Variant -> String
variantToCss variant =
    "rt-variant-"
        ++ (case variant of
                Classic ->
                    "classic"

                Soft ->
                    "soft"

                Surface ->
                    "surface"
           )


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


withColor : Radix.Color -> Config msg -> Config msg
withColor color (Config config) =
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


withCustomClassList : List ( String, Bool ) -> Config msg -> Config msg
withCustomClassList customClassList (Config config) =
    Config
        { config
            | customClassList = customClassList
        }


withCustomStyles : List ( String, String ) -> Config msg -> Config msg
withCustomStyles customStyles (Config config) =
    Config
        { config
            | customStyles = customStyles
        }


withCustomAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
withCustomAttributes customAttributes (Config config) =
    Config
        { config
            | customAttributes = customAttributes
        }


withDisabled : Config msg -> Config msg
withDisabled (Config config) =
    Config { config | isDisabled = True }



-- CREATE


new : { checked : Bool, onToggle : Bool -> msg } -> Config msg
new options =
    Config
        { onToggle = options.onToggle
        , checked = options.checked
        , size = Size2
        , variant = Surface
        , isHighContrast = False
        , isDisabled = False
        , accentColor = Nothing
        , radiusOverride = Nothing

        --
        , customClassList = []
        , customStyles = []
        , customAttributes = []
        }


boolToString : Bool -> String
boolToString bool =
    if bool then
        "true"

    else
        "false"



-- VIEW


view : Config msg -> Html msg
view (Config config) =
    Html.button
        ([ Html.Attributes.classList
            ([ ( "rt-reset", True )
             , ( "rt-SwitchRoot", True )
             , ( sizeToCss config.size, True )
             , ( variantToCss config.variant, True )
             , ( "rt-high-contrast", config.isHighContrast )
             ]
                ++ config.customClassList
            )
         , Html.Attributes.type_ "button"
         , Html.Attributes.attribute "role" "switch"
         , Html.Attributes.attribute "aria-checked" (boolToString config.checked)
         , Html.Attributes.attribute "data-state" <|
            if config.checked then
                "checked"

            else
                "unchecked"
         , Html.Attributes.value <|
            if config.checked then
                "on"

            else
                "off"
         , Radix.Internal.attributeMaybe
            (\accentColor -> Html.Attributes.attribute "data-accent-color" (Radix.colorToString accentColor))
            config.accentColor
         , Html.Attributes.attribute "highContrast" ""
            |> Radix.Internal.attributeIf config.isHighContrast
         , Radix.Internal.attributeMaybe
            (\radiusOverride ->
                Html.Attributes.attribute "data-radius" <| Radix.radiusToString radiusOverride
            )
            config.radiusOverride
         , Html.Events.onClick (config.onToggle (not config.checked))
         , Html.Attributes.disabled config.isDisabled
         , Radix.Internal.attributeIf config.isDisabled
            (Html.Attributes.attribute "data-disabled" "")
         , Radix.styles config.customStyles
         ]
            ++ config.customAttributes
        )
        [ Html.span
            [ Html.Attributes.classList
                [ ( "rt-SwitchThumb", True )
                ]
            , Html.Attributes.attribute "data-state" <|
                if config.checked then
                    "checked"

                else
                    "unchecked"
            , Radix.Internal.attributeIf config.isDisabled
                (Html.Attributes.attribute "data-disabled" "")
            ]
            []
        ]
