module Radix.Link exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { content : List (Html msg)
        , href : String
        , color : Maybe Radix.Color
        , isHighContrast : Bool
        , size : Maybe Int
        , weight : Maybe Radix.Text.Weight
        , truncate : Bool
        , trim : Maybe Radix.Text.Trim
        , wrap : Maybe Radix.Text.Wrap
        , underline : Underline
        , openInNewTab : Bool
        }


type Underline
    = Auto
    | Always
    | Hover
    | None


underlineToCss : Underline -> String
underlineToCss underline =
    "rt-underline-"
        ++ (case underline of
                Auto ->
                    "auto"

                Always ->
                    "always"

                Hover ->
                    "hover"

                None ->
                    "none"
           )


new : { content : List (Html msg), href : String } -> Config msg
new options =
    Config
        { content = options.content
        , href = options.href
        , color = Nothing
        , isHighContrast = False
        , size = Nothing
        , weight = Nothing
        , truncate = False
        , trim = Nothing
        , wrap = Nothing
        , underline = Auto
        , openInNewTab = False
        }


withSize : Int -> Config msg -> Config msg
withSize size (Config config) =
    Config
        { config
            | size = Just size
        }


withWeight : Radix.Text.Weight -> Config msg -> Config msg
withWeight weight (Config config) =
    Config
        { config
            | weight = Just weight
        }


withTruncation : Config msg -> Config msg
withTruncation (Config config) =
    Config
        { config
            | truncate = True
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


withTrim : Radix.Text.Trim -> Config msg -> Config msg
withTrim trim (Config config) =
    Config
        { config
            | trim = Just trim
        }


withWrap : Radix.Text.Wrap -> Config msg -> Config msg
withWrap wrap (Config config) =
    Config
        { config
            | wrap = Just wrap
        }


withOpenInNewTab : Config msg -> Config msg
withOpenInNewTab (Config config) =
    Config
        { config
            | openInNewTab = True
        }


view : Config msg -> Html msg
view (Config config) =
    Html.a
        [ Html.Attributes.classList
            [ ( "rt-Text", True )
            , ( "rt-Link", True )
            , ( "rt-truncate", config.truncate )
            , ( "rt-high-contrast", config.isHighContrast )
            , ( underlineToCss config.underline, True )
            , Radix.Internal.classListMaybe
                (\size -> "rt-r-size-" ++ String.fromInt size)
                config.size
            , Radix.Internal.classListMaybe
                (\weight -> Radix.Text.weightToCss weight)
                config.weight
            , Radix.Internal.classListMaybe
                (\trim -> Radix.Text.trimToCss trim)
                config.trim
            , Radix.Internal.classListMaybe
                (\wrap -> Radix.Text.wrapToCss wrap)
                config.wrap
            ]
        , Radix.Internal.attributeMaybe
            (\color -> Html.Attributes.attribute "data-accent-color" (Radix.colorToString color))
            config.color
        , Html.Attributes.href config.href
        , Html.Attributes.target "_blank"
            |> Radix.Internal.attributeIf config.openInNewTab
        ]
        config.content
