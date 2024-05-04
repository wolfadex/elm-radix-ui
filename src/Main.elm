module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Radix
import Radix.Avatar
import Radix.Blockquote
import Radix.Box
import Radix.Button
import Radix.Flex
import Radix.Grid
import Radix.Heading
import Radix.Icon
import Radix.Layout
import Radix.Spinner
import Radix.Text


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
            , radius = Radix.Medium
            }
            ([ Radix.Heading.new "Elm Radix"
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
             , Radix.Heading.new "Headings"
                |> Radix.Heading.asH2
                |> Radix.Heading.view
             , viewHeadings
             , Radix.Heading.new "Text"
                |> Radix.Heading.asH2
                |> Radix.Heading.view
             , viewText
             , [ Radix.Blockquote.new "What is dead may never die\n- Game of Thrones"
                    |> Radix.Blockquote.withWrap Radix.Text.Balance
                    |> Radix.Blockquote.view
               ]
                |> Radix.Box.new
                |> Radix.Box.withWidth "15rem"
                |> Radix.Box.view
             , Radix.Heading.new "Button"
                |> Radix.Heading.asH2
                |> Radix.Heading.view
             , viewButtons
             , Radix.Heading.new "Avatar"
                |> Radix.Heading.asH2
                |> Radix.Heading.view
             , [ Radix.Avatar.new (Radix.Avatar.Initials "WS")
                    |> Radix.Avatar.withSrc "https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?&w=256&h=256&q=70&crop=focalpoint&fp-x=0.5&fp-y=0.3&fp-z=1&fit=crop"
                    |> Radix.Avatar.view
               , Radix.Avatar.new (Radix.Avatar.Initials "WS")
                    |> Radix.Avatar.view
               ]
                |> Radix.Flex.new
                |> Radix.Flex.withGapScale 3
                |> Radix.Flex.view
             ]
                |> Radix.Flex.new
                |> Radix.Flex.withGapScale 5
                |> Radix.Flex.withDirection Radix.Flex.Column
                |> Radix.Flex.withPaddingBottomScale 5
                |> Radix.Flex.view
            )
        ]
    }


viewText : Html Msg
viewText =
    [ Radix.Text.new [ Html.text "A label" ]
        |> Radix.Text.withWeight Radix.Text.Bold
        |> Radix.Text.view
    , Radix.Text.new [ Html.text "Another label" ]
        |> Radix.Text.withWeight Radix.Text.Bold
        |> Radix.Text.view
    , Radix.Text.new [ Html.text "Some content" ]
        |> Radix.Text.view
    , Radix.Text.new [ Html.text "Even more content" ]
        |> Radix.Text.view
    ]
        |> Radix.Grid.new
        |> Radix.Grid.withGapScale 3
        |> Radix.Grid.withColumnsScale 2
        |> Radix.Grid.withWidth "30rem"
        |> Radix.Grid.view


viewHeadings : Html Msg
viewHeadings =
    [ [ Radix.Heading.new "Size 9"
            |> Radix.Heading.withSize 9
            |> Radix.Heading.view
      , Radix.Heading.new "Size 7"
            |> Radix.Heading.withSize 7
            |> Radix.Heading.view
      , Radix.Heading.new "Size 5"
            |> Radix.Heading.withSize 5
            |> Radix.Heading.view
      , Radix.Heading.new "Size 3"
            |> Radix.Heading.withSize 3
            |> Radix.Heading.view
      , Radix.Heading.new "Size 1"
            |> Radix.Heading.withSize 1
            |> Radix.Heading.view
      ]
        |> Radix.Flex.new
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.withGapScale 1
        |> Radix.Flex.view
    , [ Radix.Heading.new "Light"
            |> Radix.Heading.withWeight Radix.Text.Light
            |> Radix.Heading.view
      , Radix.Heading.new "Regular"
            |> Radix.Heading.withWeight Radix.Text.Regular
            |> Radix.Heading.view
      , Radix.Heading.new "Bold"
            |> Radix.Heading.withWeight Radix.Text.Bold
            |> Radix.Heading.view
      ]
        |> Radix.Flex.new
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.withGapScale 1
        |> Radix.Flex.view
    , [ Radix.Heading.new "Left"
            |> Radix.Heading.withAlignment Radix.Text.Left
            |> Radix.Heading.view
      , Radix.Heading.new "Center"
            |> Radix.Heading.withAlignment Radix.Text.Center
            |> Radix.Heading.view
      , Radix.Heading.new "Right"
            |> Radix.Heading.withAlignment Radix.Text.Right
            |> Radix.Heading.view
      ]
        |> Radix.Flex.new
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.withGapScale 1
        |> Radix.Flex.withWidth "20rem"
        |> Radix.Flex.view
    , [ Radix.Heading.new "Indigo"
            |> Radix.Heading.withColor Radix.Indigo
            |> Radix.Heading.view
      , Radix.Heading.new "Cyan"
            |> Radix.Heading.withColor Radix.Cyan
            |> Radix.Heading.view
      , Radix.Heading.new "Orange"
            |> Radix.Heading.withColor Radix.Orange
            |> Radix.Heading.view
      , Radix.Heading.new "Crimson"
            |> Radix.Heading.withColor Radix.Crimson
            |> Radix.Heading.view
      ]
        |> Radix.Flex.new
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.withGapScale 1
        |> Radix.Flex.view
    , [ Radix.Heading.new "Regular"
            |> Radix.Heading.withColor Radix.Gray
            |> Radix.Heading.view
      , Radix.Heading.new "High Contrast"
            |> Radix.Heading.withColor Radix.Gray
            |> Radix.Heading.withHighContrast
            |> Radix.Heading.view
      ]
        |> Radix.Flex.new
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.withGapScale 1
        |> Radix.Flex.view
    ]
        |> Radix.Flex.new
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.view


viewButtons : Html Msg
viewButtons =
    [ [ Radix.Button.new
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
