//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-18T00:00:00, 19:16:12
// ----------------------------------------------------
// Method: FormSetObjectActions
// Description
// Modified: 08/18/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptTable)
C_TEXT:C284($formName; $2)

If (Count parameters:C259=0)
	$ptTable:=ptCurTable
	$formName:="Input1"
Else 
	$ptTable:=$1
	$formName:=$2
End if 
FORM LOAD:C1103(ptCurTable->; $formName)


ARRAY TEXT:C222($objectsArray; 0)
ARRAY POINTER:C280($ptVariablesArray; 0)
ARRAY LONGINT:C221($pagesArray; 0)
ARRAY LONGINT:C221($rayClearAll; 59)  // set an array to all zeros
ARRAY LONGINT:C221($rayForms; 16)  // define actions for forms
$rayForms{1}:=On Load:K2:1
$rayForms{2}:=On Page Change:K2:54
$rayForms{3}:=On Validate:K2:3
$rayForms{4}:=On Clicked:K2:4
$rayForms{5}:=On Double Clicked:K2:5
$rayForms{6}:=On Outside Call:K2:11
$rayForms{7}:=On Drop:K2:12
$rayForms{8}:=On Menu Selected:K2:14
$rayForms{9}:=On Plug in Area:K2:16
$rayForms{10}:=On Data Change:K2:15
$rayForms{11}:=On Close Box:K2:21
$rayForms{12}:=On Unload:K2:2
$rayForms{13}:=On Timer:K2:25
$rayForms{14}:=On Resize:K2:27
$rayForms{15}:=On Load Record:K2:38
$rayForms{16}:=On Selection Change:K2:29
ARRAY LONGINT:C221($rayButtons; 1)  // define actions for buttons
$rayButtons{1}:=On Clicked:K2:4
ARRAY LONGINT:C221($rayVarFields; 1)  // define actions for Fields
$rayVarFields{1}:=On Data Change:K2:15
ARRAY LONGINT:C221($rayExternals; 5)  // define actions for External Areas
$rayExternals{1}:=On Data Change:K2:15
$rayExternals{2}:=On Drop:K2:12
$rayExternals{3}:=On Plug in Area:K2:16
$rayExternals{4}:=On Clicked:K2:4
$rayExternals{5}:=On Double Clicked:K2:5
ARRAY LONGINT:C221($rayPopups; 1)  // define actions for External Areas
$rayPopups{1}:=On Clicked:K2:4
ARRAY LONGINT:C221($rayLists; 1)  // define actions for External Areas
$rayLists{1}:=On Clicked:K2:4

OBJECT SET EVENTS:C1239(*; ""; $rayForms; Enable events disable others:K42:37)  // set the actions for the form

FORM GET OBJECTS:C898($objectsArray; $variablesArray; $pagesArray; Form all pages:K67:7)
$cntObjects:=Size of array:C274($objectsArray)
For ($incObjects; 1; $cntObjects)
	$objectType:=OBJECT Get type:C1300(*; $objectsArray{$incObjects})
	//find the events for the object
	Case of 
		: ($objectType=Object type 3D button:K79:17)  //         //    Longint =       //    16:   
			$doClass:="buttons"
			
		: ($objectType=Object type 3D checkbox:K79:27)  //         //    Longint =       //    26:  
			$doClass:="buttons"
			
		: ($objectType=Object type 3D radio button:K79:24)  //         //    Longint =       //    23:   
			$doClass:="buttons"
			
		: ($objectType=Object type button grid:K79:21)  //         //    Longint =       //    20:   
			$doClass:="buttons"
			
		: ($objectType=Object type checkbox:K79:26)  //         //    Longint =       //    25:   
			$doClass:="buttons"
			
		: ($objectType=Object type combobox:K79:12)  //         //    Longint =       //    11:   
			$doClass:="buttons"
			
		: ($objectType=Object type dial:K79:29)  //         //    Longint =       //    28:   
			$doClass:="buttons"
			
		: ($objectType=Object type group:K79:22)  //         //    Longint =       //    21:   
			$doClass:="buttons"
			
		: ($objectType=Object type groupbox:K79:31)  //         //    Longint =       //    30:   \t      //    
			$doClass:="buttons"
			
		: ($objectType=Object type hierarchical list:K79:7)  //         //    Longint =       //    6:   
			$doClass:="buttons"
			
		: ($objectType=Object type hierarchical popup menu:K79:14)  //         //    Longint =       //    13:   
			$doClass:="buttons"
			
		: ($objectType=Object type highlight button:K79:18)  //         //    Longint =       //    17:   
			$doClass:="buttons"
			
		: ($objectType=Object type invisible button:K79:19)  //         //    Longint =       //    18:   
			$doClass:="buttons"
			
		: ($objectType=Object type line:K79:33)  //         //    Longint =       //    32:   
			$doClass:="lists"
			
		: ($objectType=Object type listbox:K79:8)  //         //    Longint =       //    7:   
			$doClass:="lists"
			
		: ($objectType=Object type listbox column:K79:10)  //         //    Longint =       //    9:   
			$doClass:="lists"
		: ($objectType=Object type listbox footer:K79:11)  //         //    Longint =       //    10:   
			$doClass:="lists"
		: ($objectType=Object type listbox header:K79:9)  //         //    Longint =       //    8:   
			$doClass:="lists"
		: ($objectType=Object type matrix:K79:36)  //         //    Longint =       //    35:   
			$doClass:="lists"
			
		: ($objectType=Object type oval:K79:35)  //         //    Longint =       //    34:   
			$doClass:="buttons"
		: ($objectType=Object type picture button:K79:20)  //         //    Longint =       //    19:   
			$doClass:="buttons"
		: ($objectType=Object type picture input:K79:5)  //         //    Longint =       //    4:   
			$doClass:="buttons"
		: ($objectType=Object type picture popup menu:K79:15)  //         //    Longint =       //    14:   
			$doClass:="buttons"
		: ($objectType=Object type picture radio button:K79:25)  //         //    Longint =       //    24:   
			$doClass:="buttons"
			
		: ($objectType=Object type plugin area:K79:39)  //         //    Longint =       //    38:   
			$doClass:="externals"
			
		: ($objectType=Object type popup dropdown list:K79:13)  //         //    Longint =       //    12:   
			$doClass:="buttons"
		: ($objectType=Object type progress indicator:K79:28)  //         //    Longint =       //    27:   
			$doClass:="buttons"
		: ($objectType=Object type push button:K79:16)  //         //    Longint =       //    15:   
			$doClass:="buttons"
		: ($objectType=Object type radio button:K79:23)  //         //    Longint =       //    22:   
			$doClass:="buttons"
		: ($objectType=Object type radio button field:K79:6)  //         //    Longint =       //    5:   
			$doClass:="buttons"
		: ($objectType=Object type rectangle:K79:32)  //         //    Longint =       //    31:   
			$doClass:="buttons"
		: ($objectType=Object type rounded rectangle:K79:34)  //         //    Longint =       //    33:   
			$doClass:="buttons"
		: ($objectType=Object type ruler:K79:30)  //         //    Longint =       //    29:   
			$doClass:="buttons"
		: ($objectType=Object type splitter:K79:37)  //         //    Longint =       //    36:   
			$doClass:="buttons"
		: ($objectType=Object type static picture:K79:3)  //         //    Longint =       //    2:   
			$doClass:="buttons"
		: ($objectType=Object type static text:K79:2)  //         //    Longint =       //    1:   
			$doClass:="buttons"
		: ($objectType=Object type subform:K79:40)  //         //    Longint =       //    39:   
			$doClass:="externals"
		: ($objectType=Object type tab control:K79:38)  //         //    Longint =       //    37:   
			$doClass:="externals"
			
		: ($objectType=Object type text input:K79:4)  //         //    Longint =       //    3:   
			$doClass:="varFields"
		: ($objectType=Object type unknown:K79:1)  //         //    Longint =       //    0:   
			$doClass:="varFields"
			
		: ($objectType=Object type web area:K79:41)  //         //    Longint =       //    40:   
			$doClass:="externals"
		: ($objectType=Object type write pro area:K79:42)  //         //    Longint =       //    4
			$doClass:="externals"
	End case 
	
	Case of 
		: ($doClass="buttons")  // button types
			OBJECT SET EVENTS:C1239(*; $objectsArray{$incObjects}; $rayButtons; Enable events disable others:K42:37)  //  
			
		: ($doClass="externals")  // button types
			OBJECT SET EVENTS:C1239(*; $objectsArray{$incObjects}; $rayExternals; Enable events disable others:K42:37)  // 
			
		: ($doClass="lists")  // button types
			OBJECT SET EVENTS:C1239(*; $objectsArray{$incObjects}; $rayLists; Enable events disable others:K42:37)  //  
		: ($doClass="varFields")  // button types
			OBJECT SET EVENTS:C1239(*; $objectsArray{$incObjects}; $rayVarFields; Enable events disable others:K42:37)  // 
	End case 
End for 