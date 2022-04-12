//%attributes = {}

$emojis:=New object:C1471

$emojis.charOpen:="▶︎"  //BLACK RIGHT-POINTING TRIANGLE Unicode: U+25B6 U+FE0E, UTF-8: E2 96 B6 EF B8 8E
$emojis.charClose:="▼"  //BLACK DOWN-POINTING TRIANGLE Unicode: U+25BC, UTF-8: E2 96 BC
$emojis.charMenu:="▼"  //BLACK DOWN-POINTING TRIANGLE Unicode: U+25BC, UTF-8: E2 96 BC
$emojis.charOpenSmall:="▸"  //BLACK RIGHT-POINTING SMALL TRIANGLE Unicode: U+25B8, UTF-8: E2 96 B8
$emojis.charCloseSmall:="▾"  //BLACK DOWN-POINTING SMALL TRIANGLE Unicode: U+25BE, UTF-8: E2 96 BE
$emojis.charMenuSmall:="▾"  //BLACK DOWN-POINTING SMALL TRIANGLE Unicode: U+25BE, UTF-8: E2 96 BE"
If (False:C215)
	$emojis.charUpArrow:="⬆︎"  //UPWARDS BLACK ARROW Unicode: U+2B06 U+FE0E, UTF-8: E2 AC 86 EF B8 8E
	$emojis.charDownArrow:="⬇︎"  //DOWNWARDS BLACK ARROW Unicode: U+2B07 U+FE0E, UTF-8: E2 AC 87 EF B8 8E
	$emojis.charReturn:="↩︎"  // LEFTWARDS ARROW WITH HOOK Unicode: U+21A9 U+FE0E, UTF-8: E2 86 A9 EF B8 8E
	$emojis.charTop:="🔝"  //top arrow Unicode: U+1F51D, UTF-8: F0 9F 94 9D
	$emojis.charCheck:="✔️"  //checkmark   Unicode: U+2714 U+FE0F, UTF-8: E2 9C 94 EF B8 8F
	$emojis.charOption:="⌥"  //OPTION KEY Unicode: U+2325, UTF-8: E2 8C A5
End if 

$0:=$emojis
