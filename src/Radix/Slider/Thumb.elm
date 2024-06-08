module Radix.Slider.Thumb exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Radix
import Radix.Internal


type Config msg
    = Config
        { value : Float
        , onInput : Float -> msg

        --
        , customClassList : List ( String, Bool )
        , customStyles : List ( String, String )
        , customAttributes : List (Html.Attribute msg)
        }


new :
    { value : Float
    , onInput : Float -> msg
    }
    -> Config msg
new options =
    Config
        { value = options.value
        , onInput = options.onInput

        --
        , customClassList = []
        , customStyles = []
        , customAttributes = []
        }


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


type Variant
    = Classic
    | Surface
    | Soft


variantToClass : Variant -> String
variantToClass variant =
    "rt-variant-"
        ++ (case variant of
                Classic ->
                    "classic"

                Surface ->
                    "surface"

                Soft ->
                    "soft"
           )


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


view : { min : Float, max : Float, step : Float } -> Config msg -> Html msg
view options (Config config) =
    Html.input
        [ Html.Attributes.type_ "range"
        , Html.Attributes.min (String.fromFloat options.min)
        , Html.Attributes.max (String.fromFloat options.max)
        , Html.Attributes.step (String.fromFloat options.step)
        , Html.Attributes.value (String.fromFloat config.value)
        , Html.Events.onInput
            (String.toFloat
                >> Maybe.withDefault config.value
                >> config.onInput
            )
        ]
        []
