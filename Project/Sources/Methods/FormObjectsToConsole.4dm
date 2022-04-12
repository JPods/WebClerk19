//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/30/20, 17:34:55
// ----------------------------------------------------
// Method: FormObjectsToConsole
// Description
// 
//
// Parameters
// ----------------------------------------------------

// very handy to see what is on a layout
// ### bj ### 20200330_1732
// found in [Invoice]Output form. jm must have written this



//<declarations>
//==================================
//  Type variables 
//==================================

// variables
C_LONGINT:C283(viFieldNum; viTableNum)
C_TEXT:C284(vtVarName)

//==================================
//  Initialize variables 
//==================================

viFieldNum:=0
viTableNum:=0
vtVarName:=""
//</declarations>

//FORM LOAD([Invoice];"output")
ARRAY TEXT:C222(atObjects; 0)
FORM GET OBJECTS:C898(atObjects)
ARRAY LONGINT:C221(aiType; Size of array:C274(atObjects))
ARRAY TEXT:C222(atType; Size of array:C274(atObjects))
ARRAY POINTER:C280(apDataSource; Size of array:C274(atObjects))
For (i; 1; Size of array:C274(atObjects))
	aiType{i}:=OBJECT Get type:C1300(*; atObjects{i})
	apDataSource{i}:=OBJECT Get data source:C1265(*; atObjects{i})
	
	Case of 
			
		: (aiType{i}=0)
			atType{i}:="unknown"
			
		: (aiType{i}=1)
			atType{i}:="static text"
			
		: (aiType{i}=2)
			atType{i}:="static picture"
			
		: (aiType{i}=3)
			atType{i}:="text input"
			
		: (aiType{i}=4)
			atType{i}:="picture input"
			
		: (aiType{i}=5)
			atType{i}:="radio button field"
			
		: (aiType{i}=6)
			atType{i}:="hierarchical list"
			
		: (aiType{i}=7)
			atType{i}:="listbox"
			
		: (aiType{i}=8)
			atType{i}:="listbox header"
			
		: (aiType{i}=9)
			atType{i}:="listbox column"
			
		: (aiType{i}=10)
			atType{i}:="listbox footer"
			
		: (aiType{i}=11)
			atType{i}:="combobox"
			
		: (aiType{i}=12)
			atType{i}:="popup dropdown list"
			
		: (aiType{i}=13)
			atType{i}:="hierarchical popup menu"
			
		: (aiType{i}=14)
			atType{i}:="picture popup menu"
			
		: (aiType{i}=15)
			atType{i}:="push button"
			
		: (aiType{i}=16)
			atType{i}:="3D button"
			
		: (aiType{i}=17)
			atType{i}:="highlight button"
			
		: (aiType{i}=18)
			atType{i}:="invisible button"
			
		: (aiType{i}=19)
			atType{i}:="picture button"
			
		: (aiType{i}=20)
			atType{i}:="button grid"
			
		: (aiType{i}=21)
			atType{i}:="group"
			
		: (aiType{i}=22)
			atType{i}:="radio button"
			
		: (aiType{i}=23)
			atType{i}:="3D radio button"
			
		: (aiType{i}=24)
			atType{i}:="picture radio button"
			
		: (aiType{i}=25)
			atType{i}:="checkbox"
			
		: (aiType{i}=26)
			atType{i}:="3D checkbox"
			
		: (aiType{i}=27)
			atType{i}:="progress indicator"
			
		: (aiType{i}=28)
			atType{i}:="dial"
			
		: (aiType{i}=29)
			atType{i}:="ruler"
			
		: (aiType{i}=30)
			atType{i}:="groupbox"
			
		: (aiType{i}=31)
			atType{i}:="rectangle"
			
		: (aiType{i}=32)
			atType{i}:="line"
			
		: (aiType{i}=33)
			atType{i}:="rounded rectangle"
			
		: (aiType{i}=34)
			atType{i}:="oval"
			
		: (aiType{i}=35)
			atType{i}:="matrix"
			
		: (aiType{i}=36)
			atType{i}:="splitter"
			
		: (aiType{i}=37)
			atType{i}:="tab control"
			
		: (aiType{i}=38)
			atType{i}:="plugin area"
			
		: (aiType{i}=39)
			atType{i}:="subform"
			
		: (aiType{i}=40)
			atType{i}:="web area"
			
		: (aiType{i}=41)
			atType{i}:="write pro area"
			
	End case 
	
	RESOLVE POINTER:C394(apDataSource{i}; vtVarName; viTableNum; viFieldNum)
	
	Case of 
		: ((vtVarName="") & (viTableNum=0) & (viFieldNum=0))
			vtVarName:="NIL"
			
		: ((vtVarName="") & (viTableNum>0) & (viFieldNum>0))
			vtVarName:=Field name:C257(viTableNum; viFieldNum)
			
	End case 
	
	
	ConsoleMessage(atObjects{i}+"\t"+String:C10(aiType{i})+"\t"+atType{i}+"\t"+vtVarName)
End for 
//FORM UNLOAD

//JSON Stringify array ( array {; *} ) -> Function result 
