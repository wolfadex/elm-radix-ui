module Radix.Skeleton exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { loading : Bool
        , width : Maybe String
        , minWidth : Maybe String
        , maxWidth : Maybe String
        , height : Maybe String
        , minHeight : Maybe String
        , maxHeight : Maybe String
        , child : Maybe (Html msg)
        }


new : Config msg
new =
    Config
        { loading = True
        , width = Nothing
        , minWidth = Nothing
        , maxWidth = Nothing
        , height = Nothing
        , minHeight = Nothing
        , maxHeight = Nothing
        , child = Nothing
        }


withNotLoading : Config msg -> Config msg
withNotLoading (Config config) =
    Config
        { config | loading = False }


withWidth : String -> Config msg -> Config msg
withWidth width (Config config) =
    Config
        { config | width = Just width }


withMinWidth : String -> Config msg -> Config msg
withMinWidth minWidth (Config config) =
    Config
        { config | minWidth = Just minWidth }


withMaxWidth : String -> Config msg -> Config msg
withMaxWidth maxWidth (Config config) =
    Config
        { config | maxWidth = Just maxWidth }


withHeight : String -> Config msg -> Config msg
withHeight height (Config config) =
    Config
        { config | height = Just height }


withMinHeight : String -> Config msg -> Config msg
withMinHeight minHeight (Config config) =
    Config
        { config | minHeight = Just minHeight }


withMaxHeight : String -> Config msg -> Config msg
withMaxHeight maxHeight (Config config) =
    Config
        { config | maxHeight = Just maxHeight }


withChild : Html msg -> Config msg -> Config msg
withChild child (Config config) =
    Config
        { config | child = Just child }


view : Config msg -> Html msg
view (Config config) =
    Html.span
        [ Html.Attributes.classList
            [ ( "rt-Skeleton", True )
            , ( "rt-r-w", config.width /= Nothing )
            , ( "rt-r-min-w", config.minWidth /= Nothing )
            , ( "rt-r-max-w", config.maxWidth /= Nothing )
            , ( "rt-r-h", config.height /= Nothing )
            , ( "rt-r-min-h", config.minHeight /= Nothing )
            , ( "rt-r-max-h", config.maxHeight /= Nothing )
            ]
        , Html.Attributes.attribute "aria-hidden" "true"
        , Html.Attributes.attribute "data-inline-skeleton" "true"
        , Html.Attributes.tabindex -1
        , Html.Attributes.attribute "inert" ""
        , List.filterMap identity
            [ Maybe.map
                (\width -> ( "--width", width ))
                config.width
            , Maybe.map
                (\minWidth -> ( "--min-width", minWidth ))
                config.minWidth
            , Maybe.map
                (\maxWidth -> ( "--max-width", maxWidth ))
                config.maxWidth
            , Maybe.map
                (\height -> ( "--height", height ))
                config.height
            , Maybe.map
                (\minHeight -> ( "--min-height", minHeight ))
                config.minHeight
            , Maybe.map
                (\maxHeight -> ( "--max-height", maxHeight ))
                config.maxHeight
            ]
            |> Radix.styles
        ]
        (case config.child of
            Nothing ->
                []

            Just child ->
                [ child ]
        )
