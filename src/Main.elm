module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes
import Html.Events


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { theme : String
    , darkEnabled : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { theme = "Blue"
      , darkEnabled = False
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type Msg
    = UserSelectedTheme String
    | UserClickedDarkToggle


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserSelectedTheme newTheme ->
            ( { model | theme = newTheme }, Cmd.none )

        UserClickedDarkToggle ->
            ( { model | darkEnabled = not model.darkEnabled }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Hello World"
    , body =
        [ Html.h1 []
            [ Html.text "Hello World"
            ]
        , Html.node "style"
            []
            [ let
                themeColor =
                    String.toLower model.theme

                themeWithDark =
                    if model.darkEnabled then
                        themeColor ++ "-dark"

                    else
                        themeColor
              in
              Html.text
                (":root {"
                    ++ (("--background: var(--" ++ themeWithDark ++ "-1);")
                            ++ ("--background-subtle: var(--" ++ themeWithDark ++ "-2);")
                            ++ ("--element-background: var(--" ++ themeWithDark ++ "-3);")
                            ++ ("--element-background-hover: var(--" ++ themeWithDark ++ "-4);")
                            ++ ("--element-background-selected: var(--" ++ themeWithDark ++ "-5);")
                            ++ ("--element-border-static: var(--" ++ themeWithDark ++ "-6);")
                            ++ ("--element-border-interactive: var(--" ++ themeWithDark ++ "-7);")
                            ++ ("--element-border-selected: var(--" ++ themeWithDark ++ "-8);")
                            ++ ("--background-solid: var(--" ++ themeWithDark ++ "-9);")
                            ++ ("--background-solid-hover: var(--" ++ themeWithDark ++ "-10);")
                            ++ ("--text-contrast-low: var(--" ++ themeWithDark ++ "-11);")
                            ++ ("--text-contrast-high: var(--" ++ themeWithDark ++ "-12);")
                       )
                    ++ "\n}"
                )
            ]
        , themes
            |> List.map
                (\theme ->
                    Html.option
                        [ Html.Attributes.value theme
                        ]
                        [ Html.text theme ]
                )
            |> Html.select
                [ Html.Events.onInput UserSelectedTheme
                , Html.Attributes.value model.theme
                ]
        , Html.br [] []
        , Html.br [] []
        , Html.button
            []
            [ Html.text "Click me"
            ]
        ]
    }


themes : List String
themes =
    [ "Gray"
    , "Mauve"
    , "Slate"
    , "Sage"
    , "Olive"
    , "Sand"
    , "Tomato"
    , "Red"
    , "Ruby"
    , "Crimson"
    , "Pink"
    , "Plum"
    , "Purple"
    , "Violet"
    , "Iris"
    , "Indigo"
    , "Blue"
    , "Cyan"
    , "Teal"
    , "Jade"
    , "Green"
    , "Grass"
    , "Bronze"
    , "Gold"
    , "Brown"
    , "Orange"
    , "Amber"
    , "Yellow"
    , "Lime"
    , "Mint"
    , "Sky"
    ]
