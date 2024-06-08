module Radix.Progress exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal


type Config msg
    = Config
        { value : Value
        , size : Size
        , variant : Variant
        , color : Maybe Radix.Color
        , isHighContrast : Bool
        , radius : Maybe Radix.Radius
        , duration : Maybe String

        --
        , customClassList : List ( String, Bool )
        , customStyles : List ( String, String )
        , customAttributes : List (Html.Attribute msg)
        }


type Value
    = Indeterminate
    | Complete { value : Float, max : Float }
    | Loading { value : Float, max : Float }


{-| A percentage of completion, from 0 to 100
-}
new : { value : Value } -> Config msg
new options =
    Config
        { value = options.value
        , size = Size2
        , variant = Surface
        , color = Nothing
        , radius = Nothing
        , isHighContrast = False
        , duration = Nothing

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


withHighContrast : Config msg -> Config msg
withHighContrast (Config config) =
    Config { config | isHighContrast = True }


withDuration : String -> Config msg -> Config msg
withDuration duration (Config config) =
    Config { config | duration = Just duration }


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


view : Config msg -> Html msg
view (Config config) =
    Html.div
        ([ Html.Attributes.classList
            ([ ( "rt-ProgressRoot", True )
             , ( sizeToClass config.size, True )
             , ( variantToCss config.variant, True )
             ]
                ++ config.customClassList
            )
         , Radix.Internal.attributeMaybe
            (\radius ->
                Html.Attributes.attribute "data-radius" <| Radix.radiusToString radius
            )
            config.radius
         , Html.Attributes.attribute "role" "progressbar"
         , Html.Attributes.attribute "aria-valuemin" "0"
         , Radix.Internal.attributeMaybe
            (\max -> Html.Attributes.attribute "data-max" (String.fromFloat max))
            (case config.value of
                Loading { max } ->
                    Just max

                Complete { max } ->
                    Just max

                Indeterminate ->
                    Nothing
            )
         , Radix.Internal.attributeMaybe
            (\value -> Html.Attributes.attribute "data-value" (String.fromFloat value))
            (case config.value of
                Loading { value } ->
                    Just value

                Complete { value } ->
                    Just value

                Indeterminate ->
                    Nothing
            )
         , Radix.Internal.attributeMaybe
            (\max -> Html.Attributes.attribute "aria-valuemax" (String.fromFloat max))
            (case config.value of
                Loading { max } ->
                    Just max

                Complete { max } ->
                    Just max

                Indeterminate ->
                    Nothing
            )
         , Radix.Internal.attributeMaybe
            (\value -> Html.Attributes.attribute "aria-valuenow" (String.fromFloat value))
            (case config.value of
                Loading { value } ->
                    Just value

                Complete { value } ->
                    Just value

                Indeterminate ->
                    Nothing
            )
         , Radix.Internal.attributeMaybe
            (\{ value, max } -> Html.Attributes.attribute "aria-valuetext" (String.fromInt (round (value / max * 100)) ++ "%"))
            (case config.value of
                Loading details ->
                    Just details

                Complete details ->
                    Just details

                Indeterminate ->
                    Nothing
            )
         , Html.Attributes.attribute "data-state" <|
            case config.value of
                Loading _ ->
                    "loading"

                Indeterminate ->
                    "indeterminate"

                Complete _ ->
                    "complete"
         , Radix.Internal.attributeMaybe
            (\max -> Html.Attributes.attribute "data-max" (String.fromFloat max))
            (case config.value of
                Loading { max } ->
                    Just max

                Complete { max } ->
                    Just max

                Indeterminate ->
                    Nothing
            )
         , Radix.Internal.attributeMaybe
            (\value -> Html.Attributes.attribute "data-value" (String.fromFloat value))
            (case config.value of
                Loading { value } ->
                    Just value

                Complete { value } ->
                    Just value

                Indeterminate ->
                    Nothing
            )
         , Radix.styles
            (List.filterMap identity
                [ Maybe.map
                    (\duration ->
                        ( "--progress-duration", duration )
                    )
                    config.duration
                , config.value
                    |> (\val ->
                            case val of
                                Loading { value } ->
                                    Just value

                                Complete { value } ->
                                    Just value

                                Indeterminate ->
                                    Nothing
                       )
                    |> Maybe.map
                        (\value ->
                            ( "--progress-value", String.fromFloat value )
                        )
                , config.value
                    |> (\val ->
                            case val of
                                Loading { max } ->
                                    Just max

                                Complete { max } ->
                                    Just max

                                Indeterminate ->
                                    Nothing
                       )
                    |> Maybe.map
                        (\max ->
                            ( "--progress-max", String.fromFloat max )
                        )
                ]
                ++ config.customStyles
            )
         ]
            ++ config.customAttributes
        )
        [ Html.div
            [ Html.Attributes.classList
                [ ( "rt-ProgressIndicator", True )
                , ( "rt-high-contrast", config.isHighContrast )
                ]
            , Html.Attributes.attribute "data-state" <|
                case config.value of
                    Loading _ ->
                        "loading"

                    Indeterminate ->
                        "indeterminate"

                    Complete _ ->
                        "complete"
            ]
            []
        ]
