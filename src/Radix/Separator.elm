module Radix.Separator exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { orientation : Orientation
        , size : Int
        , color : Maybe Radix.Color
        , decorative : Bool
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


new : Config msg
new =
    Config
        { orientation = Horizontal
        , size = 1
        , color = Nothing
        , decorative = True
        }


withOrientationVertical : Config msg -> Config msg
withOrientationVertical (Config config) =
    Config { config | orientation = Vertical }


withSize2 : Config msg -> Config msg
withSize2 (Config config) =
    Config { config | size = 2 }


withSize3 : Config msg -> Config msg
withSize3 (Config config) =
    Config { config | size = 3 }


withSize4 : Config msg -> Config msg
withSize4 (Config config) =
    Config { config | size = 4 }


withColor : Radix.Color -> Config msg -> Config msg
withColor color (Config config) =
    Config { config | color = Just color }


eithNonDecorative : Config msg -> Config msg
eithNonDecorative (Config config) =
    Config { config | decorative = False }


view : Config msg -> Html msg
view (Config config) =
    Html.span
        [ Html.Attributes.classList
            -- rt-r-my-3 ???
            [ ( "rt-Separator", True )
            , ( orientationToCss config.orientation, True )
            , ( "rt-r-size-" ++ String.fromInt config.size, True )
            ]
        , Radix.Internal.attributeMaybe
            (\color -> Html.Attributes.attribute "data-accent-color" (Radix.colorToString color))
            config.color
        ]
        []
