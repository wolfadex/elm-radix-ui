module Radix.DataList.Item exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.DataList.Label
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { label : Radix.DataList.Label.Config msg
        , value : Html msg
        , alignment : Maybe Alignment
        }


type Alignment
    = Start
    | Center
    | End
    | Baseline
    | Stretch


alignmentToCss : Alignment -> String
alignmentToCss alignment =
    case alignment of
        Start ->
            "rt-r-ai-start"

        Center ->
            "rt-r-ai-center"

        End ->
            "rt-r-ai-end"

        Baseline ->
            "rt-r-ai-baseline"

        Stretch ->
            "rt-r-ai-stretch"


new : { label : Radix.DataList.Label.Config msg, value : Html msg } -> Config msg
new options =
    Config
        { label = options.label
        , value = options.value
        , alignment = Nothing
        }


withAlignStart : Config msg -> Config msg
withAlignStart (Config config) =
    Config { config | alignment = Just Start }


withAlignCenter : Config msg -> Config msg
withAlignCenter (Config config) =
    Config { config | alignment = Just Center }


withAlignEnd : Config msg -> Config msg
withAlignEnd (Config config) =
    Config { config | alignment = Just End }


withAlignBaseline : Config msg -> Config msg
withAlignBaseline (Config config) =
    Config { config | alignment = Just Baseline }


withAlignStretch : Config msg -> Config msg
withAlignStretch (Config config) =
    Config { config | alignment = Just Stretch }


view : Config msg -> Html msg
view (Config config) =
    Html.div
        [ Html.Attributes.classList
            [ ( "rt-DataListItem", True )
            , Radix.Internal.classListMaybe
                alignmentToCss
                config.alignment
            ]
        ]
        [ Radix.DataList.Label.view config.label
        , Html.dd
            [ Html.Attributes.class "rt-DataListValue" ]
            [ config.value ]
        ]
