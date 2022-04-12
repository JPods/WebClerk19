//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-01T00:00:00, 09:49:25
// ----------------------------------------------------
// Method: jCenterWindow
// Description
// Modified: 08/01/13
// 
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($left; $top; $right; $bottom; $1; $2; $3; $windowType)
C_TEXT:C284($4; $windowTitle)  //window title
C_TEXT:C284($5; $closeProcedure)  //close window call back proc   "Wind_CloseBox")
//WS CENTER RECT($1;$2;$left;$top;$right;$bottom)

C_LONGINT:C283($width; $height)
$width:=$1
// ### bj ### 20181119_2143
$width:=$width+10
$height:=$2
// ### bj ### 20181119_2143  add padding to window
$height:=$height+10
$windowType:=5  //1984//-724
$windowTitle:=""
$closeProcedure:=""
If (Count parameters:C259>2)
	If (($3>-1) & ($3<6))
		$windowType:=5  //1984//-724//-1984+(2*Num(Count parameters>3))// pallet window +2 Title 
	End if 
	
End if 
$left:=500-($width\2)
$right:=500+($width\2)
$top:=400-($height\2)
$bottom:=400+($height\2)
Case of 
	: (Count parameters:C259=2)
		Open window:C153($left; $top; $right; $bottom; 1)
	: (Count parameters:C259=3)
		Open window:C153($left; $top; $right; $bottom; $windowType)
	: (Count parameters:C259=4)
		Open window:C153($left; $top; $right; $bottom; $windowType; $4)
	: (Count parameters:C259=5)
		Open window:C153($left; $top; $right; $bottom; $windowType; $4; $5)
End case 

If (ptCurTable#(->[TallyMaster:60]))
	Execute_TallyMaster("CenterWindow"; "Scripts")  // ### jwm ### 20160831_1100
End if 