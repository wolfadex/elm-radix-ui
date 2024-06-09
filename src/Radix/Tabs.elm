module Radix.Tabs exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode
import Radix
import Radix.TextArea exposing (Resize(..))


type Config value msg
    = Config
        { size : Size
        , wrap : Maybe Wrap
        , justify : Maybe Justify
        , color : Maybe Radix.Color
        , isHighContrast : Bool
        , wrapContentWith : Maybe (Html msg -> Html msg)
        , orientation : Orientation
        , activeTab : value
        , onTabChange : value -> msg
        , tabs : List { value : value, trigger : Html msg, content : Html msg }
        , isRtl : Bool
        }


new :
    { activeTab : value
    , onTabChange : value -> msg
    , tabs : List { value : value, trigger : Html msg, content : Html msg }
    }
    -> Config value msg
new options =
    Config
        { size = Size2
        , wrap = Nothing
        , justify = Nothing
        , color = Nothing
        , isHighContrast = False
        , wrapContentWith = Nothing
        , orientation = Horizontal
        , activeTab = options.activeTab
        , onTabChange = options.onTabChange
        , tabs = options.tabs
        , isRtl = False
        }


type Orientation
    = Horizontal
    | Vertical


withOrientationVertical : Config value msg -> Config value msg
withOrientationVertical (Config config) =
    Config { config | orientation = Vertical }


type Size
    = Size1
    | Size2


sizeToCss : Size -> String
sizeToCss size =
    "rt-r-size-"
        ++ (case size of
                Size1 ->
                    "1"

                Size2 ->
                    "2"
           )


withSize1 : Config value msg -> Config value msg
withSize1 (Config config) =
    Config { config | size = Size1 }


withRtl : Config value msg -> Config value msg
withRtl (Config config) =
    Config { config | isRtl = True }


type Wrap
    = NoWrap
    | Wrap
    | WrapReverse


withNoWrap : Config value msg -> Config value msg
withNoWrap (Config config) =
    Config { config | wrap = Just NoWrap }


withWrap : Config value msg -> Config value msg
withWrap (Config config) =
    Config { config | wrap = Just Wrap }


withWrapReverse : Config value msg -> Config value msg
withWrapReverse (Config config) =
    Config { config | wrap = Just WrapReverse }


type Justify
    = Start
    | Center
    | End


withJustifyStart : Config value msg -> Config value msg
withJustifyStart (Config config) =
    Config { config | justify = Just Start }


withJustifyCenter : Config value msg -> Config value msg
withJustifyCenter (Config config) =
    Config { config | justify = Just Center }


withJustifyEnd : Config value msg -> Config value msg
withJustifyEnd (Config config) =
    Config { config | justify = Just End }


withHighContrast : Config value msg -> Config value msg
withHighContrast (Config config) =
    Config { config | isHighContrast = True }


withColor : Radix.Color -> Config value msg -> Config value msg
withColor color (Config config) =
    Config { config | color = Just color }


wrapContentWith : (Html msg -> Html msg) -> Config value msg -> Config value msg
wrapContentWith fn (Config config) =
    Config { config | wrapContentWith = Just fn }


view : Config value msg -> Html msg
view (Config config) =
    let
        content =
            List.foldr
                (\tab acc ->
                    { tabs =
                        Html.button
                            -- <button id="radix-:r16j:-trigger-account">
                            [ Html.Attributes.type_ "button"
                            , Html.Events.onClick (config.onTabChange tab.value)
                            , Html.Attributes.attribute "role" "tab"
                            , Html.Attributes.attribute "aria-selected" <|
                                if tab.value == config.activeTab then
                                    "true"

                                else
                                    "false"
                            , Html.Attributes.attribute "aria-controls" "radix-:r16j:-content-"
                            , Html.Attributes.attribute "data-state" <|
                                if tab.value == config.activeTab then
                                    "active"

                                else
                                    "inactive"
                            , Html.Attributes.class "rt-reset rt-BaseTabListTrigger rt-TabsTrigger"
                            , Html.Attributes.tabindex <|
                                if tab.value == config.activeTab then
                                    0

                                else
                                    -1
                            , Html.Attributes.attribute "data-orientation" <|
                                case config.orientation of
                                    Horizontal ->
                                        "horizontal"

                                    Vertical ->
                                        "vertical"
                            , Html.Attributes.attribute "data-radix-collection-item" ""
                            ]
                            [ Html.span
                                [ Html.Attributes.class "rt-BaseTabListTriggerInner rt-TabsTriggerInner" ]
                                [ tab.trigger ]
                            , Html.span
                                [ Html.Attributes.class "rt-BaseTabListTriggerInnerHidden rt-TabsTriggerInnerHidden" ]
                                [ tab.trigger ]
                            ]
                            :: acc.tabs
                    , tabContents =
                        (Html.div
                            --     <div id="radix-:r16j:-content-account">
                            [ Html.Attributes.attribute "data-state" <|
                                if tab.value == config.activeTab then
                                    "active"

                                else
                                    "inactive"
                            , Html.Attributes.attribute "data-orientation" <|
                                case config.orientation of
                                    Horizontal ->
                                        "horizontal"

                                    Vertical ->
                                        "vertical"
                            , Html.Attributes.attribute "role" "tabpanel"
                            , Html.Attributes.attribute "aria-labelledby" "radix-:r16j:-trigger-"
                            , Html.Attributes.tabindex 0
                            , Html.Attributes.class "rt-TabsContent"
                            , Html.Attributes.hidden (not (tab.value == config.activeTab))
                            ]
                            [ if tab.value == config.activeTab then
                                tab.content

                              else
                                Html.text ""
                            ]
                            |> (config.wrapContentWith
                                    |> Maybe.withDefault identity
                               )
                        )
                            :: acc.tabContents
                    }
                )
                { tabs = []
                , tabContents = []
                }
                config.tabs
    in
    Html.div
        [ Html.Attributes.classList
            [ ( "rt-TabsRoot", True )
            , ( sizeToCss config.size, True )
            ]
        , Html.Attributes.attribute "data-orientation" <|
            case config.orientation of
                Horizontal ->
                    "horizontal"

                Vertical ->
                    "vertical"
        ]
        (Html.div
            [ Html.Attributes.classList
                [ ( "rt-BaseTabList", True )
                , ( "rt-TabsList", True )
                , ( sizeToCss config.size, True )
                ]
            , Html.Attributes.attribute "role" "tablist"
            , Html.Attributes.attribute "data-orientation" <|
                case config.orientation of
                    Horizontal ->
                        "horizontal"

                    Vertical ->
                        "vertical"
            , Html.Attributes.attribute "aria-orientation" <|
                case config.orientation of
                    Horizontal ->
                        "horizontal"

                    Vertical ->
                        "vertical"
            , Radix.styles
                [ ( "outline", "none" )
                ]
            , Html.Attributes.tabindex 0
            , Html.Events.on "keydown" <|
                (Json.Decode.field "key" Json.Decode.string
                    |> Json.Decode.andThen
                        (\key ->
                            case key of
                                "ArrowRight" ->
                                    if config.orientation == Horizontal then
                                        config.tabs
                                            |> dropUntil .value config.activeTab
                                            |> List.head
                                            |> Maybe.map .value
                                            |> Maybe.withDefault config.activeTab
                                            |> config.onTabChange
                                            |> Json.Decode.succeed

                                    else
                                        Json.Decode.fail "Only supported in Horizontal orientation"

                                "ArrowLeft" ->
                                    if config.orientation == Horizontal then
                                        config.tabs
                                            |> List.reverse
                                            |> dropUntil .value config.activeTab
                                            |> List.head
                                            |> Maybe.map .value
                                            |> Maybe.withDefault config.activeTab
                                            |> config.onTabChange
                                            |> Json.Decode.succeed

                                    else
                                        Json.Decode.fail "Only supported in Horizontal orientation"

                                "ArrowUp" ->
                                    if config.orientation == Vertical then
                                        config.tabs
                                            |> dropUntil .value config.activeTab
                                            |> List.head
                                            |> Maybe.map .value
                                            |> Maybe.withDefault config.activeTab
                                            |> config.onTabChange
                                            |> Json.Decode.succeed

                                    else
                                        Json.Decode.fail "Only supported in Vertical orientation"

                                "ArrowDown" ->
                                    if config.orientation == Vertical then
                                        config.tabs
                                            |> List.reverse
                                            |> dropUntil .value config.activeTab
                                            |> List.head
                                            |> Maybe.map .value
                                            |> Maybe.withDefault config.activeTab
                                            |> config.onTabChange
                                            |> Json.Decode.succeed

                                    else
                                        Json.Decode.fail "Only supported in Vertical orientation"

                                "Home" ->
                                    config.tabs
                                        |> List.head
                                        |> Maybe.map .value
                                        |> Maybe.withDefault config.activeTab
                                        |> config.onTabChange
                                        |> Json.Decode.succeed

                                "End" ->
                                    config.tabs
                                        |> List.reverse
                                        |> List.head
                                        |> Maybe.map .value
                                        |> Maybe.withDefault config.activeTab
                                        |> config.onTabChange
                                        |> Json.Decode.succeed

                                _ ->
                                    Json.Decode.fail "Unsupported keyboard input"
                        )
                )
            ]
            content.tabs
            :: content.tabContents
        )



-- Helpers


dropUntil : (a -> value) -> value -> List a -> List a
dropUntil pred value list =
    case list of
        [] ->
            list

        next :: rest ->
            if pred next == value then
                rest

            else
                dropUntil pred value list
