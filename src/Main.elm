module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Radix
import Radix.Avatar
import Radix.Badge
import Radix.Blockquote
import Radix.Box
import Radix.Button
import Radix.Callout
import Radix.Card
import Radix.Checkbox
import Radix.Code
import Radix.DataList
import Radix.DataList.Item
import Radix.DataList.Label
import Radix.Emphasis
import Radix.Flex
import Radix.Grid
import Radix.Heading
import Radix.Icon
import Radix.IconButton
import Radix.Internal
import Radix.Layout
import Radix.Link
import Radix.Modal
import Radix.Separator
import Radix.Skeleton
import Radix.Spinner
import Radix.Text
import Radix.TextArea
import Radix.TextField
import Radix.Tooltip


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
    , modal1 : Bool
    , modal2 : Bool
    , textFieldValue : String
    , textAreaValue : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { theme = Radix.Blue
      , darkEnabled = False
      , modal1 = False
      , modal2 = False
      , textFieldValue = ""
      , textAreaValue = ""
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
    | UserClickedCheckbox Bool
    | UserClickedOpenModal1
    | UserClosedModal1
    | UserClickedOpenModal2
    | UserClosedModal2
    | TextFieldChanged String
    | TextAreaChanged String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserSelectedTheme newTheme ->
            ( { model | theme = newTheme }, Cmd.none )

        UserClickedDarkToggle ->
            ( { model | darkEnabled = not model.darkEnabled }, Cmd.none )

        UserClickedButton ->
            ( model, Cmd.none )

        UserClickedCheckbox _ ->
            ( model, Cmd.none )

        UserClickedOpenModal1 ->
            ( { model | modal1 = True }, Cmd.none )

        UserClosedModal1 ->
            ( { model | modal1 = False }, Cmd.none )

        UserClickedOpenModal2 ->
            ( { model | modal2 = True }, Cmd.none )

        UserClosedModal2 ->
            ( { model | modal2 = False }, Cmd.none )

        TextFieldChanged value ->
            ( { model | textFieldValue = value }, Cmd.none )

        TextAreaChanged value ->
            ( { model | textAreaValue = value }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Hello World"
    , body =
        [ Radix.view
            { accentColor = model.theme
            , radius = Radix.Medium
            }
            ([ [ Radix.Heading.new "Elm Radix"
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
               ]
             , viewSection "Headings" viewHeadings
             , viewSection "Text" viewText
             , viewSection "Blockquote"
                ([ Radix.Blockquote.new "What is dead may never die\n- Game of Thrones"
                    |> Radix.Blockquote.withWrap Radix.Text.Balance
                    |> Radix.Blockquote.view
                 ]
                    |> Radix.Box.new
                    |> Radix.Box.withWidth "15rem"
                    |> Radix.Box.view
                )
             , viewSection "Aspect Ratio" viewAspectRatios
             , viewSection "Avatar"
                ([ Radix.Avatar.new (Radix.Avatar.Initials "WS")
                    |> Radix.Avatar.withSrc "https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?&w=256&h=256&q=70&crop=focalpoint&fp-x=0.5&fp-y=0.3&fp-z=1&fit=crop"
                    |> Radix.Avatar.view
                 , Radix.Avatar.new (Radix.Avatar.Initials "WS")
                    |> Radix.Avatar.view
                 ]
                    |> Radix.Flex.new
                    |> Radix.Flex.withGapScale 3
                    |> Radix.Flex.view
                )
             , viewSection "Button" viewButtons
             , viewSection "IconButton" viewIconButtons
             , viewSection "Callout"
                (Radix.Callout.new
                    { content = [ Html.text "This is a callout" ]
                    , icon = Radix.Icon.infoCircled |> Radix.Icon.view
                    }
                    |> Radix.Callout.view
                )
             , viewSection "Card" viewCard
             , viewSection "Checkbox" viewCheckboxes
             , viewSection "DataList" viewDataList
             , viewSection "Modal" (viewModals model)
             , viewSection "Separator" viewSeparators
             , viewSection "Skeleton" viewSkeleton
             , viewSection "Tooltips" viewTooltips
             , viewSection "TextField" (viewTextFields model)
             , viewSection "TextArea" (viewTextAreas model)
             ]
                |> List.concat
                |> Radix.Flex.new
                |> Radix.Flex.withGapScale 5
                |> Radix.Flex.withDirection Radix.Flex.Column
                |> Radix.Flex.withPaddingBottomScale 5
                |> Radix.Flex.view
            )
        ]
    }


viewSection : String -> Html Msg -> List (Html Msg)
viewSection label content =
    [ Radix.Heading.new label
        |> Radix.Heading.asH2
        |> Radix.Heading.view
    , content
    ]


viewAspectRatios : Html msg
viewAspectRatios =
    Radix.Flex.new
        [ Radix.Text.new
            [ Html.text "Instead of providing an "
            , Radix.Code.new "AspectRatio"
                |> Radix.Code.view
            , Html.text " component, I've opted for using the native CSS property of"
            , Radix.Code.new "aspect-ratio"
                |> Radix.Code.view
            ]
            |> Radix.Text.view
        , Html.img
            [ Html.Attributes.src "https://images.unsplash.com/photo-1479030160180-b1860951d696?&auto=format&fit=crop&w=1200&q=80"
            , Html.Attributes.alt "A house in a forest"
            , Radix.styles
                [ ( "objectFit", "cover" )
                , ( "width", "100%" )
                , ( "height", "100%" )
                , ( "border-radius", "var(--radius-2)" )
                ]
            , Html.Attributes.style "aspect-ratio" "16 / 9"
            ]
            []
        , Html.img
            [ Html.Attributes.src "https://images.unsplash.com/photo-1535025183041-0991a977e25b?w=300&dpr=2&q=80"
            , Html.Attributes.alt "Landscape photograph by Tobias Tullius"
            , Html.Attributes.style "aspect-ratio" "4 / 3"
            ]
            []
        ]
        |> Radix.Flex.withMaxWidth "30rem"
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.view


viewTextAreas : Model -> Html Msg
viewTextAreas model =
    Radix.Flex.new
        [ Radix.TextArea.new
            { value = model.textAreaValue
            , onInput = TextAreaChanged
            }
            |> Radix.TextArea.withCustomAttributes [ Html.Attributes.placeholder "Search..." ]
            |> Radix.TextArea.view
        , Radix.TextArea.new
            { value = model.textAreaValue
            , onInput = TextAreaChanged
            }
            |> Radix.TextArea.withCustomAttributes [ Html.Attributes.placeholder "You should type something..." ]
            |> Radix.TextArea.withResizeHorizontal
            |> Radix.TextArea.view
        , Radix.TextArea.new
            { value = model.textAreaValue
            , onInput = TextAreaChanged
            }
            |> Radix.TextArea.withVariantClassic
            |> Radix.TextArea.withResizeVertical
            |> Radix.TextArea.view
        , Radix.TextArea.new
            { value = model.textAreaValue
            , onInput = TextAreaChanged
            }
            |> Radix.TextArea.withVariantSoft
            |> Radix.TextArea.view
        , Radix.TextArea.new
            { value = model.textAreaValue
            , onInput = TextAreaChanged
            }
            |> Radix.TextArea.withRadius Radix.Full
            |> Radix.TextArea.withResizeBoth
            |> Radix.TextArea.withCustomAttributes [ Html.Attributes.placeholder "Maybe some text...?" ]
            |> Radix.TextArea.view
        ]
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.withMaxWidth "20rem"
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.view


viewTextFields : Model -> Html Msg
viewTextFields model =
    Radix.Flex.new
        [ Radix.TextField.new
            { value = model.textFieldValue
            , onInput = TextFieldChanged
            }
            |> Radix.TextField.withSlot (Radix.Icon.magnifyingGlass |> Radix.Icon.view)
            |> Radix.TextField.withCustomAttributes [ Html.Attributes.placeholder "Search..." ]
            |> Radix.TextField.view
        , Radix.TextField.new
            { value = model.textFieldValue
            , onInput = TextFieldChanged
            }
            |> Radix.TextField.withCustomAttributes [ Html.Attributes.placeholder "You should type something..." ]
            |> Radix.TextField.view
        , Radix.TextField.new
            { value = model.textFieldValue
            , onInput = TextFieldChanged
            }
            |> Radix.TextField.withVariantClassic
            |> Radix.TextField.view
        , Radix.TextField.new
            { value = model.textFieldValue
            , onInput = TextFieldChanged
            }
            |> Radix.TextField.withVariantSoft
            |> Radix.TextField.view
        , Radix.TextField.new
            { value = model.textFieldValue
            , onInput = TextFieldChanged
            }
            |> Radix.TextField.withRadius Radix.Full
            |> Radix.TextField.withCustomAttributes [ Html.Attributes.placeholder "Maybe some text...?" ]
            |> Radix.TextField.view
        ]
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.withMaxWidth "20rem"
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.view


viewTooltips : Html Msg
viewTooltips =
    Radix.Flex.new
        [ Radix.Avatar.new (Radix.Avatar.Initials "WS")
            |> Radix.Avatar.withSrc "https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?&w=256&h=256&q=70&crop=focalpoint&fp-x=0.5&fp-y=0.3&fp-z=1&fit=crop"
            |> Radix.Avatar.view
            |> (Radix.Tooltip.new "Hello, Tooltip!"
                    |> Radix.Tooltip.view
               )
        , Radix.Avatar.new (Radix.Avatar.Initials "WS")
            |> Radix.Avatar.withSrc "https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?&w=256&h=256&q=70&crop=focalpoint&fp-x=0.5&fp-y=0.3&fp-z=1&fit=crop"
            |> Radix.Avatar.view
            |> (Radix.Tooltip.new "Wolfgang Schuster"
                    |> Radix.Tooltip.view
               )
        , Radix.Avatar.new (Radix.Avatar.Initials "WS")
            |> Radix.Avatar.withSrc "https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?&w=256&h=256&q=70&crop=focalpoint&fp-x=0.5&fp-y=0.3&fp-z=1&fit=crop"
            |> Radix.Avatar.view
            |> (Radix.Tooltip.new "Get your info here!!!🎉\nGet all your info. All at once and lots more info so that this takes up a lot of space. But how much space is enough?"
                    |> Radix.Tooltip.view
               )
        ]
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.view


viewModals : Model -> Html Msg
viewModals model =
    Radix.Flex.new
        [ Radix.Button.new
            { content = [ Html.text "Open Modal 1" ]
            , onClick = UserClickedOpenModal1
            }
            |> Radix.Button.view
        , Radix.Modal.new
            { open = model.modal1
            , onClose = UserClosedModal1
            , content =
                Radix.Box.new
                    [ Radix.Text.new [ Html.text "Hello, World!" ]
                        |> Radix.Text.view
                    ]
                    |> Radix.Box.withPaddingScale 3
                    |> Radix.Box.view
            }
            |> Radix.Modal.view
        , Radix.Button.new
            { content = [ Html.text "Open Modal 2" ]
            , onClick = UserClickedOpenModal2
            }
            |> Radix.Button.view
        , Radix.Modal.new
            { open = model.modal2
            , onClose = UserClosedModal2
            , content =
                Radix.Flex.new
                    [ Radix.Heading.new "Modal 2"
                        |> Radix.Heading.withSize 5
                        |> Radix.Heading.view
                    , Radix.Text.new
                        [ Html.text "Hello, World! "
                        , Radix.Link.new
                            { href = "https://www.radix-ui.com/"
                            , content = [ Html.text "Hello, Radix UI!" ]
                            }
                            |> Radix.Link.view
                        , Radix.Emphasis.new " Ya know what else is cool? "
                            |> Radix.Emphasis.view
                        , Radix.Link.new
                            { href = "https://elm-lang.org/"
                            , content = [ Html.text "Hello, Elm!" ]
                            }
                            |> Radix.Link.view
                        ]
                        |> Radix.Text.asParagraph
                        |> Radix.Text.view
                    , Radix.Flex.new
                        [ Radix.Button.new
                            { content = [ Html.text "Cancel" ]
                            , onClick = UserClosedModal2
                            }
                            |> Radix.Button.withVariantOutline
                            |> Radix.Button.view
                        , Radix.Button.new
                            { content = [ Html.text "Submit" ]
                            , onClick = UserClosedModal2
                            }
                            |> Radix.Button.view
                        ]
                        |> Radix.Flex.withGapScale 2
                        |> Radix.Flex.withJustification Radix.JustifyEnd
                        |> Radix.Flex.view
                    ]
                    |> Radix.Flex.withGapScale 3
                    |> Radix.Flex.withDirection Radix.Flex.Column
                    |> Radix.Flex.view
            }
            |> Radix.Modal.view
        ]
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.view


viewSkeleton : Html Msg
viewSkeleton =
    Radix.Flex.new
        [ Radix.Skeleton.new
            |> Radix.Skeleton.withWidth "10rem"
            |> Radix.Skeleton.view
        , Radix.Skeleton.new
            |> Radix.Skeleton.withWidth "4rem"
            |> Radix.Skeleton.withHeight "4rem"
            |> Radix.Skeleton.view
        , Radix.Flex.new
            [ Radix.Text.new
                [ Html.text "Hello, World! May I ask who i calling?"
                ]
                |> Radix.Text.view
            , Radix.Text.new
                [ Radix.Skeleton.new
                    |> Radix.Skeleton.withChild
                        (Html.text "Hello, World! May I ask who i calling?")
                    |> Radix.Skeleton.view
                ]
                |> Radix.Text.view
            ]
            |> Radix.Flex.withDirection Radix.Flex.Column
            |> Radix.Flex.view
        ]
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.view


viewSeparators : Html Msg
viewSeparators =
    Radix.Flex.new
        [ Radix.Text.new [ Html.text "Separators" ]
            |> Radix.Text.withSize 2
            |> Radix.Text.view
        , Radix.Separator.new
            |> Radix.Separator.withSize4
            |> Radix.Separator.view
        , Radix.Flex.new
            [ Radix.Text.new [ Html.text "One" ]
                |> Radix.Text.withSize 2
                |> Radix.Text.view
            , Radix.Separator.new
                |> Radix.Separator.withOrientationVertical
                |> Radix.Separator.view
            , Radix.Text.new [ Html.text "Two" ]
                |> Radix.Text.withSize 2
                |> Radix.Text.view
            , Radix.Separator.new
                |> Radix.Separator.withOrientationVertical
                |> Radix.Separator.view
            , Radix.Text.new [ Html.text "Three" ]
                |> Radix.Text.withSize 2
                |> Radix.Text.view
            ]
            |> Radix.Flex.withGapScale 3
            |> Radix.Flex.view
        ]
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.withMaxWidth "20rem"
        |> Radix.Flex.view


viewIconButtons : Html Msg
viewIconButtons =
    Radix.Flex.new
        [ Radix.Flex.new
            [ Radix.IconButton.new
                { icon =
                    Radix.Icon.magnifyingGlass
                        |> Radix.Icon.withSize 18
                , onClick = UserClickedButton
                }
                |> Radix.IconButton.withVariantClassic
                |> Radix.IconButton.view
            , Radix.IconButton.new
                { icon =
                    Radix.Icon.magnifyingGlass
                        |> Radix.Icon.withSize 18
                , onClick = UserClickedButton
                }
                |> Radix.IconButton.view
            , Radix.IconButton.new
                { icon =
                    Radix.Icon.magnifyingGlass
                        |> Radix.Icon.withSize 18
                , onClick = UserClickedButton
                }
                |> Radix.IconButton.withVariantSoft
                |> Radix.IconButton.view
            , Radix.IconButton.new
                { icon =
                    Radix.Icon.magnifyingGlass
                        |> Radix.Icon.withSize 18
                , onClick = UserClickedButton
                }
                |> Radix.IconButton.withVariantSurface
                |> Radix.IconButton.view
            , Radix.IconButton.new
                { icon =
                    Radix.Icon.magnifyingGlass
                        |> Radix.Icon.withSize 18
                , onClick = UserClickedButton
                }
                |> Radix.IconButton.withVariantOutline
                |> Radix.IconButton.view
            ]
            |> Radix.Flex.withGapScale 3
            |> Radix.Flex.view
        , Radix.Flex.new
            [ Radix.IconButton.new
                { icon =
                    Radix.Icon.magnifyingGlass
                        |> Radix.Icon.withSize 18
                , onClick = UserClickedButton
                }
                |> Radix.IconButton.withColor Radix.Indigo
                |> Radix.IconButton.view
            , Radix.IconButton.new
                { icon =
                    Radix.Icon.magnifyingGlass
                        |> Radix.Icon.withSize 18
                , onClick = UserClickedButton
                }
                |> Radix.IconButton.withLoading
                |> Radix.IconButton.view
            , Radix.IconButton.new
                { icon =
                    Radix.Icon.magnifyingGlass
                        |> Radix.Icon.withSize 18
                , onClick = UserClickedButton
                }
                |> Radix.IconButton.withDisabled
                |> Radix.IconButton.view
            , Radix.IconButton.new
                { icon =
                    Radix.Icon.magnifyingGlass
                        |> Radix.Icon.withSize 18
                , onClick = UserClickedButton
                }
                |> Radix.IconButton.withColor Radix.Orange
                |> Radix.IconButton.view
            ]
            |> Radix.Flex.withGapScale 3
            |> Radix.Flex.view
        ]
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.view


viewDataList : Html Msg
viewDataList =
    Radix.Flex.new
        [ Radix.DataList.new
            [ Radix.DataList.Item.new
                { label =
                    Radix.DataList.Label.new "Status"
                        |> Radix.DataList.Label.withMinWidth "88px"
                , value =
                    Radix.Badge.new "Authorized"
                        |> Radix.Badge.withColor Radix.Jade
                        |> Radix.Badge.withRadius Radix.Full
                        |> Radix.Badge.view
                }
            , Radix.DataList.Item.new
                { label =
                    Radix.DataList.Label.new "ID"
                        |> Radix.DataList.Label.withMinWidth "88px"
                , value =
                    Radix.Flex.new
                        [ Radix.Code.new "u_2J89JSA4GJ"
                            |> Radix.Code.withVariantGhost
                            |> Radix.Code.view
                        , Radix.IconButton.new
                            { icon = Radix.Icon.copy
                            , onClick = UserClickedButton
                            }
                            |> Radix.IconButton.withSize1
                            |> Radix.IconButton.withVariantGhost
                            |> Radix.IconButton.view
                        ]
                        |> Radix.Flex.withAlignment Radix.AlignCenter
                        |> Radix.Flex.withGapScale 2
                        |> Radix.Flex.view
                }
            , Radix.DataList.Item.new
                { label =
                    Radix.DataList.Label.new "Name"
                        |> Radix.DataList.Label.withMinWidth "88px"
                , value =
                    Radix.Text.new [ Html.text "Vlad Moroz" ]
                        |> Radix.Text.view
                }
            , Radix.DataList.Item.new
                { label =
                    Radix.DataList.Label.new "Email"
                        |> Radix.DataList.Label.withMinWidth "88px"
                , value =
                    Radix.Link.new { href = "mailto:vlad@workos.com", content = [ Html.text "vlad@workos.com" ] }
                        |> Radix.Link.view
                }
            , Radix.DataList.Item.new
                { label =
                    Radix.DataList.Label.new "Company"
                        |> Radix.DataList.Label.withMinWidth "88px"
                , value =
                    Radix.Link.new { href = "https://workos.com", content = [ Html.text "WorkOS" ] }
                        |> Radix.Link.withOpenInNewTab
                        |> Radix.Link.view
                }
            ]
            |> Radix.DataList.view
        ]
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.view


viewCheckboxes : Html Msg
viewCheckboxes =
    Radix.Flex.new
        [ Radix.Flex.new
            [ Radix.Checkbox.new
                { checked = True
                , onChange = UserClickedCheckbox
                }
                |> Radix.Checkbox.view
            , Radix.Checkbox.new
                { checked = False
                , onChange = UserClickedCheckbox
                }
                |> Radix.Checkbox.view
            , Radix.Checkbox.new
                { checked = True
                , onChange = UserClickedCheckbox
                }
                |> Radix.Checkbox.withVariantSoft
                |> Radix.Checkbox.view
            , Radix.Checkbox.new
                { checked = False
                , onChange = UserClickedCheckbox
                }
                |> Radix.Checkbox.withVariantSoft
                |> Radix.Checkbox.view
            ]
            |> Radix.Flex.withGapScale 3
            |> Radix.Flex.view
        , Radix.Box.new
            [ Radix.Checkbox.new
                { checked = True
                , onChange = UserClickedCheckbox
                }
                |> Radix.Checkbox.withContent
                    [ Radix.Text.new [ Html.text "Check me, or don't. It's your choice! Or is it? Hmmm...." ]
                        |> Radix.Text.view
                    ]
                |> Radix.Checkbox.view
            ]
            |> Radix.Box.withWidth "10rem"
            |> Radix.Box.view
        ]
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.view


viewCard : Html Msg
viewCard =
    Radix.Box.new
        [ Radix.Card.new
            [ Radix.Flex.new
                [ Radix.Avatar.new (Radix.Avatar.Initials "T")
                    |> Radix.Avatar.withSize 3
                    |> Radix.Avatar.withSrc "https://images.unsplash.com/photo-1607346256330-dee7af15f7c5?&w=64&h=64&dpr=2&q=70&crop=focalpoint&fp-x=0.67&fp-y=0.5&fp-z=1.4&fit=crop"
                    |> Radix.Avatar.withRadius Radix.Full
                    |> Radix.Avatar.view
                , Radix.Box.new
                    [ Radix.Text.new [ Html.text "Teodros Girmay" ]
                        |> Radix.Text.asDiv
                        |> Radix.Text.withSize 2
                        |> Radix.Text.withWeight Radix.Text.Bold
                        |> Radix.Text.view
                    , Radix.Text.new [ Html.text "Engineering" ]
                        |> Radix.Text.asDiv
                        |> Radix.Text.withSize 2
                        |> Radix.Text.withColor Radix.Gray
                        |> Radix.Text.view
                    ]
                    |> Radix.Box.view
                ]
                |> Radix.Flex.withGapScale 3
                |> Radix.Flex.withAlignment Radix.AlignCenter
                |> Radix.Flex.view
            ]
            |> Radix.Card.view
        ]
        |> Radix.Box.withWidth "240px"
        |> Radix.Box.view


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
            { content = [ Radix.Icon.bookmark |> Radix.Icon.view, Html.text "Click me" ]
            , onClick = UserClickedButton
            }
            |> Radix.Button.view
      , Radix.Button.new
            { content = [ Radix.Icon.bookmark |> Radix.Icon.view, Html.text "Click me" ]
            , onClick = UserClickedButton
            }
            |> Radix.Button.view
      , Radix.Button.new
            { content = [ Radix.Icon.bookmark |> Radix.Icon.view, Html.text "Click me" ]
            , onClick = UserClickedButton
            }
            |> Radix.Button.view
      , Radix.Button.new
            { content = [ Radix.Icon.bookmark |> Radix.Icon.view, Html.text "Click me" ]
            , onClick = UserClickedButton
            }
            |> Radix.Button.view
      , Radix.Button.new
            { content = [ Radix.Icon.bookmark |> Radix.Icon.view, Html.text "Click me" ]
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
                    |> Radix.Spinner.withIcon (Radix.Icon.bookmark |> Radix.Icon.view)
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
                    |> Radix.Spinner.withIcon (Radix.Icon.bookmark |> Radix.Icon.view)
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
                    |> Radix.Spinner.withIcon (Radix.Icon.bookmark |> Radix.Icon.view)
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
                    |> Radix.Spinner.withIcon (Radix.Icon.bookmark |> Radix.Icon.view)
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
                    |> Radix.Spinner.withIcon (Radix.Icon.bookmark |> Radix.Icon.view)
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
