module Radix.TextField exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Radix
import Radix.Internal


type Config msg
    = Config
        { placeholder : Maybe String
        , value : String
        , onInput : String -> msg
        , size : Size
        , variant : Variant
        , color : Maybe Radix.Color
        , radius : Maybe Radix.Radius
        , slot : Maybe (Html msg)
        }


new : { value : String, onInput : String -> msg } -> Config msg
new options =
    Config
        { placeholder = Nothing
        , value = options.value
        , onInput = options.onInput
        , size = Size2
        , variant = Surface
        , color = Nothing
        , radius = Nothing
        , slot = Nothing
        }


withPlaceholder : String -> Config msg -> Config msg
withPlaceholder placeholder (Config config) =
    Config { config | placeholder = Just placeholder }


type Size
    = Size1
    | Size2
    | Size3


sizeToClass : Size -> String
sizeToClass size =
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

                Surface ->
                    "surface"

                Soft ->
                    "soft"
           )


withVariantClassic : Config msg -> Config msg
withVariantClassic (Config config) =
    Config { config | variant = Classic }


withVariantSoft : Config msg -> Config msg
withVariantSoft (Config config) =
    Config { config | variant = Soft }


withColor : Radix.Color -> Config msg -> Config msg
withColor color (Config config) =
    Config { config | color = Just color }


withRadius : Radix.Radius -> Config msg -> Config msg
withRadius radius (Config config) =
    Config { config | radius = Just radius }


withSlot : Html msg -> Config msg -> Config msg
withSlot slot (Config config) =
    Config { config | slot = Just slot }


view : Config msg -> Html msg
view (Config config) =
    Html.div
        [ Html.Attributes.classList
            [ ( "rt-TextFieldRoot", True )
            , ( sizeToClass config.size, True )
            , ( variantToCss config.variant, True )
            ]
        , Radix.Internal.attributeMaybe
            (\radius ->
                Html.Attributes.attribute "data-radius" <| Radix.radiusToString radius
            )
            config.radius
        ]
        [ Html.input
            [ Html.Attributes.class "rt-reset rt-TextFieldInput"
            , Html.Attributes.value config.value
            , Html.Events.onInput config.onInput
            , Radix.Internal.attributeMaybe
                Html.Attributes.placeholder
                config.placeholder
            ]
            []
        , case config.slot of
            Nothing ->
                Html.text ""

            Just slot ->
                Html.div
                    [ Html.Attributes.class "rt-TextFieldSlot" ]
                    [ slot ]
        ]
