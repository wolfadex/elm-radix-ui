module Radix.Modal exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode
import Radix
import Radix.Internal


type Config msg
    = Config
        { open : Bool
        , onClose : msg
        , content : List (Html msg)
        , size : Int
        , width : Maybe String
        , minWidth : Maybe String
        , maxWidth : String
        , style : Style

        --
        , customClassList : List ( String, Bool )
        , customStyles : List ( String, String )
        , customAttributes : List (Html.Attribute msg)
        }


new :
    { open : Bool
    , onClose : msg
    , content : List (Html msg)
    }
    -> Config msg
new options =
    Config
        { open = options.open
        , onClose = options.onClose
        , content = options.content
        , size = 3
        , width = Nothing
        , minWidth = Nothing
        , maxWidth = "600px"
        , style = PlainModal

        --
        , customClassList = []
        , customStyles = []
        , customAttributes = []
        }


withSize1 : Config msg -> Config msg
withSize1 (Config config) =
    Config { config | size = 1 }


withSize2 : Config msg -> Config msg
withSize2 (Config config) =
    Config { config | size = 2 }


withSize4 : Config msg -> Config msg
withSize4 (Config config) =
    Config { config | size = 4 }


withWidth : String -> Config msg -> Config msg
withWidth width (Config config) =
    Config { config | width = Just width }


withMinWidth : String -> Config msg -> Config msg
withMinWidth minWidth (Config config) =
    Config { config | minWidth = Just minWidth }


withMaxWidth : String -> Config msg -> Config msg
withMaxWidth maxWidth (Config config) =
    Config { config | maxWidth = maxWidth }


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


type Style
    = PlainModal
    | AlertDialogModal


asAlertDialog : Config msg -> Config msg
asAlertDialog (Config config) =
    Config { config | style = AlertDialogModal }


view : Config msg -> Html msg
view (Config config) =
    Html.node "dialog"
        ([ Html.Attributes.property "___elm-radix-ui-open" (Json.Encode.bool config.open)
         , Html.Attributes.attribute "data-state" <|
            if config.open then
                "open"

            else
                "closed"
         , Html.Events.on "close" (closeDecoder config.onClose)
         , Radix.Internal.attributeIf (config.style == AlertDialogModal)
            (Html.Attributes.attribute "role" "alertdialog")
         , Html.Attributes.classList
            ([ ( "rt-BaseDialogContent", True )
             , ( "rt-BaseDialogContent-overrides", True )
             , ( "rt-DialogContent", config.style == PlainModal )
             , ( "rt-AlertDialogContent", config.style == AlertDialogModal )
             , ( "rt-r-size-" ++ String.fromInt config.size, True )
             , ( "rt-r-w", config.width /= Nothing )
             , ( "rt-r-min-w", config.minWidth /= Nothing )
             , ( "rt-r-max-w", True )
             ]
                ++ config.customClassList
            )
         , Radix.styles
            (List.filterMap identity
                [ Maybe.map
                    (\width -> ( "--width", width ))
                    config.width
                , Maybe.map
                    (\minWidth -> ( "--min-width", minWidth ))
                    config.minWidth
                , Just ( "--max-width", config.maxWidth )
                ]
                ++ config.customStyles
            )
         ]
            ++ config.customAttributes
        )
        config.content


closeDecoder : msg -> Json.Decode.Decoder msg
closeDecoder msg =
    Json.Decode.succeed msg
