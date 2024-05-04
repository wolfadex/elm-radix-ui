module Radix.Avatar exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { src : Maybe String
        , fallback : Fallback msg
        , size : Int
        , variant : Variant
        , color : Maybe Radix.Color
        , isHighContrast : Bool
        , radius : Maybe Radix.Radius
        }


type Fallback msg
    = Initials String
    | FallbackHtml (Html msg)


type Variant
    = Solid
    | Soft


variantToCss : Variant -> String
variantToCss variant =
    case variant of
        Solid ->
            "rt-variant-solid"

        Soft ->
            "rt-variant-soft"


new : Fallback msg -> Config msg
new fallback =
    Config
        { fallback = fallback
        , src = Nothing
        , size = 3
        , variant = Soft
        , color = Nothing
        , isHighContrast = False
        , radius = Nothing
        }


withSrc : String -> Config msg -> Config msg
withSrc src (Config config) =
    Config { config | src = Just src }


withSize : Int -> Config msg -> Config msg
withSize size (Config config) =
    Config { config | size = size }


withVariantSolid : Config msg -> Config msg
withVariantSolid (Config config) =
    Config { config | variant = Solid }


withColor : Radix.Color -> Config msg -> Config msg
withColor color (Config config) =
    Config { config | color = Just color }


withRadius : Radix.Radius -> Config msg -> Config msg
withRadius radius (Config config) =
    Config { config | radius = Just radius }


withHighContrast : Config msg -> Config msg
withHighContrast (Config config) =
    Config { config | isHighContrast = True }


view : Config msg -> Html msg
view (Config config) =
    Html.span
        [ Html.Attributes.classList
            [ ( "rt-AvatarRoot", True )
            , ( variantToCss config.variant, True )
            , ( "rt-r-size-" ++ String.fromInt config.size, True )
            , ( "rt-high-contrast", config.isHighContrast )
            ]
        , Radix.Internal.attributeMaybe
            (\color ->
                Html.Attributes.attribute "data-accent-color" (Radix.colorToString color)
            )
            config.color
        , Radix.Internal.attributeMaybe
            (\radius ->
                Html.Attributes.attribute "data-radius" <| Radix.radiusToString radius
            )
            config.radius
        ]
        [ case config.src of
            Just src ->
                Html.img
                    [ Html.Attributes.class "rt-AvatarImage"
                    , Html.Attributes.src src
                    ]
                    []

            Nothing ->
                Html.span
                    [ Html.Attributes.classList
                        [ ( "rt-AvatarFallback", True )
                        , case config.fallback of
                            Initials initials ->
                                case String.length initials of
                                    1 ->
                                        ( "rt-one-letter", True )

                                    2 ->
                                        ( "rt-two-letters", True )

                                    _ ->
                                        ( "", False )

                            FallbackHtml html ->
                                ( "", False )
                        ]
                    ]
                    [ case config.fallback of
                        Initials initials ->
                            Html.text initials

                        FallbackHtml html ->
                            html
                    ]
        ]
