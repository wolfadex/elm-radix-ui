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
import Radix.Container
import Radix.DataList
import Radix.DataList.Item
import Radix.DataList.Label
import Radix.Emphasis
import Radix.Flex
import Radix.Grid
import Radix.Heading
import Radix.Icon
import Radix.IconButton
import Radix.Inset
import Radix.Layout
import Radix.Link
import Radix.Modal
import Radix.Progress
import Radix.Separator
import Radix.Skeleton
import Radix.Slider
import Radix.Slider.Thumb
import Radix.Spinner
import Radix.Strong
import Radix.Switch
import Radix.Table
import Radix.Tabs
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
    , slider1 : Float
    , slider2Thumb1 : Float
    , slider2Thumb2 : Float
    , slider2Thumb3 : Float
    , switch : Bool
    , activeTab : Tab
    , activeSection : Section
    }


type Section
    = Headings
    | Text
    | Blockquote
    | AspectRatio
    | Avatar
    | Button
    | IconButton
    | Callout
    | Card
    | Checkbox
    | DataList
    | Inset
    | Modal
    | Progress
    | Table
    | Tab
    | Separator
    | Skeleton
    | Slider
    | Switch
    | Tooltips
    | TextField
    | TextArea


init : () -> ( Model, Cmd Msg )
init _ =
    ( { theme = Radix.Blue
      , darkEnabled = False
      , modal1 = False
      , modal2 = False
      , textFieldValue = ""
      , textAreaValue = ""
      , slider1 = 0
      , slider2Thumb1 = 25
      , slider2Thumb2 = 65
      , slider2Thumb3 = 80
      , switch = True
      , activeTab = Games
      , activeSection = Headings
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type Msg
    = UserSelectedTheme Radix.Color
    | UserSelectedSection Section
    | UserClickedDarkToggle
    | UserClickedButton
    | UserClickedCheckbox Bool
    | UserClickedOpenModal1
    | UserClosedModal1
    | UserClickedOpenModal2
    | UserClosedModal2
    | TextFieldChanged String
    | TextAreaChanged String
    | UserChangedSlider1 Float
    | UserChangedSlider2Thumb1 Float
    | UserChangedSlider2Thumb2 Float
    | UserChangedSlider2Thumb3 Float
    | UserToggledSwitch Bool
    | UserSelectedTab Tab


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserSelectedTheme newTheme ->
            ( { model | theme = newTheme }, Cmd.none )

        UserSelectedSection section ->
            ( { model | activeSection = section }, Cmd.none )

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

        UserChangedSlider1 value ->
            ( { model | slider1 = value }, Cmd.none )

        UserChangedSlider2Thumb1 value ->
            ( { model | slider2Thumb1 = value }, Cmd.none )

        UserChangedSlider2Thumb2 value ->
            ( { model | slider2Thumb2 = value }, Cmd.none )

        UserChangedSlider2Thumb3 value ->
            ( { model | slider2Thumb3 = value }, Cmd.none )

        UserToggledSwitch checked ->
            ( { model | switch = checked }, Cmd.none )

        UserSelectedTab tab ->
            ( { model | activeTab = tab }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Hello World"
    , body =
        [ Radix.view
            { accentColor = model.theme
            , radius = Radix.Medium
            }
            ([ [ Radix.Heading.new "Elm Radix UI"
                    |> Radix.Heading.view
               , Radix.Flex.new
                    [ Radix.Text.new
                        [ Radix.Strong.new "Theme"
                            |> Radix.Strong.view
                        ]
                        |> Radix.Text.view
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
                    |> Radix.Flex.withGapScale 1
                    |> Radix.Flex.view
               ]
             , [ Radix.Tabs.new
                    { activeTab = model.activeSection
                    , onTabChange = UserSelectedSection
                    , tabs =
                        [ viewSectionTab Headings
                            "Heading"
                            viewHeadings
                        , viewSectionTab Text
                            "Text"
                            viewText
                        , viewSectionTab Blockquote
                            "Blockquote"
                            ([ Radix.Blockquote.new "What is dead may never die\n- Game of Thrones"
                                |> Radix.Blockquote.withWrap Radix.Text.Balance
                                |> Radix.Blockquote.view
                             ]
                                |> Radix.Box.new
                                |> Radix.Box.withWidth "15rem"
                                |> Radix.Box.view
                            )
                        , viewSectionTab AspectRatio
                            "Aspect Ratio"
                            viewAspectRatios
                        , viewSectionTab Avatar
                            "Avatar"
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
                        , viewSectionTab Button
                            "Button"
                            viewButtons
                        , viewSectionTab IconButton
                            "IconButton"
                            viewIconButtons
                        , viewSectionTab Callout
                            "Callout"
                            (Radix.Callout.new
                                { content = [ Html.text "This is a callout" ]
                                , icon = Radix.Icon.infoCircled |> Radix.Icon.view
                                }
                                |> Radix.Callout.view
                            )
                        , viewSectionTab Card
                            "Card"
                            viewCard
                        , viewSectionTab Checkbox "Checkbox" viewCheckboxes
                        , viewSectionTab DataList "DataList" viewDataList
                        , viewSectionTab Inset "Inset" viewInset
                        , viewSectionTab Modal "Modal" (viewModals model)
                        , viewSectionTab Progress "Progress" viewProgresses
                        , viewSectionTab Table "Table" viewTables
                        , viewSectionTab Tab "Tab" (viewTabs model)
                        , viewSectionTab Separator "Separator" viewSeparators
                        , viewSectionTab Skeleton "Skeleton" viewSkeleton
                        , viewSectionTab Slider "Slider" (viewSliders model)
                        , viewSectionTab Switch "Switch" (viewSwitches model)
                        , viewSectionTab Tooltips "Tooltips" viewTooltips
                        , viewSectionTab TextField "TextField" (viewTextFields model)
                        , viewSectionTab TextArea "TextArea" (viewTextAreas model)
                        ]
                    }
                    |> Radix.Tabs.wrapContentWith
                        (\content ->
                            Radix.Box.new [ content ]
                                |> Radix.Box.withPaddingScale 1
                                |> Radix.Box.view
                        )
                    |> Radix.Tabs.view
               ]
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


viewSectionTab : Section -> String -> Html msg -> { value : Section, trigger : Html msg, content : Html msg }
viewSectionTab section label content =
    { value = section
    , trigger =
        Radix.Heading.new label
            |> Radix.Heading.asH2
            |> Radix.Heading.view
    , content = content
    }


type Tab
    = Games
    | Music
    | Movies


viewTabs : Model -> Html Msg
viewTabs model =
    Radix.Flex.new
        [ Radix.Tabs.new
            { activeTab = model.activeTab
            , onTabChange = UserSelectedTab
            , tabs =
                [ { value = Games
                  , trigger = Html.text "Games"
                  , content = Html.text "All my games!"
                  }
                , { value = Music
                  , trigger = Html.text "Music"
                  , content = Html.text "All my music!"
                  }
                , { value = Movies
                  , trigger = Html.text "Movies"
                  , content = Html.text "All my movies!"
                  }
                ]
            }
            |> Radix.Tabs.view
        ]
        |> Radix.Flex.withMaxWidth "40rem"
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.view


type TableGroup
    = Family
    | Friend


viewTables : Html msg
viewTables =
    let
        data =
            [ { name = "Bekah Schuster"
              , email = "cool.lady@carl.com"
              , group = Family
              }
            , { name = "Ryan Haskell-Glatz"
              , email = "ryan.haskelglatz@cars.com"
              , group = Friend
              }
            , { name = "Uriah Schuster"
              , email = "uriah.schuster@fam.com"
              , group = Family
              }
            ]

        columns =
            [ { header = Html.text "Name"
              , cell = \row -> Html.text row.name
              }
            , { header = Html.text "Email"
              , cell = \row -> Html.text row.email
              }
            , { header = Html.text "Group"
              , cell =
                    \row ->
                        Html.text <|
                            case row.group of
                                Family ->
                                    "Family"

                                Friend ->
                                    "Friend"
              }
            ]
    in
    Radix.Flex.new
        [ Radix.Table.new
            { data = data
            , columns = columns
            }
            |> Radix.Table.view
        , Radix.Table.new
            { data = data
            , columns = columns
            }
            |> Radix.Table.withVariantSurface
            |> Radix.Table.view
        ]
        |> Radix.Flex.withMaxWidth "40rem"
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.view


viewSwitches : Model -> Html Msg
viewSwitches model =
    Radix.Flex.new
        [ Radix.Switch.new
            { checked = model.switch
            , onToggle = UserToggledSwitch
            }
            |> Radix.Switch.view
        , Radix.Switch.new
            { checked = model.switch
            , onToggle = UserToggledSwitch
            }
            |> Radix.Switch.withColor Radix.Orange
            |> Radix.Switch.view
        , Radix.Switch.new
            { checked = model.switch
            , onToggle = UserToggledSwitch
            }
            |> Radix.Switch.withRadius Radix.None
            |> Radix.Switch.view
        , Radix.Switch.new
            { checked = model.switch
            , onToggle = UserToggledSwitch
            }
            |> Radix.Switch.withSize1
            |> Radix.Switch.view
        , Radix.Switch.new
            { checked = model.switch
            , onToggle = UserToggledSwitch
            }
            |> Radix.Switch.withSize3
            |> Radix.Switch.view
        , Radix.Switch.new
            { checked = True
            , onToggle = UserToggledSwitch
            }
            |> Radix.Switch.withIsDisabled
            |> Radix.Switch.view
        , Radix.Switch.new
            { checked = False
            , onToggle = UserToggledSwitch
            }
            |> Radix.Switch.withIsDisabled
            |> Radix.Switch.view
        ]
        |> Radix.Flex.withMaxWidth "20rem"
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.view


viewSliders : Model -> Html Msg
viewSliders model =
    Radix.Flex.new
        [ Radix.Slider.new
            { thumbs =
                ( Radix.Slider.Thumb.new
                    { value = model.slider1
                    , onInput = UserChangedSlider1
                    }
                , []
                )
            }
            |> Radix.Slider.withColor Radix.Orange
            |> Radix.Slider.view
        , Radix.Slider.new
            { thumbs =
                ( Radix.Slider.Thumb.new
                    { value = model.slider2Thumb1
                    , onInput = UserChangedSlider2Thumb1
                    }
                , [ Radix.Slider.Thumb.new
                        { value = model.slider2Thumb2
                        , onInput = UserChangedSlider2Thumb2
                        }
                  , Radix.Slider.Thumb.new
                        { value = model.slider2Thumb3
                        , onInput = UserChangedSlider2Thumb3
                        }
                  ]
                )
            }
            |> Radix.Slider.withSize3
            |> Radix.Slider.view
        ]
        |> Radix.Flex.withGapScale 6
        |> Radix.Flex.withMaxWidth "20rem"
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.view


viewProgresses : Html msg
viewProgresses =
    Radix.Flex.new
        [ Radix.Progress.new { value = Radix.Progress.Indeterminate }
            |> Radix.Progress.withSize1
            |> Radix.Progress.view
        , Radix.Progress.new { value = Radix.Progress.Loading { value = 25, max = 100 } }
            |> Radix.Progress.view
        , Radix.Progress.new { value = Radix.Progress.Complete { value = 100, max = 100 } }
            |> Radix.Progress.withSize3
            |> Radix.Progress.view
        ]
        |> Radix.Flex.withDirection Radix.Flex.Column
        |> Radix.Flex.withGapScale 3
        |> Radix.Flex.withMaxWidth "300px"
        |> Radix.Flex.view


viewInset : Html msg
viewInset =
    Radix.Box.new
        [ Radix.Card.new
            [ Radix.Inset.new
                [ Html.img
                    [ Html.Attributes.src "https://images.unsplash.com/photo-1617050318658-a9a3175e34cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80"
                    , Html.Attributes.alt "Bold typography"
                    , Radix.styles
                        [ ( "display", "block" )
                        , ( "objectFit", "cover" )
                        , ( "width", "100%" )
                        , ( "height", "140" )
                        , ( "backgroundColor", "var(--gray-5)" )
                        ]
                    ]
                    []
                ]
                |> Radix.Inset.withClipPaddingBox
                |> Radix.Inset.withSideTop
                |> Radix.Inset.view
            , Radix.Text.new
                [ Radix.Strong.new "Typography"
                    |> Radix.Strong.view
                , Html.text " is the art and technique of arranging type to make written language legible, readable, and appealing when displayed."
                ]
                |> Radix.Text.asParagraph
                |> Radix.Text.withSize 3
                |> Radix.Text.view
            ]
            |> Radix.Card.withSize2
            |> Radix.Card.view
        ]
        |> Radix.Box.withMaxWidth "240px"
        |> Radix.Box.view


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
            |> Radix.TextField.withColor Radix.Orange
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
