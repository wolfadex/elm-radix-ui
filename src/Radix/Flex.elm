module Radix.Flex exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal


type Config msg
    = Config
        { content : List (Html msg)
        , node : String
        , gap : Maybe EnumOrLiteral
        , align : Maybe Radix.Alignment
        , justify : Maybe Radix.Justify
        , direction : Direction
        , wrap : Maybe Wrapping
        }


type Wrapping
    = NoWrap
    | Wrap
    | WrapReverse


wrapToCss : Wrapping -> String
wrapToCss wrap =
    "rt-r-fw-wrap-"
        ++ (case wrap of
                NoWrap ->
                    "nowrap"

                Wrap ->
                    "wrap"

                WrapReverse ->
                    "wrap-reverse"
           )


type EnumOrLiteral
    = Enum Int
    | Literal String


new : List (Html msg) -> Config msg
new content =
    Config
        { content = content
        , node = "div"
        , gap = Nothing
        , align = Nothing
        , justify = Nothing
        , direction = Row
        , wrap = Nothing
        }


withAsSpan : Config msg -> Config msg
withAsSpan (Config config) =
    Config
        { config
            | node = "span"
        }


withGapScale : Int -> Config msg -> Config msg
withGapScale scale (Config config) =
    Config
        { config
            | gap = Just (Enum scale)
        }


withGapLiteral : String -> Config msg -> Config msg
withGapLiteral literal (Config config) =
    Config
        { config
            | gap = Just (Literal literal)
        }


withAlignment : Radix.Alignment -> Config msg -> Config msg
withAlignment alignment (Config config) =
    Config
        { config
            | align = Just alignment
        }


withJustification : Radix.Justify -> Config msg -> Config msg
withJustification justify (Config config) =
    Config
        { config
            | justify = Just justify
        }


type Direction
    = Row
    | RowReverse
    | Column
    | ColumnReverse


withDirection : Direction -> Config msg -> Config msg
withDirection direction (Config config) =
    Config
        { config
            | direction = direction
        }


directionToCss : Direction -> String
directionToCss direction =
    "rt-r-fd-"
        ++ (case direction of
                Row ->
                    "row"

                RowReverse ->
                    "row-reverse"

                Column ->
                    "column"

                ColumnReverse ->
                    "column-reverse"
           )


view : Config msg -> Html msg
view (Config config) =
    Html.node config.node
        [ Html.Attributes.classList
            [ ( "rt-Flex", True )
            , ( directionToCss config.direction, True )
            , case config.gap of
                Nothing ->
                    ( "", False )

                Just (Enum scale) ->
                    ( "rt-r-gap-" ++ String.fromInt scale, True )

                Just (Literal literal) ->
                    ( "", False )
            , classListMaybe
                (\alignment -> Radix.alignmentToCss alignment)
                config.align
            , classListMaybe
                (\justify -> Radix.justifyToCss justify)
                config.justify
            , classListMaybe
                (\wrap -> wrapToCss wrap)
                config.wrap
            ]
        , Radix.Internal.attributeMaybe
            (\gap ->
                case gap of
                    Enum _ ->
                        Html.Attributes.class ""

                    Literal literal ->
                        Html.Attributes.style "gap" literal
            )
            config.gap
        ]
        config.content


classListMaybe : (a -> String) -> Maybe a -> ( String, Bool )
classListMaybe f maybe =
    case maybe of
        Nothing ->
            ( "", False )

        Just a ->
            ( f a, True )
