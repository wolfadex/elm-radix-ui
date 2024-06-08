module Radix.Slider exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Radix
import Radix.Flex exposing (directionToCss)
import Radix.Internal
import Radix.Separator exposing (Orientation(..))
import Radix.Slider.Thumb


type Config msg
    = Config
        { disabled : Bool
        , orientation : Orientation
        , direction : Direction
        , min : Float
        , max : Float
        , step : Float
        , minStepsBetweenThumbs : Float
        , thumbs : ( Radix.Slider.Thumb.Config msg, List (Radix.Slider.Thumb.Config msg) )
        , inverted : Bool

        --
        , size : Size
        , variant : Variant
        , color : Maybe Radix.Color
        , highContrast : Bool
        , radius : Maybe Radix.Radius

        --
        , customClassList : List ( String, Bool )
        , customStyles : List ( String, String )
        , customAttributes : List (Html.Attribute msg)
        }


type Orientation
    = Horizontal
    | Vertical


orientationToString : Orientation -> String
orientationToString orientation =
    case orientation of
        Horizontal ->
            "horizontal"

        Vertical ->
            "vertical"


type Direction
    = Ltr
    | Rtl


directionToString : Direction -> String
directionToString direction =
    case direction of
        Ltr ->
            "ltr"

        Rtl ->
            "rtl"


new :
    { thumbs : ( Radix.Slider.Thumb.Config msg, List (Radix.Slider.Thumb.Config msg) )
    }
    -> Config msg
new options =
    Config
        { min = 0
        , max = 100
        , disabled = False
        , orientation = Horizontal
        , direction = Ltr
        , step = 1
        , minStepsBetweenThumbs = 0
        , thumbs = options.thumbs
        , inverted = False
        , size = Size2
        , variant = Surface
        , color = Nothing
        , highContrast = False
        , radius = Nothing

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
    Config { config | highContrast = True }


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
        [ Html.Attributes.classList
            [ ( "rt-SliderRoot", True )
            , ( sizeToClass config.size, True )
            , ( variantToClass config.variant, True )
            ]
        , Radix.Internal.attributeMaybe
            (\color -> Html.Attributes.attribute "data-accent-color" (Radix.colorToString color))
            config.color
        , Radix.Internal.attributeMaybe
            (\radius ->
                Html.Attributes.attribute "data-radius" <| Radix.radiusToString radius
            )
            config.radius
        ]
        (let
            ( thumb, thumbs ) =
                config.thumbs
         in
         List.foldr
            (\thumb_ thumbs_ ->
                Radix.Slider.Thumb.view
                    { min = config.min
                    , max = config.max
                    , step = config.step
                    }
                    thumb_
                    :: thumbs_
            )
            []
            (thumb :: thumbs)
        )
