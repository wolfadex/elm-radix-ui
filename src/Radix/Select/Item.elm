module Radix.Select.Item exposing
    ( Config
    , newItem, newGroup, separator
    , view
    , withIsDisabled
    , findFirst, findNext, findPrevious
    , filterToValues
    )

{-|


## Create

@docs Config
@docs newItem, newGroup, separator


## View

@docs view


## Modify

@docs withIsDisabled


## Internal Helpers

@docs findFirst, findNext, findPrevious
@docs filterToValues

-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode
import Radix.Icon
import Radix.Internal


type Config item msg
    = Config (Internal item msg)


type Internal item msg
    = Separator
    | Group { label : String, children : List (Config item msg) }
    | Item
        { value : item
        , isDisabled : Bool
        }


separator : Config item msg
separator =
    Config Separator


newGroup : { label : String, items : List (Config item msg) } -> Config item msg
newGroup options =
    Config
        (Group
            { label = options.label
            , children = options.items
            }
        )


newItem : { value : item } -> Config item msg
newItem options =
    Config
        (Item
            { value = options.value
            , isDisabled = False
            }
        )


withIsDisabled : Config item msg -> Config item msg
withIsDisabled (Config internal) =
    Config
        (case internal of
            Separator ->
                Separator

            Item details ->
                Item { details | isDisabled = True }

            Group details ->
                Group { details | children = List.map withIsDisabled details.children }
        )


view :
    { currentValue : Maybe item
    , itemToString : item -> String
    , onSelect : item -> msg
    , focused : Maybe item
    , onHovered : item -> msg
    , onUnhovered : msg
    }
    -> Config item msg
    -> Html msg
view options (Config internal) =
    --       <div role="group" aria-labelledby="radix-:r22q:" class="rt-SelectGroup">
    --         <div id="radix-:r22q:" class="rt-SelectLabel">Fruits</div>
    --         <div role="option" aria-labelledby="radix-:r22r:" aria-selected="false" data-state="unchecked" tabindex="-1" class="rt-SelectItem" data-radix-collection-item="">
    --           <span id="radix-:r22r:">Orange</span>
    --         </div>
    --       </div>
    case internal of
        Separator ->
            --       <div aria-hidden="true" class="rt-SelectSeparator"></div>
            Html.div
                [ Html.Attributes.attribute "aria-hidden" "true"
                , Html.Attributes.class "rt-SelectSeparator"
                ]
                []

        Group details ->
            --       <div role="group" aria-labelledby="radix-:r22u:" class="rt-SelectGroup">
            --         <div id="radix-:r22u:" class="rt-SelectLabel">Vegetables</div>
            --         <div role="option" aria-labelledby="radix-:r22v:" aria-selected="false" data-state="unchecked" tabindex="-1" class="rt-SelectItem" data-radix-collection-item="">
            --           <span id="radix-:r22v:">Carrot</span>
            --         </div>
            --         <div role="option" aria-labelledby="radix-:r230:" aria-selected="false" data-state="unchecked" tabindex="-1" class="rt-SelectItem" data-radix-collection-item="">
            --           <span id="radix-:r230:">Potato</span>
            --         </div>
            --       </div>
            Html.div
                [ Html.Attributes.attribute "role" "group"
                , Html.Attributes.class "rt-SelectGroup"
                ]
                (Html.div
                    [ Html.Attributes.class "rt-SelectLabel" ]
                    [ Html.text details.label ]
                    :: List.map (view options) details.children
                )

        Item details ->
            --         <div  tabindex="-1" data-highlighted="">
            --           <span aria-hidden="true" class="rt-SelectItemIndicator">
            --             <svg width="9" height="9" viewBox="0 0 9 9" fill="currentcolor" xmlns="http://www.w3.org/2000/svg" class="rt-SelectItemIndicatorIcon"><path fill-rule="evenodd" clip-rule="evenodd" d="M8.53547 0.62293C8.88226 0.849446 8.97976 1.3142 8.75325 1.66099L4.5083 8.1599C4.38833 8.34356 4.19397 8.4655 3.9764 8.49358C3.75883 8.52167 3.53987 8.45309 3.3772 8.30591L0.616113 5.80777C0.308959 5.52987 0.285246 5.05559 0.563148 4.74844C0.84105 4.44128 1.31533 4.41757 1.62249 4.69547L3.73256 6.60459L7.49741 0.840706C7.72393 0.493916 8.18868 0.396414 8.53547 0.62293Z"></path></svg>
            --           </span>
            --           <span id="radix-:r22s:">Apple</span>
            --         </div>
            --         <div  aria-disabled="true" data-disabled="">
            --           <span id="radix-:r22t:">Grape</span>
            --         </div>
            Html.div
                [ Html.Attributes.attribute "role" "option"
                , Html.Attributes.attribute "aria-selected" <|
                    if Just details.value == options.currentValue then
                        "true"

                    else
                        "false"
                , Html.Attributes.attribute "data-state" <|
                    if Just details.value == options.currentValue then
                        "checked"

                    else
                        "unchecked"
                , Radix.Internal.attributeIf details.isDisabled
                    (Html.Attributes.attribute "aria-disabled" "true")
                , Radix.Internal.attributeIf details.isDisabled
                    (Html.Attributes.attribute "data-disabled" "")
                , Html.Attributes.class "rt-SelectItem"
                , Html.Attributes.attribute "data-radix-collection-item" ""
                , Radix.Internal.attributeIf (Just details.value == options.focused)
                    (Html.Attributes.attribute "data-highlighted" "")

                -- Elm specific
                , Html.Events.onClick (options.onSelect details.value)
                , Html.Events.on "mouseenter" (Json.Decode.succeed (options.onHovered details.value))
                , Html.Events.on "mouseleave" (Json.Decode.succeed options.onUnhovered)
                , Html.Attributes.attribute "data-select-option-value" (options.itemToString details.value)
                ]
                [ if Just details.value == options.currentValue then
                    Html.span
                        [ Html.Attributes.attribute "aria-hidden" "true"
                        , Html.Attributes.class "rt-SelectItemIndicator"
                        ]
                        [ Radix.Icon.check
                            |> Radix.Icon.withCustomClassList
                                [ ( "rt-SelectItemIndicatorIcon", True )
                                ]
                            |> Radix.Icon.view
                        ]

                  else
                    Html.text ""
                , Html.span [] [ Html.text (options.itemToString details.value) ]
                ]



--


findFirst : List (Config item msg) -> Maybe item
findFirst list =
    case list of
        [] ->
            Nothing

        (Config next) :: rest ->
            case next of
                Separator ->
                    findFirst rest

                Group details ->
                    case findFirst details.children of
                        Just f ->
                            Just f

                        Nothing ->
                            findFirst rest

                Item details ->
                    if details.isDisabled then
                        findFirst rest

                    else
                        Just details.value


type Either item
    = Found item
    | NotFound Bool


findNext : item -> List (Config item msg) -> Maybe item
findNext current list =
    case findNextHelper False current (filterToValues list) of
        Found item ->
            Just item

        NotFound _ ->
            Nothing


findNextHelper : Bool -> item -> List item -> Either item
findNextHelper ignoreCurrent current list =
    case list of
        [] ->
            NotFound ignoreCurrent

        [ next ] ->
            if next == current then
                findNextHelper True current []

            else
                findNextHelper ignoreCurrent current []

        next :: following :: rest ->
            if ignoreCurrent then
                Found next

            else if next == current then
                Found following

            else
                findNextHelper ignoreCurrent current (following :: rest)


findPrevious : item -> List (Config item msg) -> Maybe item
findPrevious current list =
    case findNextHelper False current (List.reverse (filterToValues list)) of
        Found item ->
            Just item

        NotFound _ ->
            Nothing


filterToValues : List (Config item msg) -> List item
filterToValues =
    List.foldr
        (\(Config next) acc ->
            case next of
                Separator ->
                    acc

                Item details ->
                    if details.isDisabled then
                        acc

                    else
                        details.value :: acc

                Group details ->
                    filterToValues details.children ++ acc
        )
        []
