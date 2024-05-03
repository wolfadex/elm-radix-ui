module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Radix
import Radix.Button
import Radix.Flex
import Radix.Heading
import Radix.Icon
import Radix.Spinner


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { theme : Radix.Color
    , darkEnabled : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { theme = Radix.Blue
      , darkEnabled = False
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type Msg
    = UserSelectedTheme Radix.Color
    | UserClickedDarkToggle
    | UserClickedButton


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserSelectedTheme newTheme ->
            ( { model | theme = newTheme }, Cmd.none )

        UserClickedDarkToggle ->
            ( { model | darkEnabled = not model.darkEnabled }, Cmd.none )

        UserClickedButton ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Hello World"
    , body =
        [ Radix.view
            { accentColor = model.theme
            , backgroundColor = model.theme
            , radius = Radix.Medium
            }
            [ Radix.Heading.h1 "Elm Radix"
                |> Radix.Heading.view
            , Radix.allColors
                |> List.map
                    (\theme ->
                        let
                            themeStr =
                                Radix.colorToString theme
                        in
                        Html.option
                            [ Html.Attributes.value themeStr
                            , Html.Events.onClick (UserSelectedTheme theme)
                            ]
                            [ Html.text themeStr ]
                    )
                |> Html.select
                    [ Html.Attributes.value (Radix.colorToString model.theme)
                    ]
            , Radix.Heading.h2 "Headings"
                |> Radix.Heading.view
            , [ Radix.Heading.h1 "A Heading H1"
                    |> Radix.Heading.view
              , Radix.Heading.h2 "A Heading H2"
                    |> Radix.Heading.view
              , Radix.Heading.h3 "A Heading H3"
                    |> Radix.Heading.view
              , Radix.Heading.h4 "A Heading H4"
                    |> Radix.Heading.view
              , Radix.Heading.h5 "A Heading H5"
                    |> Radix.Heading.view
              , Radix.Heading.h6 "A Heading H6"
                    |> Radix.Heading.view
              ]
                |> Radix.Flex.new
                |> Radix.Flex.withDirection Radix.Flex.Column
                |> Radix.Flex.view
            , Radix.Heading.h2 "Button"
                |> Radix.Heading.view
            , [ [ Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withSize Radix.Size1
                    |> Radix.Button.withVariantSurface
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withVariantSurface
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withSize Radix.Size3
                    |> Radix.Button.withVariantSurface
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withSize Radix.Size4
                    |> Radix.Button.withVariantSurface
                    |> Radix.Button.view
                ]
                    |> Radix.Flex.new
                    |> Radix.Flex.withGapScale 3
                    |> Radix.Flex.withAlignment Radix.AlignCenter
                    |> Radix.Flex.view
              , [ Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withVariantClassic
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withVariantSoft
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withVariantSurface
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withVariantOutline
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withVariantGhost
                    |> Radix.Button.view
                ]
                    |> Radix.Flex.new
                    |> Radix.Flex.withGapScale 3
                    |> Radix.Flex.withAlignment Radix.AlignCenter
                    |> Radix.Flex.view
              , [ Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withAccentColor Radix.Indigo
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withAccentColor Radix.Cyan
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withAccentColor Radix.Orange
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withAccentColor Radix.Crimson
                    |> Radix.Button.view
                ]
                    |> Radix.Flex.new
                    |> Radix.Flex.withGapScale 3
                    |> Radix.Flex.withAlignment Radix.AlignCenter
                    |> Radix.Flex.view
              , [ [ Radix.Button.new
                        { content = [ Html.text "Click me" ]
                        , onClick = UserClickedButton
                        }
                        |> Radix.Button.withAccentColor Radix.Gray
                        |> Radix.Button.withVariantClassic
                        |> Radix.Button.view
                  , Radix.Button.new
                        { content = [ Html.text "Click me" ]
                        , onClick = UserClickedButton
                        }
                        |> Radix.Button.withAccentColor Radix.Gray
                        |> Radix.Button.view
                  , Radix.Button.new
                        { content = [ Html.text "Click me" ]
                        , onClick = UserClickedButton
                        }
                        |> Radix.Button.withAccentColor Radix.Gray
                        |> Radix.Button.withVariantSoft
                        |> Radix.Button.view
                  , Radix.Button.new
                        { content = [ Html.text "Click me" ]
                        , onClick = UserClickedButton
                        }
                        |> Radix.Button.withAccentColor Radix.Gray
                        |> Radix.Button.withVariantSurface
                        |> Radix.Button.view
                  , Radix.Button.new
                        { content = [ Html.text "Click me" ]
                        , onClick = UserClickedButton
                        }
                        |> Radix.Button.withAccentColor Radix.Gray
                        |> Radix.Button.withVariantOutline
                        |> Radix.Button.view
                  ]
                    |> Radix.Flex.new
                    |> Radix.Flex.withGapScale 3
                    |> Radix.Flex.withAlignment Radix.AlignCenter
                    |> Radix.Flex.view
                , [ Radix.Button.new
                        { content = [ Html.text "Click me" ]
                        , onClick = UserClickedButton
                        }
                        |> Radix.Button.withAccentColor Radix.Gray
                        |> Radix.Button.withVariantClassic
                        |> Radix.Button.withHighContrast
                        |> Radix.Button.view
                  , Radix.Button.new
                        { content = [ Html.text "Click me" ]
                        , onClick = UserClickedButton
                        }
                        |> Radix.Button.withAccentColor Radix.Gray
                        |> Radix.Button.withHighContrast
                        |> Radix.Button.view
                  , Radix.Button.new
                        { content = [ Html.text "Click me" ]
                        , onClick = UserClickedButton
                        }
                        |> Radix.Button.withAccentColor Radix.Gray
                        |> Radix.Button.withVariantSoft
                        |> Radix.Button.withHighContrast
                        |> Radix.Button.view
                  , Radix.Button.new
                        { content = [ Html.text "Click me" ]
                        , onClick = UserClickedButton
                        }
                        |> Radix.Button.withAccentColor Radix.Gray
                        |> Radix.Button.withVariantSurface
                        |> Radix.Button.withHighContrast
                        |> Radix.Button.view
                  , Radix.Button.new
                        { content = [ Html.text "Click me" ]
                        , onClick = UserClickedButton
                        }
                        |> Radix.Button.withAccentColor Radix.Gray
                        |> Radix.Button.withVariantOutline
                        |> Radix.Button.withHighContrast
                        |> Radix.Button.view
                  ]
                    |> Radix.Flex.new
                    |> Radix.Flex.withGapScale 3
                    |> Radix.Flex.withAlignment Radix.AlignCenter
                    |> Radix.Flex.view
                ]
                    |> Radix.Flex.new
                    |> Radix.Flex.withGapScale 1
                    |> Radix.Flex.withDirection Radix.Flex.Column
                    |> Radix.Flex.view
              , [ Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withRadius Radix.None
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withRadius Radix.Small
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withRadius Radix.Medium
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withRadius Radix.Large
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withRadius Radix.Full
                    |> Radix.Button.view
                ]
                    |> Radix.Flex.new
                    |> Radix.Flex.withGapScale 3
                    |> Radix.Flex.withAlignment Radix.AlignCenter
                    |> Radix.Flex.view
              , [ Radix.Button.new
                    { content = [ Radix.Icon.bookmark 15, Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Radix.Icon.bookmark 15, Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Radix.Icon.bookmark 15, Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Radix.Icon.bookmark 15, Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Radix.Icon.bookmark 15, Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.view
                ]
                    |> Radix.Flex.new
                    |> Radix.Flex.withGapScale 3
                    |> Radix.Flex.withAlignment Radix.AlignCenter
                    |> Radix.Flex.view
              , [ Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withIsLoading
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withIsLoading
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withIsLoading
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withIsLoading
                    |> Radix.Button.view
                , Radix.Button.new
                    { content = [ Html.text "Click me" ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withIsLoading
                    |> Radix.Button.view
                ]
                    |> Radix.Flex.new
                    |> Radix.Flex.withGapScale 3
                    |> Radix.Flex.withAlignment Radix.AlignCenter
                    |> Radix.Flex.view
              , [ Radix.Button.new
                    { content =
                        [ Radix.Spinner.new
                            |> Radix.Spinner.withLoading
                            |> Radix.Spinner.withIcon (Radix.Icon.bookmark 15)
                            |> Radix.Spinner.view
                        , Html.text "Click me"
                        ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withIsDisabled
                    |> Radix.Button.view
                , Radix.Button.new
                    { content =
                        [ Radix.Spinner.new
                            |> Radix.Spinner.withLoading
                            |> Radix.Spinner.withIcon (Radix.Icon.bookmark 15)
                            |> Radix.Spinner.view
                        , Html.text "Click me"
                        ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withIsDisabled
                    |> Radix.Button.view
                , Radix.Button.new
                    { content =
                        [ Radix.Spinner.new
                            |> Radix.Spinner.withLoading
                            |> Radix.Spinner.withIcon (Radix.Icon.bookmark 15)
                            |> Radix.Spinner.view
                        , Html.text "Click me"
                        ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withIsDisabled
                    |> Radix.Button.view
                , Radix.Button.new
                    { content =
                        [ Radix.Spinner.new
                            |> Radix.Spinner.withLoading
                            |> Radix.Spinner.withIcon (Radix.Icon.bookmark 15)
                            |> Radix.Spinner.view
                        , Html.text "Click me"
                        ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withIsDisabled
                    |> Radix.Button.view
                , Radix.Button.new
                    { content =
                        [ Radix.Spinner.new
                            |> Radix.Spinner.withLoading
                            |> Radix.Spinner.withIcon (Radix.Icon.bookmark 15)
                            |> Radix.Spinner.view
                        , Html.text "Click me"
                        ]
                    , onClick = UserClickedButton
                    }
                    |> Radix.Button.withIsDisabled
                    |> Radix.Button.view
                ]
                    |> Radix.Flex.new
                    |> Radix.Flex.withGapScale 3
                    |> Radix.Flex.withAlignment Radix.AlignCenter
                    |> Radix.Flex.view
              ]
                |> Radix.Flex.new
                |> Radix.Flex.withGapScale 5
                |> Radix.Flex.withDirection Radix.Flex.Column
                |> Radix.Flex.view
            ]
        ]
    }
