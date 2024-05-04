module Radix.Section exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal
import Radix.Layout


type Config msg
    = Config
        { content : List (Html msg)
        , node : String
        , size : Int
        , display : Maybe Radix.Display
        , layout : Radix.Layout.Layout

        --
        , customClassList : List ( String, Bool )
        , customStyles : List ( String, String )
        , customAttributes : List (Html.Attribute msg)
        }


new : List (Html msg) -> Config msg
new content =
    Config
        { content = content
        , node = "div"
        , size = 3
        , display = Nothing
        , layout = Radix.Layout.empty

        --
        , customClassList = []
        , customStyles = []
        , customAttributes = []
        }



-- MODIFIERS


asSpan : Config msg -> Config msg
asSpan (Config config) =
    Config
        { config
            | node = "span"
        }


withDisplay : Radix.Display -> Config msg -> Config msg
withDisplay display (Config config) =
    Config
        { config
            | display = Just display
        }



-- LAYOUT


withPaddingScale : Int -> Config msg -> Config msg
withPaddingScale scale =
    withLayout
        (Radix.Layout.withPaddingScale scale)


withPaddingLiteral : String -> Config msg -> Config msg
withPaddingLiteral padding =
    withLayout
        (Radix.Layout.withPaddingLiteral padding)


withPaddingXScale : Int -> Config msg -> Config msg
withPaddingXScale scale =
    withLayout
        (Radix.Layout.withPaddingXScale scale)


withPaddingXLiteral : String -> Config msg -> Config msg
withPaddingXLiteral literal =
    withLayout
        (Radix.Layout.withPaddingXLiteral literal)


withPaddingYScale : Int -> Config msg -> Config msg
withPaddingYScale scale =
    withLayout
        (Radix.Layout.withPaddingYScale scale)


withPaddingYLiteral : String -> Config msg -> Config msg
withPaddingYLiteral literal =
    withLayout
        (Radix.Layout.withPaddingYLiteral literal)


withPaddingTopScale : Int -> Config msg -> Config msg
withPaddingTopScale scale =
    withLayout
        (Radix.Layout.withPaddingTopScale scale)


withPaddingTopLiteral : String -> Config msg -> Config msg
withPaddingTopLiteral literal =
    withLayout
        (Radix.Layout.withPaddingTopLiteral literal)


withPaddingRightScale : Int -> Config msg -> Config msg
withPaddingRightScale scale =
    withLayout
        (Radix.Layout.withPaddingRightScale scale)


withPaddingRightLiteral : String -> Config msg -> Config msg
withPaddingRightLiteral literal =
    withLayout
        (Radix.Layout.withPaddingRightLiteral literal)


withPaddingBottomScale : Int -> Config msg -> Config msg
withPaddingBottomScale scale =
    withLayout
        (Radix.Layout.withPaddingBottomScale scale)


withPaddingBottomLiteral : String -> Config msg -> Config msg
withPaddingBottomLiteral literal =
    withLayout
        (Radix.Layout.withPaddingBottomLiteral literal)


withPaddingLeftScale : Int -> Config msg -> Config msg
withPaddingLeftScale scale =
    withLayout
        (Radix.Layout.withPaddingLeftScale scale)


withPaddingLeftLiteral : String -> Config msg -> Config msg
withPaddingLeftLiteral literal =
    withLayout
        (Radix.Layout.withPaddingLeftLiteral literal)


withWidth : String -> Config msg -> Config msg
withWidth width =
    withLayout
        (Radix.Layout.withWidth width)


withMinWidth : String -> Config msg -> Config msg
withMinWidth minWidth =
    withLayout
        (Radix.Layout.withMinWidth minWidth)


withMaxWidth : String -> Config msg -> Config msg
withMaxWidth maxWidth =
    withLayout
        (Radix.Layout.withMaxWidth maxWidth)


withHeight : String -> Config msg -> Config msg
withHeight height =
    withLayout
        (Radix.Layout.withHeight height)


withMinHeight : String -> Config msg -> Config msg
withMinHeight minHeight =
    withLayout
        (Radix.Layout.withMinHeight minHeight)


withMaxHeight : String -> Config msg -> Config msg
withMaxHeight maxHeight =
    withLayout
        (Radix.Layout.withMaxHeight maxHeight)


withPosition : Radix.Position -> Config msg -> Config msg
withPosition position =
    withLayout
        (Radix.Layout.withPosition position)


withInsetScale : Int -> Config msg -> Config msg
withInsetScale scale =
    withLayout (Radix.Layout.withInsetScale scale)


withInsetLiteral : String -> Config msg -> Config msg
withInsetLiteral literal =
    withLayout (Radix.Layout.withInsetLiteral literal)


withTopScale : Int -> Config msg -> Config msg
withTopScale scale =
    withLayout
        (Radix.Layout.withTopScale scale)


withTopLiteral : String -> Config msg -> Config msg
withTopLiteral literal =
    withLayout
        (Radix.Layout.withTopLiteral literal)


withRightScale : Int -> Config msg -> Config msg
withRightScale scale =
    withLayout
        (Radix.Layout.withRightScale scale)


withRightLiteral : String -> Config msg -> Config msg
withRightLiteral literal =
    withLayout
        (Radix.Layout.withRightLiteral literal)


withBottomScale : Int -> Config msg -> Config msg
withBottomScale scale =
    withLayout
        (Radix.Layout.withBottomScale scale)


withBottomLiteral : String -> Config msg -> Config msg
withBottomLiteral literal =
    withLayout
        (Radix.Layout.withBottomLiteral literal)


withLeftScale : Int -> Config msg -> Config msg
withLeftScale scale =
    withLayout
        (Radix.Layout.withLeftScale scale)


withLeftLiteral : String -> Config msg -> Config msg
withLeftLiteral literal =
    withLayout
        (Radix.Layout.withLeftLiteral literal)


withOverflow : Radix.Layout.Overflow -> Config msg -> Config msg
withOverflow overflow =
    withLayout
        (Radix.Layout.withOverflow overflow)


withOverflowX : Radix.Layout.Overflow -> Config msg -> Config msg
withOverflowX overflow =
    withLayout
        (Radix.Layout.withOverflowX overflow)


withOverflowY : Radix.Layout.Overflow -> Config msg -> Config msg
withOverflowY overflow =
    withLayout
        (Radix.Layout.withOverflowX overflow)


withFlexBasis : String -> Config msg -> Config msg
withFlexBasis flexBasis =
    withLayout
        (Radix.Layout.withFlexBasis flexBasis)


withFlexShrink1 : Config msg -> Config msg
withFlexShrink1 =
    withLayout
        Radix.Layout.withFlexShrink1


withFlexShrink0 : Config msg -> Config msg
withFlexShrink0 =
    withLayout
        Radix.Layout.withFlexShrink0


withFlexShrinkLiteral : String -> Config msg -> Config msg
withFlexShrinkLiteral literal =
    withLayout
        (Radix.Layout.withFlexShrinkLiteral literal)


withFlexGrow1 : Config msg -> Config msg
withFlexGrow1 =
    withLayout
        Radix.Layout.withFlexGrow1


withFlexGrow0 : Config msg -> Config msg
withFlexGrow0 =
    withLayout
        Radix.Layout.withFlexGrow0


withFlexGrowLiteral : String -> Config msg -> Config msg
withFlexGrowLiteral literal =
    withLayout
        (Radix.Layout.withFlexGrowLiteral literal)


withGridColumnScale : Int -> Config msg -> Config msg
withGridColumnScale scale =
    withLayout
        (Radix.Layout.withGridColumnScale scale)


withGridColumnLiteral : String -> Config msg -> Config msg
withGridColumnLiteral literal =
    withLayout
        (Radix.Layout.withGridColumnLiteral literal)


withGridColumnStartScale : Int -> Config msg -> Config msg
withGridColumnStartScale scale =
    withLayout
        (Radix.Layout.withGridColumnStartScale scale)


withGridColumnStartLiteral : String -> Config msg -> Config msg
withGridColumnStartLiteral literal =
    withLayout
        (Radix.Layout.withGridColumnStartLiteral literal)


withGridColumnEndScale : Int -> Config msg -> Config msg
withGridColumnEndScale scale =
    withLayout
        (Radix.Layout.withGridColumnEndScale scale)


withGridColumnEndLiteral : String -> Config msg -> Config msg
withGridColumnEndLiteral literal =
    withLayout
        (Radix.Layout.withGridColumnEndLiteral literal)


withGridRowScale : Int -> Config msg -> Config msg
withGridRowScale scale =
    withLayout
        (Radix.Layout.withGridRowScale scale)


withGridRowLiteral : String -> Config msg -> Config msg
withGridRowLiteral literal =
    withLayout
        (Radix.Layout.withGridRowLiteral literal)


withGridRowStartScale : Int -> Config msg -> Config msg
withGridRowStartScale scale =
    withLayout
        (Radix.Layout.withGridRowStartScale scale)


withGridRowStartLiteral : String -> Config msg -> Config msg
withGridRowStartLiteral literal =
    withLayout
        (Radix.Layout.withGridRowStartLiteral literal)


withGridRowEndScale : Int -> Config msg -> Config msg
withGridRowEndScale scale =
    withLayout
        (Radix.Layout.withGridRowEndScale scale)


withGridRowEndLiteral : String -> Config msg -> Config msg
withGridRowEndLiteral literal =
    withLayout
        (Radix.Layout.withGridRowEndLiteral literal)


withCustomClassList : List ( String, Bool ) -> Config msg -> Config msg
withCustomClassList customClassList (Config config) =
    Config
        { config
            | customClassList = customClassList
        }


withCustomStyles : List ( String, String ) -> Config msg -> Config msg
withCustomStyles customStyles (Config config) =
    Config
        { config
            | customStyles = customStyles
        }


withCustomAttributes : List (Html.Attribute msg) -> Config msg -> Config msg
withCustomAttributes customAttributes (Config config) =
    Config
        { config
            | customAttributes = customAttributes
        }


withSize1 : Config msg -> Config msg
withSize1 (Config config) =
    Config
        { config
            | size = 1
        }


withSize2 : Config msg -> Config msg
withSize2 (Config config) =
    Config
        { config
            | size = 2
        }


withSize4 : Config msg -> Config msg
withSize4 (Config config) =
    Config
        { config
            | size = 4
        }



-- VIEW


view : Config msg -> Html msg
view (Config config) =
    let
        layoutAttributes =
            Radix.Layout.toAttributes config.layout
    in
    Html.node config.node
        ([ Html.Attributes.classList
            ([ ( "rt-Section", True )
             , ( "rt-r-size-" ++ String.fromInt config.size, True )
             , Radix.Internal.classListMaybe
                Radix.displayToCss
                config.display
             ]
                ++ layoutAttributes.classes
                ++ config.customClassList
            )
         , Radix.Internal.styles
            (List.filterMap identity
                []
                ++ layoutAttributes.styles
                ++ config.customStyles
            )
         ]
            ++ layoutAttributes.otherAttributes
            ++ config.customAttributes
        )
        config.content



-- HELPERS


withLayout : (Radix.Layout.Layout -> Radix.Layout.Layout) -> Config msg -> Config msg
withLayout f (Config config) =
    Config
        { config
            | layout = f config.layout
        }
