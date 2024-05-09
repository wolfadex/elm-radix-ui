module Radix.Tooltip exposing (..)

import Html exposing (Html)
import Html.Attributes
import Json.Encode
import Radix
import Radix.Internal
import Radix.Text
import Svg
import Svg.Attributes


type Config msg
    = Config
        { content : String
        }


new : String -> Config msg
new content =
    Config
        { content = content
        }


view : Config msg -> Html msg -> Html msg
view (Config config) target =
    Html.div
        []
        [ target
        , Html.div
            [ Html.Attributes.property "___elm-radix-ui-tooltip" Json.Encode.null
            , Html.Attributes.attribute "popover" "manual"

            --
            , Html.Attributes.classList
                [ ( "rt-TooltipContent", True )
                , ( "rt-r-max-w", True )
                ]
            , Html.Attributes.attribute "data-side" "top"
            , Html.Attributes.attribute "data-align" "center"
            , Html.Attributes.attribute "data-state" "delayed-open"
            , Html.Attributes.attribute "style" """
--max-width: 360px;
--radix-popper-transform-origin: 
--radix-tooltip-content-transform-origin: var(--radix-popper-transform-origin);
--radix-tooltip-content-available-width: var(--radix-popper-available-width);
--radix-tooltip-content-available-height: var(--radix-popper-available-height);
--radix-tooltip-trigger-width: var(--radix-popper-anchor-width);
--radix-tooltip-trigger-height: var(--radix-popper-anchor-height);
"""
            ]
            [ Radix.Text.new
                [ Html.text config.content ]
                |> Radix.Text.asParagraph
                |> Radix.Text.withCustomClassList
                    [ ( "rt-TooltipText", True )
                    ]
                |> Radix.Text.view
            , Html.div
                [ Html.Attributes.class "rt-TooltipArrow"
                ]
                []
            ]
        ]
