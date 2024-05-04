module Radix.DataList.Label exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { label : String
        , width : Maybe String
        , minWidth : Maybe String
        , maxWidth : Maybe String
        , color : Maybe Radix.Color
        , isHighContrast : Bool
        }


new : String -> Config msg
new label =
    Config
        { label = label
        , width = Nothing
        , minWidth = Nothing
        , maxWidth = Nothing
        , color = Nothing
        , isHighContrast = False
        }


withWidth : String -> Config msg -> Config msg
withWidth width (Config config) =
    Config { config | width = Just width }


withMinWidth : String -> Config msg -> Config msg
withMinWidth minWidth (Config config) =
    Config { config | minWidth = Just minWidth }


withMaxWidth : String -> Config msg -> Config msg
withMaxWidth maxWidth (Config config) =
    Config { config | maxWidth = Just maxWidth }


withColor : Radix.Color -> Config msg -> Config msg
withColor color (Config config) =
    Config { config | color = Just color }


withHighContrast : Config msg -> Config msg
withHighContrast (Config config) =
    Config { config | isHighContrast = True }


view : Config msg -> Html msg
view (Config config) =
    Html.dt
        [ Html.Attributes.classList
            [ ( "rt-DataListLabel", True )
            , ( "rt-r-w", config.width /= Nothing )
            , ( "rt-r-min-w", config.minWidth /= Nothing )
            , ( "rt-r-max-w", config.maxWidth /= Nothing )
            ]
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
            ]
            |> Radix.Internal.styles
        ]
        [ Html.text config.label
        ]
