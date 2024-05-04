module Radix.DataList exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.DataList.Item
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { items : List (Radix.DataList.Item.Config msg)
        , size : Int
        , orientation : Orientation
        , trim : Maybe Trim
        }


type Orientation
    = Horizontal
    | Vertical


orientationToCss : Orientation -> String
orientationToCss orientation =
    case orientation of
        Horizontal ->
            "rt-r-orientation-horizontal"

        Vertical ->
            "rt-r-orientation-vertical"


type Trim
    = Normal
    | Start
    | End
    | Both


trimToCss : Trim -> String
trimToCss trim =
    case trim of
        Normal ->
            "rt-r-trim-normal"

        Start ->
            "rt-r-trim-start"

        End ->
            "rt-r-trim-end"

        Both ->
            "rt-r-trim-both"


new : List (Radix.DataList.Item.Config msg) -> Config msg
new items =
    Config
        { items = items
        , size = 2
        , orientation = Horizontal
        , trim = Nothing
        }


withOrientationVertical : Config msg -> Config msg
withOrientationVertical (Config config) =
    Config { config | orientation = Vertical }


withSize1 : Config msg -> Config msg
withSize1 (Config config) =
    Config { config | size = 1 }


withSize3 : Config msg -> Config msg
withSize3 (Config config) =
    Config { config | size = 3 }


withTrimNormal : Config msg -> Config msg
withTrimNormal (Config config) =
    Config { config | trim = Just Normal }


withTrimStart : Config msg -> Config msg
withTrimStart (Config config) =
    Config { config | trim = Just Start }


withTrimEnd : Config msg -> Config msg
withTrimEnd (Config config) =
    Config { config | trim = Just End }


withTrimBoth : Config msg -> Config msg
withTrimBoth (Config config) =
    Config { config | trim = Just Both }


view : Config msg -> Html msg
view (Config config) =
    Html.dl
        [ Html.Attributes.classList
            [ ( "rt-Text", True )
            , ( "rt-DataListRoot", True )
            , ( "rt-r-size-" ++ String.fromInt config.size, True )
            , ( orientationToCss config.orientation, True )
            , Radix.Internal.classListMaybe
                trimToCss
                config.trim
            ]
        ]
        (List.map Radix.DataList.Item.view
            config.items
        )
