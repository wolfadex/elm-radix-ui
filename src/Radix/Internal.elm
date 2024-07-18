module Radix.Internal exposing (..)

import Bitwise
import Html
import Html.Attributes
import Random


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


maybeElse : Maybe a -> Maybe a -> Maybe a
maybeElse maybeB maybeA =
    case maybeA of
        Just _ ->
            maybeA

        Nothing ->
            maybeB



{-
   UUID Generation

   Borrowed roughly form https://github.com/TSFoster/elm-uuid/blob/4.2.0/src/UUID.elm
-}


type Uuid
    = Uuid Int Int Int Int


generateUuid : Random.Generator String
generateUuid =
    Random.map4 Uuid randomU32 randomU32 randomU32 randomU32
        |> Random.map (toVersion 4 >> toVariant1 >> uuidToString)


randomU32 : Random.Generator Int
randomU32 =
    Random.int Random.minInt Random.maxInt
        |> Random.map forceUnsigned


forceUnsigned : Int -> Int
forceUnsigned =
    Bitwise.shiftRightZfBy 0


toVersion : Int -> Uuid -> Uuid
toVersion v (Uuid a b c d) =
    Uuid a (Bitwise.or (Bitwise.shiftLeftBy 12 v) (Bitwise.and 0xFFFF0FFF b) |> forceUnsigned) c d


toVariant1 : Uuid -> Uuid
toVariant1 (Uuid a b c d) =
    Uuid a b (Bitwise.or 0x80000000 (Bitwise.and 0x3FFFFFFF c) |> forceUnsigned) d


uuidToString : Uuid -> String
uuidToString (Uuid a b c d) =
    String.padLeft 8 '0' (toHex [] a)
        ++ "-"
        ++ String.padLeft 4 '0' (toHex [] (Bitwise.shiftRightZfBy 16 b))
        ++ "-"
        ++ String.padLeft 4 '0' (toHex [] (Bitwise.and 0xFFFF b))
        ++ "-"
        ++ String.padLeft 4 '0' (toHex [] (Bitwise.shiftRightZfBy 16 c))
        ++ "-"
        ++ String.padLeft 4 '0' (toHex [] (Bitwise.and 0xFFFF c))
        ++ String.padLeft 8 '0' (toHex [] d)


toHex : List Char -> Int -> String
toHex acc int =
    if int == 0 then
        String.fromList acc

    else
        let
            char =
                case Bitwise.and 0x0F int of
                    0x00 ->
                        '0'

                    0x01 ->
                        '1'

                    0x02 ->
                        '2'

                    0x03 ->
                        '3'

                    0x04 ->
                        '4'

                    0x05 ->
                        '5'

                    0x06 ->
                        '6'

                    0x07 ->
                        '7'

                    0x08 ->
                        '8'

                    0x09 ->
                        '9'

                    0x0A ->
                        'a'

                    0x0B ->
                        'b'

                    0x0C ->
                        'c'

                    0x0D ->
                        'd'

                    0x0E ->
                        'e'

                    _ ->
                        'f'
        in
        toHex (char :: acc) (Bitwise.shiftRightZfBy 4 int)
