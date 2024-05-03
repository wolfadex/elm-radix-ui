module Radix exposing (..)

import Html exposing (Html)
import Html.Attributes


type Color
    = Amber
    | Blue
    | Bronze
    | Brown
    | Crimson
    | Cyan
    | Gold
    | Grass
    | Gray
    | Green
    | Indigo
    | Iris
    | Jade
    | Lime
    | Mauve
    | Mint
    | Olive
    | Orange
    | Pink
    | Plum
    | Purple
    | Red
    | Ruby
    | Sage
    | Sand
    | Sky
    | Slate
    | Teal
    | Tomato
    | Violet
    | Yellow


allColors : List Color
allColors =
    [ Amber
    , Blue
    , Bronze
    , Brown
    , Crimson
    , Cyan
    , Gold
    , Grass
    , Gray
    , Green
    , Indigo
    , Iris
    , Jade
    , Lime
    , Mauve
    , Mint
    , Olive
    , Orange
    , Pink
    , Plum
    , Purple
    , Red
    , Ruby
    , Sage
    , Sand
    , Sky
    , Slate
    , Teal
    , Tomato
    , Violet
    , Yellow
    ]


colorToString : Color -> String
colorToString color =
    case color of
        Amber ->
            "amber"

        Blue ->
            "blue"

        Bronze ->
            "bronze"

        Brown ->
            "brown"

        Crimson ->
            "crimson"

        Cyan ->
            "cyan"

        Gold ->
            "gold"

        Grass ->
            "grass"

        Gray ->
            "gray"

        Green ->
            "green"

        Indigo ->
            "indigo"

        Iris ->
            "iris"

        Jade ->
            "jade"

        Lime ->
            "lime"

        Mauve ->
            "mauve"

        Mint ->
            "mint"

        Olive ->
            "olive"

        Orange ->
            "orange"

        Pink ->
            "pink"

        Plum ->
            "plum"

        Purple ->
            "purple"

        Red ->
            "red"

        Ruby ->
            "ruby"

        Sage ->
            "sage"

        Sand ->
            "sand"

        Sky ->
            "sky"

        Slate ->
            "slate"

        Teal ->
            "teal"

        Tomato ->
            "tomato"

        Violet ->
            "violet"

        Yellow ->
            "yellow"


type Radius
    = None
    | Small
    | Medium
    | Large
    | Full


radiusToString : Radius -> String
radiusToString radius =
    case radius of
        None ->
            "none"

        Small ->
            "small"

        Medium ->
            "medium"

        Large ->
            "large"

        Full ->
            "full"


type Size
    = Size1
    | Size2
    | Size3
    | Size4


sizeToCss : Size -> String
sizeToCss size =
    "rt-r-size-"
        ++ (case size of
                Size1 ->
                    "1"

                Size2 ->
                    "2"

                Size3 ->
                    "3"

                Size4 ->
                    "4"
           )


type Alignment
    = AlignStart
    | AlignCenter
    | AlignEnd
    | AlignBaseline
    | AlignStretch


alignmentToCss : Alignment -> String
alignmentToCss alignment =
    "rt-r-ai-"
        ++ (case alignment of
                AlignStart ->
                    "start"

                AlignCenter ->
                    "center"

                AlignEnd ->
                    "end"

                AlignBaseline ->
                    "baseline"

                AlignStretch ->
                    "stretch"
           )


type Justify
    = JustifyStart
    | JustifyCenter
    | JustifyEnd
    | JustifyBetween


justifyToCss : Justify -> String
justifyToCss justify =
    "rt-r-jc-"
        ++ (case justify of
                JustifyStart ->
                    "start"

                JustifyCenter ->
                    "center"

                JustifyEnd ->
                    "end"

                JustifyBetween ->
                    "space-between"
           )


view :
    { accentColor : Color
    , backgroundColor : Color
    , radius : Radius
    }
    -> List (Html msg)
    -> Html msg
view options content =
    Html.div
        [ Html.Attributes.class "radix-themes"
        , Html.Attributes.attribute "data-radius" <| radiusToString options.radius
        , Html.Attributes.attribute "data-accent-color" <| colorToString options.accentColor
        ]
        content
