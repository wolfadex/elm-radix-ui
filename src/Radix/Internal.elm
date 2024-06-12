module Radix.Internal exposing (..)

import Html
import Html.Attributes


type EnumOrLiteral
    = Enum Int
    | Literal String


attributeIf : Bool -> Html.Attribute msg -> Html.Attribute msg
attributeIf condition attribute =
    if condition then
        attribute

    else
        Html.Attributes.class ""


attributeMaybe : (a -> Html.Attribute msg) -> Maybe a -> Html.Attribute msg
attributeMaybe attribute maybeValue =
    case maybeValue of
        Just value ->
            attribute value

        Nothing ->
            Html.Attributes.class ""


classListMaybe : (a -> String) -> Maybe a -> ( String, Bool )
classListMaybe f maybe =
    case maybe of
        Nothing ->
            ( "", False )

        Just a ->
            ( f a, True )


applyMaybe : (a -> b -> b) -> Maybe a -> b -> b
applyMaybe fn maybeA b =
    case maybeA of
        Nothing ->
            b

        Just a ->
            fn a b
