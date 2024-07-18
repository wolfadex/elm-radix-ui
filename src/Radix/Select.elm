module Radix.Select exposing (..)

import Browser.Dom
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode
import Radix
import Radix.Icon
import Radix.Internal
import Radix.Select.Item
import Random
import Task


type Model item
    = Model
        { focused : Maybe item
        , open : Bool
        , id : Maybe String
        }


init : Model item
init =
    Model
        { focused = Nothing
        , open = False
        , id = Nothing
        }


type Msg item
    = Focused
    | Blurred
    | SelectPressed
    | SelectionMade item
    | IdGenerated String
    | Hovered item
    | Unhovered
    | FocusNext
    | FocusPrevious


update :
    { msg : Msg item
    , model : Model item
    , toMsg : Msg item -> msg
    , toModel : Model item -> model
    , onSelect : item -> ( Model item, Cmd msg ) -> ( model, Cmd msg )
    , config : Config item msg
    }
    -> ( model, Cmd msg )
update options =
    let
        (Model model) =
            options.model

        (Config config) =
            options.config
    in
    case options.msg of
        IdGenerated id ->
            ( { model | id = Just id }
                |> Model
                |> options.toModel
            , Cmd.none
            )

        Hovered item ->
            ( { model | focused = Just item }
                |> Model
                |> options.toModel
            , Cmd.none
            )

        Unhovered ->
            ( { model | focused = Nothing }
                |> Model
                |> options.toModel
            , Cmd.none
            )

        Focused ->
            ( { model
                | open = True
                , focused =
                    case config.value of
                        Just v ->
                            Just v

                        Nothing ->
                            Radix.Select.Item.findFirst config.items
              }
                |> Model
                |> options.toModel
            , case model.id of
                Just _ ->
                    Cmd.none

                Nothing ->
                    Radix.Internal.generateUuid
                        |> Random.generate (IdGenerated >> options.toMsg)
            )

        FocusNext ->
            ( { model
                | focused =
                    case model.focused of
                        Just v ->
                            case Radix.Select.Item.findNext v config.items of
                                Nothing ->
                                    model.focused

                                Just f ->
                                    Just f

                        Nothing ->
                            Radix.Select.Item.findFirst config.items
              }
                |> Model
                |> options.toModel
            , Cmd.none
            )

        FocusPrevious ->
            ( { model
                | focused =
                    case model.focused of
                        Just v ->
                            case Radix.Select.Item.findPrevious v config.items of
                                Nothing ->
                                    model.focused

                                Just f ->
                                    Just f

                        Nothing ->
                            Radix.Select.Item.findFirst config.items
              }
                |> Model
                |> options.toModel
            , Cmd.none
            )

        Blurred ->
            ( { model
                | focused = Nothing
                , open = False
              }
                |> Model
                |> options.toModel
            , Cmd.none
            )

        SelectPressed ->
            ( model
                |> Model
            , case model.focused of
                Just _ ->
                    let
                        id =
                            config.id
                                |> Radix.Internal.maybeElse model.id
                                |> Maybe.withDefault ""
                    in
                    id
                        |> Browser.Dom.blur
                        |> Task.andThen (\_ -> Browser.Dom.focus id)
                        |> Task.attempt (\_ -> options.toMsg Blurred)

                Nothing ->
                    Cmd.none
            )
                |> (case model.focused of
                        Just focused ->
                            options.onSelect focused

                        Nothing ->
                            Tuple.mapFirst options.toModel
                   )

        SelectionMade item ->
            ( model
                |> Model
            , let
                id =
                    config.id
                        |> Radix.Internal.maybeElse model.id
                        |> Maybe.withDefault ""
              in
              id
                |> Browser.Dom.blur
                |> Task.andThen (\_ -> Browser.Dom.focus id)
                |> Task.attempt (\_ -> options.toMsg Blurred)
            )
                |> options.onSelect item


type Config item msg
    = Config
        { value : Maybe item
        , items : List (Radix.Select.Item.Config item msg)
        , itemToString : item -> String
        , size : Size
        , variant : Variant
        , color : Maybe Radix.Color
        , placeholder : Maybe String
        , toMsg : Msg item -> msg
        , position : Position
        , id : Maybe String

        -- TODO:
        -- , radius : Maybe Radius
        }


new :
    { value : Maybe item
    , itemToString : item -> String
    , items : List (Radix.Select.Item.Config item msg)
    , toMsg : Msg item -> msg
    }
    -> Config item msg
new options =
    Config
        { value = options.value
        , items = options.items
        , itemToString = options.itemToString
        , toMsg = options.toMsg
        , size = Size2
        , variant = Surface
        , color = Nothing
        , placeholder = Nothing
        , position = ItemAligned
        , id = Nothing
        }


type Position
    = ItemAligned
    | Popover


withPositionPopover : Config item msg -> Config item msg
withPositionPopover (Config config) =
    Config { config | position = Popover }


type Size
    = Size1
    | Size2
    | Size3


withSize1 : Config item msg -> Config item msg
withSize1 (Config config) =
    Config { config | size = Size1 }


withSize3 : Config item msg -> Config item msg
withSize3 (Config config) =
    Config { config | size = Size3 }


sizeToCss : Size -> String
sizeToCss size =
    case size of
        Size1 ->
            "rt-r-size-1"

        Size2 ->
            "rt-r-size-2"

        Size3 ->
            "rt-r-size-3"


type Variant
    = Classic
    | Surface
    | Soft
    | Ghost


withVariantClassic : Config item msg -> Config item msg
withVariantClassic (Config config) =
    Config { config | variant = Classic }


withVariantSoft : Config item msg -> Config item msg
withVariantSoft (Config config) =
    Config { config | variant = Soft }


withVariantGhost : Config item msg -> Config item msg
withVariantGhost (Config config) =
    Config { config | variant = Ghost }


variantToCss : Variant -> String
variantToCss variant =
    case variant of
        Classic ->
            "rt-variant-classic"

        Surface ->
            "rt-variant-surface"

        Soft ->
            "rt-variant-soft"

        Ghost ->
            "rt-variant-ghost"


withColor : Radix.Color -> Config item msg -> Config item msg
withColor color (Config config) =
    Config { config | color = Just color }


withPlaceholder : String -> Config item msg -> Config item msg
withPlaceholder placeholder (Config config) =
    Config { config | placeholder = Just placeholder }


withId : String -> Config item msg -> Config item msg
withId id (Config config) =
    Config { config | id = Just id }


view : Model item -> Config item msg -> Html msg
view (Model model) (Config config) =
    -- <button aria-controls="radix-:r1n6:" aria-expanded="false" aria-autocomplete="none" dir="ltr" data-state="closed">
    --   <span class="rt-SelectTriggerInner">
    --     <span style="pointer-events: none;">Apple</span>
    --   </span>
    --   ✔️
    -- </button>
    Html.button
        [ Html.Attributes.classList
            [ ( "rt-reset", True )
            , ( "rt-SelectTrigger", True )
            , ( sizeToCss config.size, True )
            , ( variantToCss config.variant, True )
            ]
        , Html.Attributes.type_ "button"
        , Html.Attributes.attribute "role" "combobox"
        , Html.Attributes.attribute "aria-expanded" <|
            if model.open then
                "true"

            else
                "false"
        , Html.Attributes.attribute "aria-autocomplete" <|
            "none"
        , Html.Attributes.attribute "data-state" <|
            if model.open then
                "open"

            else
                "closed"

        -- Elm specific
        , config.id
            |> Radix.Internal.maybeElse model.id
            |> Radix.Internal.attributeMaybe Html.Attributes.id
        , Html.Events.on "pointerdown" (Json.Decode.succeed (config.toMsg Focused))
        , Html.Events.on "focusout" (Json.Decode.succeed (config.toMsg Blurred))
        , Html.Events.on "keydown" (decodeKeyDown model.open config.toMsg)
        ]
        [ Html.span
            [ Html.Attributes.class "rt-SelectTriggerInner"
            ]
            [ Html.span
                [ Html.Attributes.style "pointer-events" "none" ]
                [ Html.text <|
                    case config.value of
                        Nothing ->
                            Maybe.withDefault "" config.placeholder

                        Just value ->
                            config.itemToString value
                ]
            ]
        , Radix.Icon.chevronDown
            |> Radix.Icon.view

        -- <div
        --     style="box-sizing: border-box; max-height: 100%; display: flex; flex-direction: column; outline: none; pointer-events: auto;"
        --     data-is-root-theme="false"
        --     data-gray-color="slate"
        --     data-has-background="false"
        --     data-panel-background="translucent"
        --     data-radius="medium"
        --     data-scaling="100%"
        --     tabindex="-1">
        --   <div dir="ltr" class="rt-ScrollAreaRoot" style="position: relative; --radix-scroll-area-corner-width: 0px; --radix-scroll-area-corner-height: 0px;"><style>[data-radix-select-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-select-viewport]::-webkit-scrollbar{display:none}</style><style>[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}</style><div data-radix-scroll-area-viewport="" class="rt-SelectViewport rt-ScrollAreaViewport" style="overflow: auto; position: relative; flex: 1 1 0%;" data-radix-select-viewport="" role="presentation">
        --     <div style="min-width: 100%; display: table;">
        --     </div>
        --   </div>
        -- </div>
        -- </div>
        , if model.open then
            Html.div
                [ Html.Attributes.attribute "role" "listbox"
                , Html.Attributes.attribute "data-state" "open"
                , Radix.Internal.attributeMaybe
                    (\color -> Html.Attributes.attribute "data-accent-color" (Radix.colorToString color))
                    config.color
                , Html.Attributes.classList
                    [ ( "rt-SelectContent", True )
                    , ( sizeToCss config.size, True )
                    , ( "rt-variant-solid", True )
                    ]

                -- Elm specific
                , Html.Attributes.property "___elm-radix-ui-select-list"
                    (Json.Encode.object
                        [ ( "isPopoverStyle"
                          , Json.Encode.bool <|
                                case config.position of
                                    Popover ->
                                        True

                                    ItemAligned ->
                                        False
                          )
                        , ( "value"
                          , config.value
                                |> Radix.Internal.maybeElse
                                    (Radix.Select.Item.filterToValues config.items |> List.head)
                                |> Maybe.map config.itemToString
                                |> Maybe.withDefault ""
                                |> Json.Encode.string
                          )
                        ]
                    )
                ]
                [ Html.div []
                    (List.map
                        (Radix.Select.Item.view
                            { currentValue = config.value
                            , itemToString = config.itemToString
                            , onSelect = SelectionMade >> config.toMsg
                            , focused = model.focused
                            , onHovered = Hovered >> config.toMsg
                            , onUnhovered = config.toMsg Unhovered
                            }
                        )
                        config.items
                    )
                ]

          else
            Html.text ""

        --
        --
        --
        --
        --
        --
        --
        --
        --         target
        --         , Html.div
        --             [ Html.Attributes.property "___elm-radix-ui-tooltip" Json.Encode.null
        --             , Html.Attributes.attribute "popover" "manual"
        --             --
        --             , Html.Attributes.classList
        --                 [ ( "rt-TooltipContent", True )
        --                 , ( "rt-r-max-w", True )
        --                 ]
        --             , Html.Attributes.attribute "data-side" "top"
        --             , Html.Attributes.attribute "data-align" "center"
        --             , Html.Attributes.attribute "data-state" "delayed-open"
        --             , Html.Attributes.attribute "style" """
        -- --max-width: 360px;
        -- --radix-popper-transform-origin:
        -- --radix-tooltip-content-transform-origin: var(--radix-popper-transform-origin);
        -- --radix-tooltip-content-available-width: var(--radix-popper-available-width);
        -- --radix-tooltip-content-available-height: var(--radix-popper-available-height);
        -- --radix-tooltip-trigger-width: var(--radix-popper-anchor-width);
        -- --radix-tooltip-trigger-height: var(--radix-popper-anchor-height);
        -- """
        --             ]
        --             [ Radix.Text.new
        --                 [ Html.text config.content ]
        --                 |> Radix.Text.asParagraph
        --                 |> Radix.Text.withCustomClassList
        --                     [ ( "rt-TooltipText", True )
        --                     ]
        --                 |> Radix.Text.view
        --             , Html.div
        --                 [ Html.Attributes.class "rt-TooltipArrow"
        --                 ]
        --                 []
        --             ]
        ]


decodeKeyDown : Bool -> (Msg item -> msg) -> Json.Decode.Decoder msg
decodeKeyDown isOpen toMsg =
    Json.Decode.field "key" Json.Decode.string
        |> Json.Decode.andThen
            (\key ->
                case key of
                    "ArrowDown" ->
                        (if isOpen then
                            FocusNext

                         else
                            Focused
                        )
                            |> toMsg
                            |> Json.Decode.succeed

                    "ArrowUp" ->
                        (if isOpen then
                            FocusPrevious

                         else
                            Focused
                        )
                            |> toMsg
                            |> Json.Decode.succeed

                    "Escape" ->
                        Blurred
                            |> toMsg
                            |> Json.Decode.succeed

                    "Enter" ->
                        (if isOpen then
                            SelectPressed

                         else
                            Focused
                        )
                            |> toMsg
                            |> Json.Decode.succeed

                    " " ->
                        (if isOpen then
                            SelectPressed

                         else
                            Focused
                        )
                            |> toMsg
                            |> Json.Decode.succeed

                    _ ->
                        Json.Decode.fail "Unsupported key down"
            )
