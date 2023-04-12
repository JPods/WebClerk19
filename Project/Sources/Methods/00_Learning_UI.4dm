//%attributes = {}
//  https://www.youtube.com/watch?v=nOePNkvXBXY&t=2448s
// https://4dmethod.com/2021/11/12/november-17-meeting-avec-classe-ui-with-class-vincent-de-lachaux/?mkt_tok=NTMxLU1SVC00NjgAAAGAzewOI5hF8EZu9VBJcas0SL_z79XpTwf-Gmvtzro8JtHHlVRGyVjzmgYWX455icp3oiA3nhYqM3jk2k3qSxOOcQc3f6uLn3DqGmlMehRK

OBJECT SET VISIBLE:C603(*; "myObject"; True:C214)
$myObject.show()
OBJECT SET VISIBLE:C603(*; "myObject"; False:C215)
$myObject.hide()

OBJECT SET ENABLED:C1123(*; "myButton"; True:C214)
$myButton.show()
OBJECT SET VISIBLE:C603(*; "myButton"; False:C215)
$myButton.hide()

LISTBOX SELECT ROW:C912(*; "myListbox"; 0; lk replace selection:K53:1)
$myListbox.selectAll()

C_VARIANT:C1683($value)
$value:=OBJECT Get value:C1743(OBJECT Get name:C1087(Object current:K67:2))
OBJECT SET VALUE:C1742(OBJECT Get name:C1087(Object current:K67:2); "New value")
// min: 1:17
//Function init()

//Function onLoad()

//Function onUpdate()

