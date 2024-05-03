module Radix.Text exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal


type Config msg
    = Config
        { content : List (Html msg)
        , node : String
        , color : Maybe Radix.Color
        , isHighContrast : Bool
        , size : Maybe Int
        , weight : Maybe Weight
        , truncate : Bool
        , alignment : Maybe Align
        , trim : Maybe Trim
        , wrap : Maybe Wrap
        }


type Weight
    = Light
    | Regular
    | Medium
    | Bold


weightToCss : Weight -> String
weightToCss weight =
    "rt-r-weight-"
        ++ (case weight of
                Light ->
                    "light"

                Regular ->
                    "regular"

                Medium ->
                    "medium"

                Bold ->
                    "bold"
           )


type Align
    = Left
    | Center
    | Right


alignToCss : Align -> String
alignToCss align =
    "rt-r-ta-"
        ++ (case align of
                Left ->
                    "left"

                Center ->
                    "center"

                Right ->
                    "right"
           )


type Trim
    = Normal
    | Start
    | End
    | Both


trimToCss : Trim -> String
trimToCss trim =
    "rt-r-lt-"
        ++ (case trim of
                Normal ->
                    "normal"

                Start ->
                    "start"

                End ->
                    "end"

                Both ->
                    "both"
           )


type Wrap
    = Wrap
    | Nowrap
    | Pretty
    | Balance


wrapToCss : Wrap -> String
wrapToCss wrap =
    "rt-r-tw-"
        ++ (case wrap of
                Wrap ->
                    "wrap"

                Nowrap ->
                    "nowrap"

                Pretty ->
                    "pretty"

                Balance ->
                    "balance"
           )


new : List (Html msg) -> Config msg
new content =
    Config
        { content = content
        , node = "span"
        , color = Nothing
        , isHighContrast = False
        , size = Nothing
        , weight = Nothing
        , truncate = False
        , alignment = Nothing
        , trim = Nothing
        , wrap = Nothing
        }


asDiv : Config msg -> Config msg
asDiv (Config config) =
    Config
        { config
            | node = "div"
        }


asLabel : Config msg -> Config msg
asLabel (Config config) =
    Config
        { config
            | node = "label"
        }


asParagraph : Config msg -> Config msg
asParagraph (Config config) =
    Config
        { config
            | node = "p"
        }


withSize : Int -> Config msg -> Config msg
withSize size (Config config) =
    Config
        { config
            | size = Just size
        }


withWeight : Weight -> Config msg -> Config msg
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


withAlignment : Align -> Config msg -> Config msg
withAlignment alignment (Config config) =
    Config
        { config
            | alignment = Just alignment
        }


withTrim : Trim -> Config msg -> Config msg
withTrim trim (Config config) =
    Config
        { config
            | trim = Just trim
        }


withWrap : Wrap -> Config msg -> Config msg
withWrap wrap (Config config) =
    Config
        { config
            | wrap = Just wrap
        }


view : Config msg -> Html msg
view (Config config) =
    Html.node config.node
        [ Html.Attributes.classList
            [ ( "rt-Text", True )
            , ( "rt-truncate", config.truncate )
            , ( "rt-high-contrast", config.isHighContrast )
            , Radix.Internal.classListMaybe
                (\size -> "rt-r-size-" ++ String.fromInt size)
                config.size
            , Radix.Internal.classListMaybe
                (\weight -> weightToCss weight)
                config.weight
            , Radix.Internal.classListMaybe
                (\alignment -> alignToCss alignment)
                config.alignment
            , Radix.Internal.classListMaybe
                (\trim -> trimToCss trim)
                config.trim
            , Radix.Internal.classListMaybe
                (\wrap -> wrapToCss wrap)
                config.wrap
            ]
        , Radix.Internal.attributeMaybe
            (\color -> Html.Attributes.attribute "data-accent-color" (Radix.colorToString color))
            config.color
        ]
        config.content
