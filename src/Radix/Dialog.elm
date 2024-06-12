module Radix.Dialog exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Radix
import Radix.Heading
import Radix.Internal
import Radix.Modal
import Radix.Text


type Config msg
    = Config
        { size : Size
        , width : Maybe String
        , minWidth : Maybe String
        , maxWidth : String
        , open : Bool
        , onClose : msg
        , title : Maybe String
        , description : List (Html msg)
        , body : List (Html msg)

        --
        , customClassList : List ( String, Bool )
        , customStyles : List ( String, String )
        , customAttributes : List (Html.Attribute msg)
        }


new :
    { open : Bool
    , onClose : msg
    , body : List (Html msg)
    }
    -> Config msg
new options =
    Config
        { size = Size3
        , width = Nothing
        , minWidth = Nothing
        , maxWidth = "600px"
        , open = options.open
        , onClose = options.onClose
        , title = Nothing
        , description = []
        , body = options.body

        --
        , customClassList = []
        , customStyles = []
        , customAttributes = []
        }


withTitle : String -> Config msg -> Config msg
withTitle title (Config config) =
    Config { config | title = Just title }


withDescription : List (Html msg) -> Config msg -> Config msg
withDescription description (Config config) =
    Config { config | description = description }


type Size
    = Size1
    | Size2
    | Size3
    | Size4


withSize1 : Config msg -> Config msg
withSize1 (Config config) =
    Config { config | size = Size1 }


withSize2 : Config msg -> Config msg
withSize2 (Config config) =
    Config { config | size = Size2 }


withSize4 : Config msg -> Config msg
withSize4 (Config config) =
    Config { config | size = Size4 }


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


view : Config msg -> Html msg
view (Config config) =
    -- <div
    --     role="dialog"
    --     id="radix-:r1mj:"
    --     aria-describedby="radix-:r1ml:"
    --     aria-labelledby="radix-:r1mk:"
    --     data-state="open"
    --     style="--max-width: 450px; pointer-events: auto;"
    --     class="rt-BaseDialogContent rt-DialogContent rt-r-size-3 rt-r-max-w"
    --     tabindex="-1"
    -- >
    --   <h1 id="radix-:r1mk:" class="rt-Heading rt-r-size-5 rt-r-lt-start rt-r-mb-3">Edit profile</h1>
    --   <p id="radix-:r1ml:" class="rt-Text rt-r-size-2 rt-r-mb-4">Make changes to your profile.</p>
    --   <div class="rt-Flex rt-r-fd-column rt-r-gap-3">
    --     <label>
    --       <div class="rt-Text rt-r-size-2 rt-r-weight-bold rt-r-mb-1">Name</div>
    --       <div class="rt-TextFieldRoot rt-r-size-2 rt-variant-surface">
    --         <input spellcheck="false" placeholder="Enter your full name" class="rt-reset rt-TextFieldInput" value="Freja Johnsen">
    --       </div>
    --     </label>
    --     <label>
    --       <div class="rt-Text rt-r-size-2 rt-r-weight-bold rt-r-mb-1">Email</div>
    --       <div class="rt-TextFieldRoot rt-r-size-2 rt-variant-surface">
    --         <input spellcheck="false" placeholder="Enter your email" class="rt-reset rt-TextFieldInput" value="freja@example.com" data-keeper-lock-id="k-de07xzagmvj">
    --         <div></div>
    --         <keeper-lock class="focus-visible logged-in" tabindex="-1" style="background-image: url(&quot;moz-extension://e44b850e-3e40-4a1d-9775-a3ca2a1219e6/images/ico-field-fill-lock.svg&quot;) !important; background-size: 24px 24px !important; cursor: pointer !important; width: 24px !important; position: absolute !important; opacity: 0 !important; margin-top: auto !important; min-width: 24px !important; top: 189.4px; left: 398px; z-index: 1; padding: 0px; height: 24px !important;" id="k-de07xzagmvj" aria-label="Open Keeper Popup" role="button"></keeper-lock>
    --       </div>
    --     </label>
    --   </div>
    --   <div class="rt-Flex rt-r-jc-end rt-r-gap-3 rt-r-mt-4">
    --     <button data-accent-color="gray" type="button" class="rt-reset rt-BaseButton rt-r-size-2 rt-variant-soft rt-Button">Cancel</button>
    --     <button data-accent-color="" type="button" class="rt-reset rt-BaseButton rt-r-size-2 rt-variant-solid rt-Button">Save</button>
    --   </div>
    -- </div>
    Radix.Modal.new
        { open = config.open
        , onClose = config.onClose
        , content =
            (case config.title of
                Nothing ->
                    Html.text ""

                Just title ->
                    Radix.Heading.new title
                        |> Radix.Heading.withSize 5
                        |> Radix.Heading.view
            )
                :: (case config.description of
                        [] ->
                            Html.text ""

                        nonEmptyDescription ->
                            Radix.Text.new nonEmptyDescription
                                |> Radix.Text.asParagraph
                                |> Radix.Text.withSize 2
                                |> Radix.Text.view
                   )
                :: config.body
        }
        |> (case config.size of
                Size1 ->
                    Radix.Modal.withSize1

                Size2 ->
                    Radix.Modal.withSize2

                Size3 ->
                    identity

                Size4 ->
                    Radix.Modal.withSize4
           )
        |> Radix.Internal.applyMaybe Radix.Modal.withWidth config.width
        |> Radix.Internal.applyMaybe Radix.Modal.withMinWidth config.minWidth
        |> Radix.Modal.withMaxWidth config.maxWidth
        |> Radix.Modal.withCustomClassList config.customClassList
        |> Radix.Modal.withCustomStyles config.customStyles
        |> Radix.Modal.withCustomAttributes config.customAttributes
        |> Radix.Modal.view
