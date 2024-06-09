module Radix.Table exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix



-- CONFIG


type Config data msg
    = Config
        { size : Size
        , variant : Variant
        , layout : Maybe Layout
        , data : List data
        , columns :
            List
                { header : Html msg
                , cell : data -> Html msg
                }

        --
        , customClassList : List ( String, Bool )
        , customStyles : List ( String, String )
        , customAttributes : List (Html.Attribute msg)
        }



-- OPTIONS


type Size
    = Size1
    | Size2
    | Size3


sizeToCss : Size -> String
sizeToCss size =
    "rt-r-size-"
        ++ (case size of
                Size1 ->
                    "1"

                Size2 ->
                    "2"

                Size3 ->
                    "3"
           )


withSize1 : Config data msg -> Config data msg
withSize1 (Config config) =
    Config { config | size = Size1 }


withSize3 : Config data msg -> Config data msg
withSize3 (Config config) =
    Config { config | size = Size3 }


type Variant
    = Surface
    | Ghost


variantToCss : Variant -> String
variantToCss variant =
    "rt-variant-"
        ++ (case variant of
                Ghost ->
                    "ghost"

                Surface ->
                    "surface"
           )


withVariantSurface : Config data msg -> Config data msg
withVariantSurface (Config config) =
    Config
        { config
            | variant = Surface
        }


type Layout
    = Auto
    | Fixed


withLayoutAuto : Config data msg -> Config data msg
withLayoutAuto (Config config) =
    Config { config | layout = Just Auto }


withLayoutFixed : Config data msg -> Config data msg
withLayoutFixed (Config config) =
    Config { config | layout = Just Fixed }


withCustomClassList : List ( String, Bool ) -> Config data msg -> Config data msg
withCustomClassList customClassList (Config config) =
    Config
        { config
            | customClassList = customClassList
        }


withCustomStyles : List ( String, String ) -> Config data msg -> Config data msg
withCustomStyles customStyles (Config config) =
    Config
        { config
            | customStyles = customStyles
        }


withCustomAttributes : List (Html.Attribute msg) -> Config data msg -> Config data msg
withCustomAttributes customAttributes (Config config) =
    Config
        { config
            | customAttributes = customAttributes
        }



-- CREATE


new :
    { data : List data
    , columns :
        List
            { header : Html msg
            , cell : data -> Html msg
            }
    }
    -> Config data msg
new options =
    Config
        { size = Size2
        , variant = Ghost
        , layout = Nothing
        , data = options.data
        , columns = options.columns

        --
        , customClassList = []
        , customStyles = []
        , customAttributes = []
        }



-- VIEW


view : Config data msg -> Html msg
view (Config config) =
    -- <div class="rt-TableRoot rt-r-size-2 rt-variant-ghost">
    --   <div dir="ltr" class="rt-ScrollAreaRoot" style="position: relative; --radix-scroll-area-corner-width: 0px; --radix-scroll-area-corner-height: 0px;">
    --     <style>[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}</style>
    --     <div data-radix-scroll-area-viewport="" class="rt-ScrollAreaViewport" style="overflow: scroll;">
    --       <div style="min-width: 100%; display: table;">
    --         TABLE GOES HERE
    --       </div>
    --     </div>
    --     <div class="rt-ScrollAreaViewportFocusRing"></div>
    --   </div>
    -- </div>
    Html.div
        [ Html.Attributes.classList
            [ ( "rt-TableRoot", True )
            , ( sizeToCss config.size, True )
            , ( variantToCss config.variant, True )
            ]
        ]
        [ -- TODO: add scoll area support???
          Html.table
            ([ Html.Attributes.classList
                (( "rt-TableRootTable", True )
                    :: config.customClassList
                )
             , Radix.styles config.customStyles
             ]
                ++ config.customAttributes
            )
            [ Html.thead
                [ Html.Attributes.class "rt-TableHeader"
                ]
                [ Html.tr
                    [ Html.Attributes.class "rt-TableRow" ]
                    (List.map
                        (\column ->
                            Html.th
                                [ Html.Attributes.class "rt-TableCell  rt-TableColumnHeaderCell"
                                , Html.Attributes.scope "col"
                                ]
                                [ column.header ]
                        )
                        config.columns
                    )
                ]
            , Html.tbody
                [ Html.Attributes.class "rt-TableBody"
                ]
                (List.map
                    (\rowData ->
                        Html.tr
                            [ Html.Attributes.class "rt-TableRow" ]
                            (List.indexedMap
                                (\index column ->
                                    let
                                        content =
                                            column.cell rowData
                                    in
                                    if index == 0 then
                                        Html.th
                                            [ Html.Attributes.class "rt-TableCell rt-TableRowHeaderCell"
                                            , Html.Attributes.scope "row"
                                            ]
                                            [ content ]

                                    else
                                        Html.td
                                            [ Html.Attributes.class "rt-TableCell"
                                            ]
                                            [ content ]
                                )
                                config.columns
                            )
                    )
                    config.data
                )
            ]
        ]
