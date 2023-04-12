//%attributes = {}


//$file:=Folder(fk resources folder).file("coords.json")


//Case of 
//: ($file.exists=False)
//// ALERT("No saved coords.")

//: (Process number(Current method name())#Current process)
//CALL WORKER(Current method name; Current method name)

//Else 
//$obj:=JSON Parse($file.getText())

var $s1; $s2 : Object
$s1:=New object:C1471("left"; 0; "top"; 0; "right"; 0; "bottom"; 0; "screenID"; 0; "screenArea"; 0)
$s2:=New object:C1471("left"; 0; "top"; 0; "right"; 0; "bottom"; 0; "screenID"; 0; "screenArea"; 0)
var $left; $top; $right; $bottom; $screenID; $screenArea; $cntScreens; $inc : Integer
$cntScreens:=Count screens:C437

// These do not work
//$s1.screenID:=1
//SCREEN COORDINATES($s1.left; $s1.top; $s1.right; $s1.bottom; $s1.screenID; $s1.screenArea)
//SCREEN COORDINATES($s1.left; $s1.top; $s1.right; $s1.bottom; 1; $s1.screenArea)

//$s1.screenID:=2
//SCREEN COORDINATES($s2.left; $s2.top; $s2.right; $s2.bottom; $s2.screenID; $s2.screenArea)

SCREEN COORDINATES:C438($left; $top; $right; $bottom; 1; $screenArea)
$s1.left:=$left
$s1.top:=$top
$s1.right:=$right
$s1.bottom:=$bottom
$s1.screenArea:=$screenID

SCREEN COORDINATES:C438($left; $top; $right; $bottom; 2; $screenArea)
$s2.left:=$left
$s2.top:=$top
$s2.right:=$right
$s2.bottom:=$bottom
$s2.screenArea:=$screenID

//For ($inc; 1; $cntScreens)
//SCREEN COORDINATES($left; $top; $right; $bottom; $inc; $screenArea)
//End for 

//$winRef:=Open form window("Form1"; Plain form window; $obj.x; $obj.y)
//DIALOG("Form1"; *)


//End case 