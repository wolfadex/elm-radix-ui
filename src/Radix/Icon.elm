module Radix.Icon exposing (..)

import Html exposing (Html)
import Html.Attributes


view : String -> Html msg
view name =
    Html.img
        [ Html.Attributes.src ("radix-icons/" ++ name ++ ".svg")
        ]
        []


accessibility : Html msg
accessibility =
    view "accessibility"


activityLog : Html msg
activityLog =
    view "activity-log"


alignBaseline : Html msg
alignBaseline =
    view "align-baseline"


alignBottom : Html msg
alignBottom =
    view "align-bottom"


alignCenterHorizontally : Html msg
alignCenterHorizontally =
    view "align-center-horizontally"


alignCenterVertically : Html msg
alignCenterVertically =
    view "align-center-vertically"


alignCenter : Html msg
alignCenter =
    view "align-center"


alignEnd : Html msg
alignEnd =
    view "align-end"


alignHorizontalCenters : Html msg
alignHorizontalCenters =
    view "align-horizontal-centers"


alignLeft : Html msg
alignLeft =
    view "align-left"


alignRight : Html msg
alignRight =
    view "align-right"


alignStart : Html msg
alignStart =
    view "align-start"


alignStretch : Html msg
alignStretch =
    view "align-stretch"


alignTop : Html msg
alignTop =
    view "align-top"


alignVerticalCenters : Html msg
alignVerticalCenters =
    view "align-vertical-centers"


allSides : Html msg
allSides =
    view "all-sides"


angle : Html msg
angle =
    view "angle"


archive : Html msg
archive =
    view "archive"


arrowBottomLeft : Html msg
arrowBottomLeft =
    view "arrow-bottom-left"


arrowBottomRight : Html msg
arrowBottomRight =
    view "arrow-bottom-right"


arrowDown : Html msg
arrowDown =
    view "arrow-down"


arrowLeft : Html msg
arrowLeft =
    view "arrow-left"


arrowRight : Html msg
arrowRight =
    view "arrow-right"


arrowTopLeft : Html msg
arrowTopLeft =
    view "arrow-top-left"


arrowTopRight : Html msg
arrowTopRight =
    view "arrow-top-right"


arrowUp : Html msg
arrowUp =
    view "arrow-up"


aspectRatio : Html msg
aspectRatio =
    view "aspect-ratio"


avatar : Html msg
avatar =
    view "avatar"


backpack : Html msg
backpack =
    view "backpack"


badge : Html msg
badge =
    view "badge"


barChart : Html msg
barChart =
    view "bar-chart"


bell : Html msg
bell =
    view "bell"


blendingMode : Html msg
blendingMode =
    view "blending-mode"


bookmarkFilled : Html msg
bookmarkFilled =
    view "bookmark-filled"


bookmark : Html msg
bookmark =
    view "bookmark"


borderAll : Html msg
borderAll =
    view "border-all"


borderBottom : Html msg
borderBottom =
    view "border-bottom"


borderDashed : Html msg
borderDashed =
    view "border-dashed"


borderDotted : Html msg
borderDotted =
    view "border-dotted"


borderLeft : Html msg
borderLeft =
    view "border-left"


borderNone : Html msg
borderNone =
    view "border-none"


borderRight : Html msg
borderRight =
    view "border-right"


borderSolid : Html msg
borderSolid =
    view "border-solid"


borderSplit : Html msg
borderSplit =
    view "border-split"


borderStyle : Html msg
borderStyle =
    view "border-style"


borderTop : Html msg
borderTop =
    view "border-top"


borderWidth : Html msg
borderWidth =
    view "border-width"


boxModel : Html msg
boxModel =
    view "box-model"


box : Html msg
box =
    view "box"


button : Html msg
button =
    view "button"


calendar : Html msg
calendar =
    view "calendar"


camera : Html msg
camera =
    view "camera"


cardStackMinus : Html msg
cardStackMinus =
    view "card-stack-minus"


cardStackPlus : Html msg
cardStackPlus =
    view "card-stack-plus"


cardStack : Html msg
cardStack =
    view "card-stack"


caretDown : Html msg
caretDown =
    view "caret-down"


caretLeft : Html msg
caretLeft =
    view "caret-left"


caretRight : Html msg
caretRight =
    view "caret-right"


caretSort : Html msg
caretSort =
    view "caret-sort"


caretUp : Html msg
caretUp =
    view "caret-up"


chatBubble : Html msg
chatBubble =
    view "chat-bubble"


checkCircled : Html msg
checkCircled =
    view "check-circled"


check : Html msg
check =
    view "check"


checkbox : Html msg
checkbox =
    view "checkbox"


chevronDown : Html msg
chevronDown =
    view "chevron-down"


chevronLeft : Html msg
chevronLeft =
    view "chevron-left"


chevronRight : Html msg
chevronRight =
    view "chevron-right"


chevronUp : Html msg
chevronUp =
    view "chevron-up"


circleBackslash : Html msg
circleBackslash =
    view "circle-backslash"


circle : Html msg
circle =
    view "circle"


clipboardCopy : Html msg
clipboardCopy =
    view "clipboard-copy"


clipboard : Html msg
clipboard =
    view "clipboard"


clock : Html msg
clock =
    view "clock"


code : Html msg
code =
    view "code"


codesandboxLogo : Html msg
codesandboxLogo =
    view "codesandbox-logo"


colorWheel : Html msg
colorWheel =
    view "color-wheel"


columnSpacing : Html msg
columnSpacing =
    view "column-spacing"


columns : Html msg
columns =
    view "columns"


commit : Html msg
commit =
    view "commit"


component1 : Html msg
component1 =
    view "component-1"


component2 : Html msg
component2 =
    view "component-2"


componentBoolean : Html msg
componentBoolean =
    view "component-boolean"


componentInstance : Html msg
componentInstance =
    view "component-instance"


componentNone : Html msg
componentNone =
    view "component-none"


componentPlaceholder : Html msg
componentPlaceholder =
    view "component-placeholder"


container : Html msg
container =
    view "container"


cookie : Html msg
cookie =
    view "cookie"


copy : Html msg
copy =
    view "copy"


cornerBottomLeft : Html msg
cornerBottomLeft =
    view "corner-bottom-left"


cornerBottomRight : Html msg
cornerBottomRight =
    view "corner-bottom-right"


cornerTopLeft : Html msg
cornerTopLeft =
    view "corner-top-left"


cornerTopRight : Html msg
cornerTopRight =
    view "corner-top-right"


corners : Html msg
corners =
    view "corners"


countdownTimer : Html msg
countdownTimer =
    view "countdown-timer"


counterClockwiseClock : Html msg
counterClockwiseClock =
    view "counter-clockwise-clock"


crop : Html msg
crop =
    view "crop"


cross1 : Html msg
cross1 =
    view "cross-1"


cross2 : Html msg
cross2 =
    view "cross-2"


crossCircled : Html msg
crossCircled =
    view "cross-circled"


crosshair1 : Html msg
crosshair1 =
    view "crosshair-1"


crosshair2 : Html msg
crosshair2 =
    view "crosshair-2"


crumpledPaper : Html msg
crumpledPaper =
    view "crumpled-paper"


cube : Html msg
cube =
    view "cube"


cursorArrow : Html msg
cursorArrow =
    view "cursor-arrow"


cursorText : Html msg
cursorText =
    view "cursor-text"


dash : Html msg
dash =
    view "dash"


dashboard : Html msg
dashboard =
    view "dashboard"


desktop : Html msg
desktop =
    view "desktop"


dimensions : Html msg
dimensions =
    view "dimensions"


disc : Html msg
disc =
    view "disc"


discordLogo : Html msg
discordLogo =
    view "discord-logo"


dividerHorizontal : Html msg
dividerHorizontal =
    view "divider-horizontal"


dividerVertical : Html msg
dividerVertical =
    view "divider-vertical"


dotFilled : Html msg
dotFilled =
    view "dot-filled"


dotSolid : Html msg
dotSolid =
    view "dot-solid"


dot : Html msg
dot =
    view "dot"


dotsHorizontal : Html msg
dotsHorizontal =
    view "dots-horizontal"


dotsVertical : Html msg
dotsVertical =
    view "dots-vertical"


doubleArrowDown : Html msg
doubleArrowDown =
    view "double-arrow-down"


doubleArrowLeft : Html msg
doubleArrowLeft =
    view "double-arrow-left"


doubleArrowRight : Html msg
doubleArrowRight =
    view "double-arrow-right"


doubleArrowUp : Html msg
doubleArrowUp =
    view "double-arrow-up"


download : Html msg
download =
    view "download"


dragHandleDots1 : Html msg
dragHandleDots1 =
    view "drag-handle-dots-1"


dragHandleDots2 : Html msg
dragHandleDots2 =
    view "drag-handle-dots-2"


dragHandleHorizontal : Html msg
dragHandleHorizontal =
    view "drag-handle-horizontal"


dragHandleVertical : Html msg
dragHandleVertical =
    view "drag-handle-vertical"


drawingPinFilled : Html msg
drawingPinFilled =
    view "drawing-pin-filled"


drawingPinSolid : Html msg
drawingPinSolid =
    view "drawing-pin-solid"


drawingPin : Html msg
drawingPin =
    view "drawing-pin"


dropdownMenu : Html msg
dropdownMenu =
    view "dropdown-menu"


enterFullScreen : Html msg
enterFullScreen =
    view "enter-full-screen"


enter : Html msg
enter =
    view "enter"


envelopeClosed : Html msg
envelopeClosed =
    view "envelope-closed"


envelopeOpen : Html msg
envelopeOpen =
    view "envelope-open"


eraser : Html msg
eraser =
    view "eraser"


exclamationTriangle : Html msg
exclamationTriangle =
    view "exclamation-triangle"


exitFullScreen : Html msg
exitFullScreen =
    view "exit-full-screen"


exit : Html msg
exit =
    view "exit"


externalLink : Html msg
externalLink =
    view "external-link"


eyeClosed : Html msg
eyeClosed =
    view "eye-closed"


eyeNone : Html msg
eyeNone =
    view "eye-none"


eyeOpen : Html msg
eyeOpen =
    view "eye-open"


face : Html msg
face =
    view "face"


figmaLogo : Html msg
figmaLogo =
    view "figma-logo"


fileMinus : Html msg
fileMinus =
    view "file-minus"


filePlus : Html msg
filePlus =
    view "file-plus"


fileText : Html msg
fileText =
    view "file-text"


file : Html msg
file =
    view "file"


fontBold : Html msg
fontBold =
    view "font-bold"


fontFamily : Html msg
fontFamily =
    view "font-family"


fontItalic : Html msg
fontItalic =
    view "font-italic"


fontRoman : Html msg
fontRoman =
    view "font-roman"


fontSize : Html msg
fontSize =
    view "font-size"


fontStyle : Html msg
fontStyle =
    view "font-style"


frame : Html msg
frame =
    view "frame"


framerLogo : Html msg
framerLogo =
    view "framer-logo"


gear : Html msg
gear =
    view "gear"


githubLogo : Html msg
githubLogo =
    view "github-logo"


globe : Html msg
globe =
    view "globe"


grid : Html msg
grid =
    view "grid"


group : Html msg
group =
    view "group"


half1 : Html msg
half1 =
    view "half-1"


half2 : Html msg
half2 =
    view "half-2"


hamburgerMenu : Html msg
hamburgerMenu =
    view "hamburger-menu"


hand : Html msg
hand =
    view "hand"


heading : Html msg
heading =
    view "heading"


heartFilled : Html msg
heartFilled =
    view "heart-filled"


heart : Html msg
heart =
    view "heart"


height : Html msg
height =
    view "height"


hobbyKnife : Html msg
hobbyKnife =
    view "hobby-knife"


home : Html msg
home =
    view "home"


iconjarLogo : Html msg
iconjarLogo =
    view "iconjar-logo"


idCard : Html msg
idCard =
    view "id-card"


image : Html msg
image =
    view "image"


infoCircled : Html msg
infoCircled =
    view "info-circled"


innerShadow : Html msg
innerShadow =
    view "inner-shadow"


input : Html msg
input =
    view "input"


instagramLogo : Html msg
instagramLogo =
    view "instagram-logo"


justifyCenter : Html msg
justifyCenter =
    view "justify-center"


justifyEnd : Html msg
justifyEnd =
    view "justify-end"


justifyStart : Html msg
justifyStart =
    view "justify-start"


justifyStretch : Html msg
justifyStretch =
    view "justify-stretch"


keyboard : Html msg
keyboard =
    view "keyboard"


lapTimer : Html msg
lapTimer =
    view "lap-timer"


laptop : Html msg
laptop =
    view "laptop"


layers : Html msg
layers =
    view "layers"


layout : Html msg
layout =
    view "layout"


letterCaseCapitalize : Html msg
letterCaseCapitalize =
    view "letter-case-capitalize"


letterCaseLowercase : Html msg
letterCaseLowercase =
    view "letter-case-lowercase"


letterCaseToggle : Html msg
letterCaseToggle =
    view "letter-case-toggle"


letterCaseUppercase : Html msg
letterCaseUppercase =
    view "letter-case-uppercase"


letterSpacing : Html msg
letterSpacing =
    view "letter-spacing"


lightningBolt : Html msg
lightningBolt =
    view "lightning-bolt"


lineHeight : Html msg
lineHeight =
    view "line-height"


link1 : Html msg
link1 =
    view "link-1"


link2 : Html msg
link2 =
    view "link-2"


linkBreak1 : Html msg
linkBreak1 =
    view "link-break-1"


linkBbreak2 : Html msg
linkBbreak2 =
    view "link-break-2"


linkNone1 : Html msg
linkNone1 =
    view "link-none-1"


linkNone2 : Html msg
linkNone2 =
    view "link-none-2"


linkedinLogo : Html msg
linkedinLogo =
    view "linkedin-logo"


listBullet : Html msg
listBullet =
    view "list-bullet"


lockClosed : Html msg
lockClosed =
    view "lock-closed"


lockOpen1 : Html msg
lockOpen1 =
    view "lock-open-1"


lockOpen2 : Html msg
lockOpen2 =
    view "lock-open-2"


loop : Html msg
loop =
    view "loop"


magicWand : Html msg
magicWand =
    view "magic-wand"


magnifyingGlass : Html msg
magnifyingGlass =
    view "magnifying-glass"


margin : Html msg
margin =
    view "margin"


maskOff : Html msg
maskOff =
    view "mask-off"


maskOn : Html msg
maskOn =
    view "mask-on"


minusCircled : Html msg
minusCircled =
    view "minus-circled"


minus : Html msg
minus =
    view "minus"


mix : Html msg
mix =
    view "mix"


mixerHorizontal : Html msg
mixerHorizontal =
    view "mixer-horizontal"


mixerVertical : Html msg
mixerVertical =
    view "mixer-vertical"


mobile : Html msg
mobile =
    view "mobile"


modulzLogo : Html msg
modulzLogo =
    view "modulz-logo"


moon : Html msg
moon =
    view "moon"


move : Html msg
move =
    view "move"


notionLogo : Html msg
notionLogo =
    view "notion-logo"


opacity : Html msg
opacity =
    view "opacity"


openInNewWindow : Html msg
openInNewWindow =
    view "open-in-new-window"


outerShadow : Html msg
outerShadow =
    view "outer-shadow"


overline : Html msg
overline =
    view "overline"


padding : Html msg
padding =
    view "padding"


paperPlane : Html msg
paperPlane =
    view "paper-plane"


pause : Html msg
pause =
    view "pause"


pencil1 : Html msg
pencil1 =
    view "pencil-1"


pencil2 : Html msg
pencil2 =
    view "pencil-2"


person : Html msg
person =
    view "person"


pieChart : Html msg
pieChart =
    view "pie-chart"


pilcrow : Html msg
pilcrow =
    view "pilcrow"


pinBottom : Html msg
pinBottom =
    view "pin-bottom"


pinLeft : Html msg
pinLeft =
    view "pin-left"


pinRight : Html msg
pinRight =
    view "pin-right"


pinTop : Html msg
pinTop =
    view "pin-top"


play : Html msg
play =
    view "play"


plusCircled : Html msg
plusCircled =
    view "plus-circled"


plus : Html msg
plus =
    view "plus"


questionMarkCircled : Html msg
questionMarkCircled =
    view "question-mark-circled"


questionMark : Html msg
questionMark =
    view "question-mark"


quote : Html msg
quote =
    view "quote"


radiobutton : Html msg
radiobutton =
    view "radiobutton"


reader : Html msg
reader =
    view "reader"


reload : Html msg
reload =
    view "reload"


reset : Html msg
reset =
    view "reset"


resume : Html msg
resume =
    view "resume"


rocket : Html msg
rocket =
    view "rocket"


rotateCounterClockwise : Html msg
rotateCounterClockwise =
    view "rotate-counter-clockwise"


rowSpacing : Html msg
rowSpacing =
    view "row-spacing"


rows : Html msg
rows =
    view "rows"


rulerHorizontal : Html msg
rulerHorizontal =
    view "ruler-horizontal"


rulerSquare : Html msg
rulerSquare =
    view "ruler-square"


scissors : Html msg
scissors =
    view "scissors"


section : Html msg
section =
    view "section"


sewingPinFilled : Html msg
sewingPinFilled =
    view "sewing-pin-filled"


sewingPinSolid : Html msg
sewingPinSolid =
    view "sewing-pin-solid"


sewingPin : Html msg
sewingPin =
    view "sewing-pin"


shadowInner : Html msg
shadowInner =
    view "shadow-inner"


shadowNone : Html msg
shadowNone =
    view "shadow-none"


shadowOuter : Html msg
shadowOuter =
    view "shadow-outer"


shadow : Html msg
shadow =
    view "shadow"


share1 : Html msg
share1 =
    view "share-1"


share2 : Html msg
share2 =
    view "share-2"


shuffle : Html msg
shuffle =
    view "shuffle"


size : Html msg
size =
    view "size"


sketchLogo : Html msg
sketchLogo =
    view "sketch-logo"


slash : Html msg
slash =
    view "slash"


slider : Html msg
slider =
    view "slider"


spaceBetweenHorizontally : Html msg
spaceBetweenHorizontally =
    view "space-between-horizontally"


spaceBetweenVertically : Html msg
spaceBetweenVertically =
    view "space-between-vertically"


spaceEvenlyHorizontally : Html msg
spaceEvenlyHorizontally =
    view "space-evenly-horizontally"


spaceEvenlyVertically : Html msg
spaceEvenlyVertically =
    view "space-evenly-vertically"


speakerLoud : Html msg
speakerLoud =
    view "speaker-loud"


speakerModerate : Html msg
speakerModerate =
    view "speaker-moderate"


speakerOff : Html msg
speakerOff =
    view "speaker-off"


speakerQuiet : Html msg
speakerQuiet =
    view "speaker-quiet"


square : Html msg
square =
    view "square"


stack : Html msg
stack =
    view "stack"


starFilled : Html msg
starFilled =
    view "star-filled"


star : Html msg
star =
    view "star"


stitchesLogo : Html msg
stitchesLogo =
    view "stitches-logo"


stop : Html msg
stop =
    view "stop"


stopwatch : Html msg
stopwatch =
    view "stopwatch"


stretchHorizontally : Html msg
stretchHorizontally =
    view "stretch-horizontally"


stretchVertically : Html msg
stretchVertically =
    view "stretch-vertically"


strikethrough : Html msg
strikethrough =
    view "strikethrough"


sun : Html msg
sun =
    view "sun"


switch : Html msg
switch =
    view "switch"


symbol : Html msg
symbol =
    view "symbol"


table : Html msg
table =
    view "table"


target : Html msg
target =
    view "target"


textAlignBottom : Html msg
textAlignBottom =
    view "text-align-bottom"


textAlignCenter : Html msg
textAlignCenter =
    view "text-align-center"


textAlignJustify : Html msg
textAlignJustify =
    view "text-align-justify"


textAlignLeft : Html msg
textAlignLeft =
    view "text-align-left"


textAlignMiddle : Html msg
textAlignMiddle =
    view "text-align-middle"


textAlignRight : Html msg
textAlignRight =
    view "text-align-right"


textAlignTop : Html msg
textAlignTop =
    view "text-align-top"


textNone : Html msg
textNone =
    view "text-none"


text : Html msg
text =
    view "text"


thickArrowDown : Html msg
thickArrowDown =
    view "thick-arrow-down"


thickArrowLeft : Html msg
thickArrowLeft =
    view "thick-arrow-left"


thickArrowRight : Html msg
thickArrowRight =
    view "thick-arrow-right"


thickArrowUp : Html msg
thickArrowUp =
    view "thick-arrow-up"


timer : Html msg
timer =
    view "timer"


tokens : Html msg
tokens =
    view "tokens"


trackNext : Html msg
trackNext =
    view "track-next"


trackPrevious : Html msg
trackPrevious =
    view "track-previous"


transform : Html msg
transform =
    view "transform"


transparencyGrid : Html msg
transparencyGrid =
    view "transparency-grid"


trash : Html msg
trash =
    view "trash"


triangleDown : Html msg
triangleDown =
    view "triangle-down"


triangleLeft : Html msg
triangleLeft =
    view "triangle-left"


triangleRight : Html msg
triangleRight =
    view "triangle-right"


triangleUp : Html msg
triangleUp =
    view "triangle-up"


twitterLogo : Html msg
twitterLogo =
    view "twitter-logo"


underline : Html msg
underline =
    view "underline"


update : Html msg
update =
    view "update"


upload : Html msg
upload =
    view "upload"


valueNone : Html msg
valueNone =
    view "value-none"


value : Html msg
value =
    view "value"


vercelLogo : Html msg
vercelLogo =
    view "vercel-logo"


video : Html msg
video =
    view "video"


viewGrid : Html msg
viewGrid =
    view "view-grid"


viewHorizontal : Html msg
viewHorizontal =
    view "view-horizontal"


viewNone : Html msg
viewNone =
    view "view-none"


viewVertical : Html msg
viewVertical =
    view "view-vertical"


width : Html msg
width =
    view "width"


zoomIn : Html msg
zoomIn =
    view "zoom-in"


zoomOut : Html msg
zoomOut =
    view "zoom-out"
