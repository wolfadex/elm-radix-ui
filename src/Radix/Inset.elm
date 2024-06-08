module Radix.Inset exposing (..)

import Html exposing (Html)
import Html.Attributes
import Radix
import Radix.Internal
import Radix.Text


type Config msg
    = Config
        { side : Side
        , clip : Clip
        , padding :
            { top : Maybe Padding
            , right : Maybe Padding
            , bottom : Maybe Padding
            , left : Maybe Padding
            }
        , children : List (Html msg)
        }


new : List (Html msg) -> Config msg
new children =
    Config
        { side = SideAll
        , clip = BorderBox
        , padding =
            { top = Nothing
            , right = Nothing
            , bottom = Nothing
            , left = Nothing
            }
        , children = children
        }


type Side
    = SideAll
    | SideX
    | SideY
    | SideTop
    | SideBottom
    | SideLeft
    | SideRight


sideToCss : Side -> String
sideToCss side =
    "rt-r-side-"
        ++ (case side of
                SideAll ->
                    "all"

                SideX ->
                    "x"

                SideY ->
                    "y"

                SideTop ->
                    "top"

                SideBottom ->
                    "bottom"

                SideLeft ->
                    "left"

                SideRight ->
                    "right"
           )


withSideX : Config msg -> Config msg
withSideX (Config config) =
    Config { config | side = SideX }


withSideY : Config msg -> Config msg
withSideY (Config config) =
    Config { config | side = SideY }


withSideTop : Config msg -> Config msg
withSideTop (Config config) =
    Config { config | side = SideTop }


withSideBottom : Config msg -> Config msg
withSideBottom (Config config) =
    Config { config | side = SideBottom }


withSideLeft : Config msg -> Config msg
withSideLeft (Config config) =
    Config { config | side = SideLeft }


withSideRight : Config msg -> Config msg
withSideRight (Config config) =
    Config { config | side = SideRight }


type Clip
    = BorderBox
    | PaddingBox


withClipPaddingBox : Config msg -> Config msg
withClipPaddingBox (Config config) =
    Config { config | clip = PaddingBox }


type Padding
    = CurrentPadding
    | NoPadding


withPadding : Padding -> Config msg -> Config msg
withPadding padding (Config config) =
    Config
        { config
            | padding =
                { top = Just padding
                , bottom = Just padding
                , left = Just padding
                , right = Just padding
                }
        }


withPaddingX : Padding -> Config msg -> Config msg
withPaddingX padding (Config config) =
    let
        pad =
            config.padding
    in
    Config
        { config
            | padding =
                { pad
                    | left = Just padding
                    , right = Just padding
                }
        }


withPaddingY : Padding -> Config msg -> Config msg
withPaddingY padding (Config config) =
    let
        pad =
            config.padding
    in
    Config
        { config
            | padding =
                { pad
                    | top = Just padding
                    , bottom = Just padding
                }
        }


withPaddingTop : Padding -> Config msg -> Config msg
withPaddingTop padding (Config config) =
    let
        pad =
            config.padding
    in
    Config
        { config
            | padding =
                { pad
                    | top = Just padding
                }
        }


withPaddingBottom : Padding -> Config msg -> Config msg
withPaddingBottom padding (Config config) =
    let
        pad =
            config.padding
    in
    Config
        { config
            | padding =
                { pad
                    | bottom = Just padding
                }
        }


withPaddingLeft : Padding -> Config msg -> Config msg
withPaddingLeft padding (Config config) =
    let
        pad =
            config.padding
    in
    Config
        { config
            | padding =
                { pad
                    | left = Just padding
                }
        }


withPaddingRight : Padding -> Config msg -> Config msg
withPaddingRight padding (Config config) =
    let
        pad =
            config.padding
    in
    Config
        { config
            | padding =
                { pad
                    | right = Just padding
                }
        }


view : Config msg -> Html msg
view (Config config) =
    -- TODO: Figure out padding attribute/style
    -- <div class=" rt-r-pb-inset">
    --   children
    -- </div>
    Html.div
        [ Html.Attributes.classList
            [ ( "rt-Inset", True )
            , ( sideToCss config.side, True )
            , ( case config.clip of
                    BorderBox ->
                        "rt-r-clip-border-box"

                    PaddingBox ->
                        "rt-r-clip-padding-box"
              , True
              )
            ]
        ]
        config.children
