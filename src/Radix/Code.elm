module Radix.Code exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { content : String
        , size : Maybe Int
        , variant : Variant
        , weight : Maybe Radix.Text.Weight
        , color : Maybe Radix.Color
        , isHighContrast : Bool
        , truncate : Bool
        , wrap : Maybe Radix.Text.Wrap
        }


type Variant
    = Solid
    | Soft
    | Outline
    | Ghost


variantToCss : Variant -> String
variantToCss variant =
    case variant of
        Solid ->
            "rt-variant-solid"

        Soft ->
            "rt-variant-soft"

        Outline ->
            "rt-variant-outline"

        Ghost ->
            "rt-variant-ghost"


new : String -> Config msg
new content =
    Config
        { content = content
        , size = Nothing
        , variant = Soft
        , weight = Nothing
        , color = Nothing
        , isHighContrast = False
        , truncate = False
        , wrap = Nothing
        }


withSize : Int -> Config msg -> Config msg
withSize size (Config config) =
    Config
        { config
            | size = Just size
        }


withVariantSolid : Config msg -> Config msg
withVariantSolid (Config config) =
    Config
        { config
            | variant = Solid
        }


withVariantOutline : Config msg -> Config msg
withVariantOutline (Config config) =
    Config
        { config
            | variant = Outline
        }


withVariantGhost : Config msg -> Config msg
withVariantGhost (Config config) =
    Config
        { config
            | variant = Ghost
        }


withWeight : Radix.Text.Weight -> Config msg -> Config msg
withWeight weight (Config config) =
    Config
        { config
            | weight = Just weight
        }


withColor : Radix.Color -> Config msg -> Config msg
withColor color (Config config) =
    Config
        { config
            | color = Just color
        }


withHighContrast : Config msg -> Config msg
withHighContrast (Config config) =
    Config
        { config
            | isHighContrast = True
        }


withTruncation : Config msg -> Config msg
withTruncation (Config config) =
    Config
        { config
            | truncate = True
        }


withWrap : Radix.Text.Wrap -> Config msg -> Config msg
withWrap wrap (Config config) =
    Config
        { config
            | wrap = Just wrap
        }


view : Config msg -> Html msg
view (Config config) =
    Html.code
        [ Html.Attributes.classList
            [ ( "rt-Code", True )
            , ( "rt-truncate", config.truncate )
            , ( variantToCss config.variant, True )
            , ( "rt-high-contrast", config.isHighContrast )
            , Radix.Internal.classListMaybe
                (\size -> "rt-size-" ++ String.fromInt size)
                config.size
            , Radix.Internal.classListMaybe
                (\wrap -> Radix.Text.wrapToCss wrap)
                config.wrap
            , Radix.Internal.classListMaybe
                (\weight -> Radix.Text.weightToCss weight)
                config.weight
            ]
        , Radix.Internal.attributeMaybe
            (\color -> Html.Attributes.attribute "data-accent-color" (Radix.colorToString color))
            config.color
        ]
        [ Html.text config.content ]
