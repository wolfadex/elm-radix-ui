module Radix.Layout exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal



-- CREATE


type Layout
    = Layout
        { padding :
            { top : Maybe Radix.Internal.EnumOrLiteral
            , right : Maybe Radix.Internal.EnumOrLiteral
            , bottom : Maybe Radix.Internal.EnumOrLiteral
            , left : Maybe Radix.Internal.EnumOrLiteral
            }
        , width : Maybe String
        , minWidth : Maybe String
        , maxWidth : Maybe String
        , height : Maybe String
        , minHeight : Maybe String
        , maxHeight : Maybe String
        , position : Maybe Radix.Position
        , inset : Maybe Radix.Internal.EnumOrLiteral
        , top : Maybe Radix.Internal.EnumOrLiteral
        , right : Maybe Radix.Internal.EnumOrLiteral
        , bottom : Maybe Radix.Internal.EnumOrLiteral
        , left : Maybe Radix.Internal.EnumOrLiteral
        , overflow :
            { x : Maybe Overflow
            , y : Maybe Overflow
            }
        , flexBasis : Maybe String
        , flexShrink : Maybe Radix.Internal.EnumOrLiteral
        , flexGrow : Maybe Radix.Internal.EnumOrLiteral
        , gridColumn : Maybe Radix.Internal.EnumOrLiteral
        , gridColumnStart : Maybe Radix.Internal.EnumOrLiteral
        , gridColumnEnd : Maybe Radix.Internal.EnumOrLiteral
        , gridRow : Maybe Radix.Internal.EnumOrLiteral
        , gridRowStart : Maybe Radix.Internal.EnumOrLiteral
        , gridRowEnd : Maybe Radix.Internal.EnumOrLiteral
        }


empty : Layout
empty =
    Layout
        { padding = { top = Nothing, right = Nothing, bottom = Nothing, left = Nothing }
        , width = Nothing
        , minWidth = Nothing
        , maxWidth = Nothing
        , height = Nothing
        , minHeight = Nothing
        , maxHeight = Nothing
        , position = Nothing
        , inset = Nothing
        , top = Nothing
        , right = Nothing
        , bottom = Nothing
        , left = Nothing
        , overflow = { x = Nothing, y = Nothing }
        , flexBasis = Nothing
        , flexShrink = Nothing
        , flexGrow = Nothing
        , gridColumn = Nothing
        , gridColumnStart = Nothing
        , gridColumnEnd = Nothing
        , gridRow = Nothing
        , gridRowStart = Nothing
        , gridRowEnd = Nothing
        }



-- MODIFIERS


withPaddingScale : Int -> Layout -> Layout
withPaddingScale scale =
    setPadding
        (\_ ->
            { top = Just (Radix.Internal.Enum scale)
            , right = Just (Radix.Internal.Enum scale)
            , bottom = Just (Radix.Internal.Enum scale)
            , left = Just (Radix.Internal.Enum scale)
            }
        )


withPaddingLiteral : String -> Layout -> Layout
withPaddingLiteral literal =
    setPadding
        (\padding ->
            { top = Just (Radix.Internal.Literal literal)
            , right = Just (Radix.Internal.Literal literal)
            , bottom = Just (Radix.Internal.Literal literal)
            , left = Just (Radix.Internal.Literal literal)
            }
        )


withPaddingXScale : Int -> Layout -> Layout
withPaddingXScale scale =
    setPadding
        (\padding ->
            { padding
                | right = Just (Radix.Internal.Enum scale)
                , left = Just (Radix.Internal.Enum scale)
            }
        )


withPaddingXLiteral : String -> Layout -> Layout
withPaddingXLiteral literal =
    setPadding
        (\padding ->
            { padding
                | right = Just (Radix.Internal.Literal literal)
                , left = Just (Radix.Internal.Literal literal)
            }
        )


withPaddingYScale : Int -> Layout -> Layout
withPaddingYScale scale =
    setPadding
        (\padding ->
            { padding
                | top = Just (Radix.Internal.Enum scale)
                , bottom = Just (Radix.Internal.Enum scale)
            }
        )


withPaddingYLiteral : String -> Layout -> Layout
withPaddingYLiteral literal =
    setPadding
        (\padding ->
            { padding
                | top = Just (Radix.Internal.Literal literal)
                , bottom = Just (Radix.Internal.Literal literal)
            }
        )


withPaddingTopScale : Int -> Layout -> Layout
withPaddingTopScale scale =
    setPadding
        (\padding ->
            { padding
                | top = Just (Radix.Internal.Enum scale)
            }
        )


withPaddingTopLiteral : String -> Layout -> Layout
withPaddingTopLiteral literal =
    setPadding
        (\padding ->
            { padding
                | top = Just (Radix.Internal.Literal literal)
            }
        )


withPaddingRightScale : Int -> Layout -> Layout
withPaddingRightScale scale =
    setPadding
        (\padding ->
            { padding
                | right = Just (Radix.Internal.Enum scale)
            }
        )


withPaddingRightLiteral : String -> Layout -> Layout
withPaddingRightLiteral literal =
    setPadding
        (\padding ->
            { padding
                | right = Just (Radix.Internal.Literal literal)
            }
        )


withPaddingBottomScale : Int -> Layout -> Layout
withPaddingBottomScale scale =
    setPadding
        (\padding ->
            { padding
                | bottom = Just (Radix.Internal.Enum scale)
            }
        )


withPaddingBottomLiteral : String -> Layout -> Layout
withPaddingBottomLiteral literal =
    setPadding
        (\padding ->
            { padding
                | bottom = Just (Radix.Internal.Literal literal)
            }
        )


withPaddingLeftScale : Int -> Layout -> Layout
withPaddingLeftScale scale =
    setPadding
        (\padding ->
            { padding
                | left = Just (Radix.Internal.Enum scale)
            }
        )


withPaddingLeftLiteral : String -> Layout -> Layout
withPaddingLeftLiteral literal =
    setPadding
        (\padding ->
            { padding
                | left = Just (Radix.Internal.Literal literal)
            }
        )


setPadding :
    ({ top : Maybe Radix.Internal.EnumOrLiteral
     , right : Maybe Radix.Internal.EnumOrLiteral
     , bottom : Maybe Radix.Internal.EnumOrLiteral
     , left : Maybe Radix.Internal.EnumOrLiteral
     }
     ->
        { top : Maybe Radix.Internal.EnumOrLiteral
        , right : Maybe Radix.Internal.EnumOrLiteral
        , bottom : Maybe Radix.Internal.EnumOrLiteral
        , left : Maybe Radix.Internal.EnumOrLiteral
        }
    )
    -> Layout
    -> Layout
setPadding f (Layout config) =
    Layout
        { config
            | padding = f config.padding
        }


withWidth : String -> Layout -> Layout
withWidth width (Layout config) =
    Layout
        { config
            | width = Just width
        }


withMinWidth : String -> Layout -> Layout
withMinWidth minWidth (Layout config) =
    Layout
        { config
            | minWidth = Just minWidth
        }


withMaxWidth : String -> Layout -> Layout
withMaxWidth maxWidth (Layout config) =
    Layout
        { config
            | maxWidth = Just maxWidth
        }


withHeight : String -> Layout -> Layout
withHeight height (Layout config) =
    Layout
        { config
            | height = Just height
        }


withMinHeight : String -> Layout -> Layout
withMinHeight minHeight (Layout config) =
    Layout
        { config
            | minHeight = Just minHeight
        }


withMaxHeight : String -> Layout -> Layout
withMaxHeight maxHeight (Layout config) =
    Layout
        { config
            | maxHeight = Just maxHeight
        }


withPosition : Radix.Position -> Layout -> Layout
withPosition position (Layout config) =
    Layout
        { config
            | position = Just position
        }


withInsetScale : Int -> Layout -> Layout
withInsetScale scale (Layout config) =
    Layout
        { config
            | inset = Just (Radix.Internal.Enum scale)
        }


withInsetLiteral : String -> Layout -> Layout
withInsetLiteral literal (Layout config) =
    Layout
        { config
            | inset = Just (Radix.Internal.Literal literal)
        }


withTopScale : Int -> Layout -> Layout
withTopScale scale (Layout config) =
    Layout
        { config
            | top = Just (Radix.Internal.Enum scale)
        }


withTopLiteral : String -> Layout -> Layout
withTopLiteral literal (Layout config) =
    Layout
        { config
            | top = Just (Radix.Internal.Literal literal)
        }


withRightScale : Int -> Layout -> Layout
withRightScale scale (Layout config) =
    Layout
        { config
            | right = Just (Radix.Internal.Enum scale)
        }


withRightLiteral : String -> Layout -> Layout
withRightLiteral literal (Layout config) =
    Layout
        { config
            | right = Just (Radix.Internal.Literal literal)
        }


withBottomScale : Int -> Layout -> Layout
withBottomScale scale (Layout config) =
    Layout
        { config
            | bottom = Just (Radix.Internal.Enum scale)
        }


withBottomLiteral : String -> Layout -> Layout
withBottomLiteral literal (Layout config) =
    Layout
        { config
            | bottom = Just (Radix.Internal.Literal literal)
        }


withLeftScale : Int -> Layout -> Layout
withLeftScale scale (Layout config) =
    Layout
        { config
            | left = Just (Radix.Internal.Enum scale)
        }


withLeftLiteral : String -> Layout -> Layout
withLeftLiteral literal (Layout config) =
    Layout
        { config
            | left = Just (Radix.Internal.Literal literal)
        }


type Overflow
    = Visible
    | Hidden
    | Clip
    | Scroll
    | Auto


overflowToCssSuffix : Overflow -> String
overflowToCssSuffix overflow =
    case overflow of
        Visible ->
            "visible"

        Hidden ->
            "hidden"

        Clip ->
            "clip"

        Scroll ->
            "scroll"

        Auto ->
            "auto"


withOverflow : Overflow -> Layout -> Layout
withOverflow overflow (Layout config) =
    Layout
        { config
            | overflow = { x = Just overflow, y = Just overflow }
        }


withOverflowX : Overflow -> Layout -> Layout
withOverflowX overflow (Layout config) =
    let
        overflow_ =
            config.overflow
    in
    Layout
        { config
            | overflow = { overflow_ | x = Just overflow }
        }


withOverflowY : Overflow -> Layout -> Layout
withOverflowY overflow (Layout config) =
    let
        overflow_ =
            config.overflow
    in
    Layout
        { config
            | overflow = { overflow_ | y = Just overflow }
        }


withFlexBasis : String -> Layout -> Layout
withFlexBasis flexBasis (Layout config) =
    Layout
        { config
            | flexBasis = Just flexBasis
        }


withFlexShrink1 : Layout -> Layout
withFlexShrink1 (Layout config) =
    Layout
        { config
            | flexShrink = Just (Radix.Internal.Enum 1)
        }


withFlexShrink0 : Layout -> Layout
withFlexShrink0 (Layout config) =
    Layout
        { config
            | flexShrink = Just (Radix.Internal.Enum 0)
        }


withFlexShrinkLiteral : String -> Layout -> Layout
withFlexShrinkLiteral literal (Layout config) =
    Layout
        { config
            | flexShrink = Just (Radix.Internal.Literal literal)
        }


withFlexGrow1 : Layout -> Layout
withFlexGrow1 (Layout config) =
    Layout
        { config
            | flexGrow = Just (Radix.Internal.Enum 1)
        }


withFlexGrow0 : Layout -> Layout
withFlexGrow0 (Layout config) =
    Layout
        { config
            | flexGrow = Just (Radix.Internal.Enum 0)
        }


withFlexGrowLiteral : String -> Layout -> Layout
withFlexGrowLiteral literal (Layout config) =
    Layout
        { config
            | flexGrow = Just (Radix.Internal.Literal literal)
        }


withGridColumnScale : Int -> Layout -> Layout
withGridColumnScale scale (Layout config) =
    Layout
        { config
            | gridColumn = Just (Radix.Internal.Enum scale)
        }


withGridColumnLiteral : String -> Layout -> Layout
withGridColumnLiteral literal (Layout config) =
    Layout
        { config
            | gridColumn = Just (Radix.Internal.Literal literal)
        }


withGridColumnStartScale : Int -> Layout -> Layout
withGridColumnStartScale scale (Layout config) =
    Layout
        { config
            | gridColumnStart = Just (Radix.Internal.Enum scale)
        }


withGridColumnStartLiteral : String -> Layout -> Layout
withGridColumnStartLiteral literal (Layout config) =
    Layout
        { config
            | gridColumnStart = Just (Radix.Internal.Literal literal)
        }


withGridColumnEndScale : Int -> Layout -> Layout
withGridColumnEndScale scale (Layout config) =
    Layout
        { config
            | gridColumnEnd = Just (Radix.Internal.Enum scale)
        }


withGridColumnEndLiteral : String -> Layout -> Layout
withGridColumnEndLiteral literal (Layout config) =
    Layout
        { config
            | gridColumnEnd = Just (Radix.Internal.Literal literal)
        }


withGridRowScale : Int -> Layout -> Layout
withGridRowScale scale (Layout config) =
    Layout
        { config
            | gridRow = Just (Radix.Internal.Enum scale)
        }


withGridRowLiteral : String -> Layout -> Layout
withGridRowLiteral literal (Layout config) =
    Layout
        { config
            | gridRow = Just (Radix.Internal.Literal literal)
        }


withGridRowStartScale : Int -> Layout -> Layout
withGridRowStartScale scale (Layout config) =
    Layout
        { config
            | gridRowStart = Just (Radix.Internal.Enum scale)
        }


withGridRowStartLiteral : String -> Layout -> Layout
withGridRowStartLiteral literal (Layout config) =
    Layout
        { config
            | gridRowStart = Just (Radix.Internal.Literal literal)
        }


withGridRowEndScale : Int -> Layout -> Layout
withGridRowEndScale scale (Layout config) =
    Layout
        { config
            | gridRowEnd = Just (Radix.Internal.Enum scale)
        }


withGridRowEndLiteral : String -> Layout -> Layout
withGridRowEndLiteral literal (Layout config) =
    Layout
        { config
            | gridRowEnd = Just (Radix.Internal.Literal literal)
        }



-- TO ATTRIBUTES


toAttributes :
    Layout
    ->
        { classes : List ( String, Bool )
        , styles : List ( String, String )
        , otherAttributes : List (Html.Attribute msg)
        }
toAttributes (Layout layout) =
    let
        ( paddingClasses, paddingStyles ) =
            paddingToClassesAndStyles layout.padding

        overflowClasses =
            case ( layout.overflow.x, layout.overflow.y ) of
                ( Just x, Just y ) ->
                    if x == y then
                        [ ( "rt-r-overflow-" ++ overflowToCssSuffix x, True )
                        ]

                    else
                        [ ( "rt-r-ox-" ++ overflowToCssSuffix x, True )
                        , ( "rt-r-oy-" ++ overflowToCssSuffix y, True )
                        ]

                ( Just x, Nothing ) ->
                    [ ( "rt-r-ox-" ++ overflowToCssSuffix x, True )
                    ]

                ( Nothing, Just y ) ->
                    [ ( "rt-r-oy-" ++ overflowToCssSuffix y, True )
                    ]

                ( Nothing, Nothing ) ->
                    []
    in
    { classes =
        [ ( "rt-r-w", layout.width /= Nothing )
        , ( "rt-r-min-w", layout.minWidth /= Nothing )
        , ( "rt-r-max-w", layout.maxWidth /= Nothing )
        , ( "rt-r-h", layout.height /= Nothing )
        , ( "rt-r-min-h", layout.minHeight /= Nothing )
        , ( "rt-r-max-h", layout.maxHeight /= Nothing )
        , ( "rt-r-fb", layout.flexBasis /= Nothing )
        , Radix.Internal.classListMaybe
            Radix.positionToCss
            layout.position
        , Radix.Internal.classListMaybe
            (\inset ->
                case inset of
                    Radix.Internal.Enum scale ->
                        "rt-r-inset-" ++ String.fromInt scale

                    Radix.Internal.Literal _ ->
                        "rt-r-inset"
            )
            layout.inset
        , Radix.Internal.classListMaybe
            (\top ->
                case top of
                    Radix.Internal.Enum scale ->
                        "rt-r-top-" ++ String.fromInt scale

                    Radix.Internal.Literal _ ->
                        "rt-r-top"
            )
            layout.top
        , Radix.Internal.classListMaybe
            (\right ->
                case right of
                    Radix.Internal.Enum scale ->
                        "rt-r-right-" ++ String.fromInt scale

                    Radix.Internal.Literal _ ->
                        "rt-r-right"
            )
            layout.right
        , Radix.Internal.classListMaybe
            (\bottom ->
                case bottom of
                    Radix.Internal.Enum scale ->
                        "rt-r-bottom-" ++ String.fromInt scale

                    Radix.Internal.Literal _ ->
                        "rt-r-bottom"
            )
            layout.bottom
        , Radix.Internal.classListMaybe
            (\left ->
                case left of
                    Radix.Internal.Enum scale ->
                        "rt-r-left-" ++ String.fromInt scale

                    Radix.Internal.Literal _ ->
                        "rt-r-left"
            )
            layout.left
        , Radix.Internal.classListMaybe
            (\flexShrink ->
                case flexShrink of
                    Radix.Internal.Enum scale ->
                        "rt-r-fs-" ++ String.fromInt scale

                    Radix.Internal.Literal _ ->
                        "rt-r-fs"
            )
            layout.flexShrink
        , Radix.Internal.classListMaybe
            (\flexGrow ->
                case flexGrow of
                    Radix.Internal.Enum scale ->
                        "rt-r-fg-" ++ String.fromInt scale

                    Radix.Internal.Literal _ ->
                        "rt-r-fg"
            )
            layout.flexGrow
        , Radix.Internal.classListMaybe
            (\gridColumn ->
                case gridColumn of
                    Radix.Internal.Enum scale ->
                        "rt-r-gc-" ++ String.fromInt scale

                    Radix.Internal.Literal _ ->
                        "rt-r-gc"
            )
            layout.gridColumn
        , Radix.Internal.classListMaybe
            (\gridColumnStart ->
                case gridColumnStart of
                    Radix.Internal.Enum scale ->
                        "rt-r-gcs-" ++ String.fromInt scale

                    Radix.Internal.Literal _ ->
                        "rt-r-gcs"
            )
            layout.gridColumnStart
        , Radix.Internal.classListMaybe
            (\gridColumnEnd ->
                case gridColumnEnd of
                    Radix.Internal.Enum scale ->
                        "rt-r-gce-" ++ String.fromInt scale

                    Radix.Internal.Literal _ ->
                        "rt-r-gce"
            )
            layout.gridColumnEnd
        , Radix.Internal.classListMaybe
            (\gridRow ->
                case gridRow of
                    Radix.Internal.Enum scale ->
                        "rt-r-gr-" ++ String.fromInt scale

                    Radix.Internal.Literal _ ->
                        "rt-r-gr"
            )
            layout.gridRow
        , Radix.Internal.classListMaybe
            (\gridRowStart ->
                case gridRowStart of
                    Radix.Internal.Enum scale ->
                        "rt-r-grs-" ++ String.fromInt scale

                    Radix.Internal.Literal _ ->
                        "rt-r-grs"
            )
            layout.gridRowStart
        , Radix.Internal.classListMaybe
            (\gridRowEnd ->
                case gridRowEnd of
                    Radix.Internal.Enum scale ->
                        "rt-r-gre-" ++ String.fromInt scale

                    Radix.Internal.Literal _ ->
                        "rt-r-gre"
            )
            layout.gridRowEnd
        ]
            ++ paddingClasses
    , styles =
        List.filterMap identity
            [ Maybe.map
                (\width -> ( "--width", width ))
                layout.width
            , Maybe.map
                (\minWidth -> ( "--min-width", minWidth ))
                layout.minWidth
            , Maybe.map
                (\maxWidth -> ( "--max-width", maxWidth ))
                layout.maxWidth
            , Maybe.map
                (\height -> ( "--height", height ))
                layout.height
            , Maybe.map
                (\minHeight -> ( "--min-height", minHeight ))
                layout.minHeight
            , Maybe.map
                (\maxHeight -> ( "--max-height", maxHeight ))
                layout.maxHeight
            , Maybe.andThen
                (\inset ->
                    case inset of
                        Radix.Internal.Enum _ ->
                            Nothing

                        Radix.Internal.Literal literal ->
                            Just ( "--inset", literal )
                )
                layout.inset
            , Maybe.andThen
                (\top ->
                    case top of
                        Radix.Internal.Enum _ ->
                            Nothing

                        Radix.Internal.Literal literal ->
                            Just ( "--top", literal )
                )
                layout.top
            , Maybe.andThen
                (\right ->
                    case right of
                        Radix.Internal.Enum _ ->
                            Nothing

                        Radix.Internal.Literal literal ->
                            Just ( "--right", literal )
                )
                layout.right
            , Maybe.andThen
                (\bottom ->
                    case bottom of
                        Radix.Internal.Enum _ ->
                            Nothing

                        Radix.Internal.Literal literal ->
                            Just ( "--bottom", literal )
                )
                layout.bottom
            , Maybe.andThen
                (\left ->
                    case left of
                        Radix.Internal.Enum _ ->
                            Nothing

                        Radix.Internal.Literal literal ->
                            Just ( "--left", literal )
                )
                layout.left
            , Maybe.map
                (\flexBasis -> ( "--flex-basis", flexBasis ))
                layout.flexBasis
            , Maybe.andThen
                (\flexShrink ->
                    case flexShrink of
                        Radix.Internal.Enum _ ->
                            Nothing

                        Radix.Internal.Literal literal ->
                            Just ( "--flex-shrink", literal )
                )
                layout.flexShrink
            , Maybe.andThen
                (\flexGrow ->
                    case flexGrow of
                        Radix.Internal.Enum _ ->
                            Nothing

                        Radix.Internal.Literal literal ->
                            Just ( "--flex-grow", literal )
                )
                layout.flexGrow
            , Maybe.andThen
                (\gridColumn ->
                    case gridColumn of
                        Radix.Internal.Enum _ ->
                            Nothing

                        Radix.Internal.Literal literal ->
                            Just ( "--grid-column", literal )
                )
                layout.gridColumn
            , Maybe.andThen
                (\gridColumnStart ->
                    case gridColumnStart of
                        Radix.Internal.Enum _ ->
                            Nothing

                        Radix.Internal.Literal literal ->
                            Just ( "--grid-column-start", literal )
                )
                layout.gridColumnStart
            , Maybe.andThen
                (\gridColumnEnd ->
                    case gridColumnEnd of
                        Radix.Internal.Enum _ ->
                            Nothing

                        Radix.Internal.Literal literal ->
                            Just ( "--grid-column-end", literal )
                )
                layout.gridColumnEnd
            , Maybe.andThen
                (\gridRow ->
                    case gridRow of
                        Radix.Internal.Enum _ ->
                            Nothing

                        Radix.Internal.Literal literal ->
                            Just ( "--grid-row", literal )
                )
                layout.gridRow
            , Maybe.andThen
                (\gridRowStart ->
                    case gridRowStart of
                        Radix.Internal.Enum _ ->
                            Nothing

                        Radix.Internal.Literal literal ->
                            Just ( "--grid-row-start", literal )
                )
                layout.gridRowStart
            , Maybe.andThen
                (\gridRowEnd ->
                    case gridRowEnd of
                        Radix.Internal.Enum _ ->
                            Nothing

                        Radix.Internal.Literal literal ->
                            Just ( "--grid-row-end", literal )
                )
                layout.gridRowEnd
            ]
            ++ paddingStyles
    , otherAttributes = []
    }



-- HELPERS


paddingToClassesAndStyles :
    { top : Maybe Radix.Internal.EnumOrLiteral
    , right : Maybe Radix.Internal.EnumOrLiteral
    , bottom : Maybe Radix.Internal.EnumOrLiteral
    , left : Maybe Radix.Internal.EnumOrLiteral
    }
    ->
        ( List ( String, Bool )
        , List ( String, String )
        )
paddingToClassesAndStyles padding =
    case ( ( padding.top, padding.bottom ), ( padding.right, padding.left ) ) of
        ( ( Nothing, Nothing ), ( Nothing, Nothing ) ) ->
            ( [], [] )

        ( ( Just top, Just bottom ), ( Just right, Just left ) ) ->
            if top == bottom && right == left && top == right then
                case top of
                    Radix.Internal.Enum scale ->
                        ( [ ( "rt-r-p-" ++ String.fromInt scale, True ) ]
                        , []
                        )

                    Radix.Internal.Literal literal ->
                        ( [ ( "rt-p", True ) ]
                        , [ ( "--p", literal ) ]
                        )

            else
                let
                    ( yClasses, yStyles ) =
                        doTopBottomPadding padding.top padding.bottom

                    ( xClasses, xStyles ) =
                        doRightLeftPadding padding.right padding.left
                in
                ( yClasses ++ xClasses, yStyles ++ xStyles )

        ( ( top, bottom ), ( right, left ) ) ->
            let
                ( yClasses, yStyles ) =
                    doTopBottomPadding top bottom

                ( xClasses, xStyles ) =
                    doRightLeftPadding right left
            in
            ( yClasses ++ xClasses, yStyles ++ xStyles )


doTopBottomPadding : Maybe Radix.Internal.EnumOrLiteral -> Maybe Radix.Internal.EnumOrLiteral -> ( List ( String, Bool ), List ( String, String ) )
doTopBottomPadding maybeTop maybeBottom =
    case ( maybeTop, maybeBottom ) of
        ( Just top, Just bottom ) ->
            if top == bottom then
                case top of
                    Radix.Internal.Enum scale ->
                        ( [ ( "rt-r-py-" ++ String.fromInt scale, True ) ], [] )

                    Radix.Internal.Literal literal ->
                        ( [ ( "rt-r-py", True ) ]
                        , [ ( "--pt", literal )
                          , ( "--pb", literal )
                          ]
                        )

            else
                let
                    ( topClasses, topStyles ) =
                        case top of
                            Radix.Internal.Enum scale ->
                                ( [ ( "rt-r-pt-" ++ String.fromInt scale, True ) ], [] )

                            Radix.Internal.Literal literal ->
                                ( [ ( "rt-r-pt", True ) ]
                                , [ ( "--pt", literal ) ]
                                )

                    ( bottomClasses, bottomStyles ) =
                        case bottom of
                            Radix.Internal.Enum scale ->
                                ( [ ( "rt-r-pb-" ++ String.fromInt scale, True ) ], [] )

                            Radix.Internal.Literal literal ->
                                ( [ ( "rt-r-pb", True ) ]
                                , [ ( "--pb", literal ) ]
                                )
                in
                ( topClasses ++ bottomClasses, topStyles ++ bottomStyles )

        ( Just top, Nothing ) ->
            case top of
                Radix.Internal.Enum scale ->
                    ( [ ( "rt-r-py-" ++ String.fromInt scale, True ) ], [] )

                Radix.Internal.Literal literal ->
                    ( [ ( "rt-r-py", True ) ]
                    , [ ( "--pt", literal )
                      , ( "--pb", literal )
                      ]
                    )

        ( Nothing, Just bottom ) ->
            case bottom of
                Radix.Internal.Enum scale ->
                    ( [ ( "rt-r-pb-" ++ String.fromInt scale, True ) ], [] )

                Radix.Internal.Literal literal ->
                    ( [ ( "rt-r-pb", True ) ]
                    , [ ( "--pb", literal ) ]
                    )

        ( Nothing, Nothing ) ->
            ( [], [] )


doRightLeftPadding : Maybe Radix.Internal.EnumOrLiteral -> Maybe Radix.Internal.EnumOrLiteral -> ( List ( String, Bool ), List ( String, String ) )
doRightLeftPadding mayebRight maybeLeft =
    case ( mayebRight, maybeLeft ) of
        ( Just right, Just left ) ->
            if right == left then
                case right of
                    Radix.Internal.Enum scale ->
                        ( [ ( "rt-r-px-" ++ String.fromInt scale, True ) ], [] )

                    Radix.Internal.Literal literal ->
                        ( [ ( "rt-r-px", True ) ]
                        , [ ( "--pl", literal )
                          , ( "--pr", literal )
                          ]
                        )

            else
                let
                    ( rightClasses, rightStyles ) =
                        case right of
                            Radix.Internal.Enum scale ->
                                ( [ ( "rt-r-pr-" ++ String.fromInt scale, True ) ], [] )

                            Radix.Internal.Literal literal ->
                                ( [ ( "rt-r-pr", True ) ]
                                , [ ( "--pr", literal ) ]
                                )

                    ( leftClasses, leftStyles ) =
                        case left of
                            Radix.Internal.Enum scale ->
                                ( [ ( "rt-r-pl-" ++ String.fromInt scale, True ) ], [] )

                            Radix.Internal.Literal literal ->
                                ( [ ( "rt-r-pl", True ) ]
                                , [ ( "--pl", literal ) ]
                                )
                in
                ( rightClasses ++ leftClasses, rightStyles ++ leftStyles )

        ( Just right, Nothing ) ->
            case right of
                Radix.Internal.Enum scale ->
                    ( [ ( "rt-r-pr-" ++ String.fromInt scale, True ) ], [] )

                Radix.Internal.Literal literal ->
                    ( [ ( "rt-r-pr", True ) ]
                    , [ ( "--pr", literal ) ]
                    )

        ( Nothing, Just left ) ->
            case left of
                Radix.Internal.Enum scale ->
                    ( [ ( "rt-r-pl-" ++ String.fromInt scale, True ) ], [] )

                Radix.Internal.Literal literal ->
                    ( [ ( "rt-r-pl", True ) ]
                    , [ ( "--pl", literal ) ]
                    )

        ( Nothing, Nothing ) ->
            ( [], [] )
