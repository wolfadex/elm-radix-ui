module Radix.Spinner exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Flex


type Config msg
    = Config
        { size : Radix.Size
        , isSpinning : Bool
        , icon : Maybe (Html msg)
        }


new : Config msg
new =
    Config
        { size = Radix.Size2
        , isSpinning = False
        , icon = Nothing
        }


withSize : Radix.Size -> Config msg -> Config msg
withSize size (Config config) =
    Config { config | size = size }


withLoading : Config msg -> Config msg
withLoading (Config config) =
    Config { config | isSpinning = True }


withIcon : Html msg -> Config msg -> Config msg
withIcon icon (Config config) =
    Config { config | icon = Just icon }


view : Config msg -> Html msg
view (Config config) =
    Html.span
        [ Html.Attributes.classList
            [ ( Radix.sizeToCss config.size, True )
            , ( "rt-r-ai-center", config.icon /= Nothing )
            , ( "rt-r-jc-center", config.icon /= Nothing )
            , ( "rt-r-position-absolute", config.icon == Nothing )
            , ( "rt-r-position-relative", config.icon /= Nothing )
            , ( "rt-r-inset-0", config.icon /= Nothing )
            ]
        ]
        [ case config.icon of
            Nothing ->
                Html.text ""

            Just icon ->
                Html.span
                    [ Html.Attributes.style "display" "contents"
                    , Html.Attributes.style "visibility" "hidden"
                    , Html.Attributes.attribute "inert" ""
                    , Html.Attributes.attribute "aria-hidden" "true"
                    ]
                    [ icon ]
        , Html.span
            [ Html.Attributes.classList
                [ ( "rt-Spinner", True )
                , ( Radix.sizeToCss config.size, True )
                , ( "rt-r-ai-center", config.icon /= Nothing )
                , ( "rt-r-jc-center", config.icon /= Nothing )
                , ( "rt-r-position-absolute", config.icon /= Nothing )
                , ( "rt-r-inset-0", config.icon /= Nothing )
                ]
            ]
            [ Html.span [ Html.Attributes.class "rt-SpinnerLeaf" ] []
            , Html.span [ Html.Attributes.class "rt-SpinnerLeaf" ] []
            , Html.span [ Html.Attributes.class "rt-SpinnerLeaf" ] []
            , Html.span [ Html.Attributes.class "rt-SpinnerLeaf" ] []
            , Html.span [ Html.Attributes.class "rt-SpinnerLeaf" ] []
            , Html.span [ Html.Attributes.class "rt-SpinnerLeaf" ] []
            , Html.span [ Html.Attributes.class "rt-SpinnerLeaf" ] []
            , Html.span [ Html.Attributes.class "rt-SpinnerLeaf" ] []
            ]
        ]
