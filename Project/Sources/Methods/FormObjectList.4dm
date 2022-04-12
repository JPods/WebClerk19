//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/14/17, 00:55:49
// ----------------------------------------------------
// Method: ListFormObject
// Description
// Returns location and name of form object
//
// Parameters
// ----------------------------------------------------


//<declarations>
//==================================
//  Type variables 
//==================================

// variables
C_LONGINT:C283(<>VIDEBUGMODE; $vi1; $vi6; $viTableNum; vi6; viFieldNum; viheight; vinumPages)
C_LONGINT:C283(viTableNum; viwidth)
C_TEXT:C284(vText; vtFormName; vtObjectName; vtTableName; vtVarName)

//==================================
//  Initialize variables 
//==================================

$vi1:=0
$vi6:=0
$viTableNum:=0
vi6:=0
viFieldNum:=0
viheight:=0
vinumPages:=0
viTableNum:=0
viwidth:=0
vText:=""
vtFormName:=""
vtObjectName:=""
vtTableName:=""
vtVarName:=""
//</declarations>

SET MENU BAR:C67(6; Current process:C322)  // standard menu

//vtTableName:=Request("Enter Table Name";"Customer")
//vtFormName:=Request("Enter Form Name";"Input1")
vtSearchName:=Request:C163("Enter Object Name"; "aPages")

ARRAY TEXT:C222(atTableTitles; 0)
ARRAY LONGINT:C221(aiTableNums; 0)

GET TABLE TITLES:C803(atTableTitles; aiTableNums)
//$viTableNum:=Find in array(atTableTitles;vtTableName)

ConsoleMessage("Table:\tForm:\tObject:\tName:\tPage:\tStyle\tFont:\tType:")


For ($vi1; 1; Size of array:C274(atTableTitles))
	
	$viTableNum:=aiTableNums{$vi1}
	
	ARRAY TEXT:C222(atFormNames; 0)
	
	FORM GET NAMES:C1167(Table:C252($viTableNum)->; atFormNames)
	
	For ($vi2; 1; Size of array:C274(atFormNames))
		
		ARRAY TEXT:C222(atFieldTitles; 0)
		ARRAY LONGINT:C221(aiFieldNums; 0)
		
		//GET FIELD TITLES(Table($viTableNum)->;atFieldTitles;aiFieldNums)
		//$vi6:=Find in array(atFieldTitles;vtObjectName)
		
		FORM LOAD:C1103(Table:C252($viTableNum)->; atFormNames{$vi2})
		//FORM GET PROPERTIES(Table($viTableNum)->;vtFormName;viwidth;viheight;vinumPages)
		
		ARRAY TEXT:C222(atObjectNames; 0)
		ARRAY POINTER:C280(apVariables; 0)
		ARRAY LONGINT:C221(aiPages; 0)
		
		// selection of form without execution of events or methods
		FORM GET OBJECTS:C898(atObjectNames; apVariables; aiPages; 2)
		
		For ($vi3; 1; Size of array:C274(atObjectNames))
			
			$viType:=OBJECT Get type:C1300(*; atObjectNames{$vi3})
			
			$viLog:=0
			
			Case of 
				: ($viType=Object type 3D button:K79:17)
					$vtType:="3D button"
					$viLog:=1
					
				: ($viType=Object type 3D checkbox:K79:27)
					$vtType:="3D checkbox"
					
				: ($viType=Object type 3D radio button:K79:24)
					$vtType:="3D radio button"
					
				: ($viType=Object type button grid:K79:21)
					$vtType:="button grid"
					
				: ($viType=Object type checkbox:K79:26)
					$vtType:="checkbox"
					
				: ($viType=Object type combobox:K79:12)
					$vtType:="combobox"
					
				: ($viType=Object type dial:K79:29)
					$vtType:="dial"
					
				: ($viType=Object type group:K79:22)
					$vtType:="group"
					
				: ($viType=Object type groupbox:K79:31)
					$vtType:="groupbox"
					
				: ($viType=Object type hierarchical list:K79:7)
					$vtType:="hierarchical list"
					
				: ($viType=Object type hierarchical popup menu:K79:14)
					$vtType:="hierarchical popup menu"
					
				: ($viType=Object type highlight button:K79:18)
					$vtType:="highlight button"
					$viLog:=1
					
				: ($viType=Object type invisible button:K79:19)
					$vtType:="invisible button"
					
				: ($viType=Object type line:K79:33)
					$vtType:="line"
					
				: ($viType=Object type listbox:K79:8)
					$vtType:="listbox"
					
				: ($viType=Object type listbox column:K79:10)
					$vtType:="listbox column"
					
				: ($viType=Object type listbox footer:K79:11)
					$vtType:="listbox footer"
					
				: ($viType=Object type listbox header:K79:9)
					$vtType:="listbox header"
					
				: ($viType=Object type matrix:K79:36)
					$vtType:="matrix"
					
				: ($viType=Object type oval:K79:35)
					$vtType:="oval"
					
				: ($viType=Object type picture button:K79:20)
					$vtType:="picture button"
					
				: ($viType=Object type picture input:K79:5)
					$vtType:="picture input"
					
				: ($viType=Object type picture popup menu:K79:15)
					$vtType:="picture popup menu"
					
				: ($viType=Object type picture radio button:K79:25)
					$vtType:="picture radio button"
					
				: ($viType=Object type plugin area:K79:39)
					$vtType:="plugin area"
					
				: ($viType=Object type popup dropdown list:K79:13)
					$vtType:="popup dropdown list"
					$viLog:=1
					
				: ($viType=Object type progress indicator:K79:28)
					$vtType:="progress indicator"
					
				: ($viType=Object type push button:K79:16)
					$vtType:="push button"
					$viLog:=1
					
				: ($viType=Object type radio button:K79:23)
					$vtType:="radio button"
					
				: ($viType=Object type radio button field:K79:6)
					$vtType:="radio button field"
					
				: ($viType=Object type rectangle:K79:32)
					$vtType:="rectangle"
					
				: ($viType=Object type rounded rectangle:K79:34)
					$vtType:="rounded rectangle"
					
				: ($viType=Object type ruler:K79:30)
					$vtType:="ruler"
					
				: ($viType=Object type splitter:K79:37)
					$vtType:="splitter"
					
				: ($viType=Object type static picture:K79:3)
					$vtType:="static picture"
					
				: ($viType=Object type static text:K79:2)
					$vtType:="static text"
					$viLog:=1
					
				: ($viType=Object type subform:K79:40)
					$vtType:="subform"
					
				: ($viType=Object type tab control:K79:38)
					$vtType:="tab control"
					
				: ($viType=Object type text input:K79:4)
					$vtType:="text input"
					$viLog:=1
					
				: ($viType=Object type unknown:K79:1)
					$vtType:="unknown"
					
				: ($viType=Object type web area:K79:41)
					$vtType:="web area"
					
				: ($viType=Object type write pro area:K79:42)
					$vtType:="write pro area"
					
			End case 
			
			If ($viLog=1)
				
				$vtFont:=""
				$vtFont:=OBJECT Get font:C1069(*; atObjectNames{$vi3})
				//OBJECT SET FONT(*;vtObjectName;"Lucida Sans Regular")
				$vtStyle:=""
				$vtStyle:=OBJECT Get style sheet:C1258(*; atObjectNames{$vi3})
				
				//OBJECT SET STYLE SHEET(*;vtObjectName;"10ptPopups")
				
				If ($vtFont="")
					RESOLVE POINTER:C394(apVariables{$vi3}; vtVarName; viTableNum; viFieldNum)
					Case of 
							
						: ((vtVarName="") & (viTableNum=0) & (viFieldNum=0))  // nil pointer not a variable or field
							
							vtVarName:=OBJECT Get title:C1068(*; atObjectNames{$vi3})
							vtVarName:=Txt_Clean(vtVarName; " ")
							
							vtVarName:=Substring:C12(vtVarName; 1; 40)
							ConsoleMessage(atTableTitles{$vi1}+"\t"+atFormNames{$vi2}+"\t"+atObjectNames{$vi3}+"\t"+vtVarName+"\t"+String:C10(aiPages{$vi3})+"\t"+$vtStyle+"\t"+$vtFont+"\t"+$vtType)
							
							
						: ((vtVarName#"") & (viTableNum=-1) & (viFieldNum=-1))  // variable or array
							ConsoleMessage(atTableTitles{$vi1}+"\t"+atFormNames{$vi2}+"\t"+atObjectNames{$vi3}+"\t"+vtVarName+"\t"+String:C10(aiPages{$vi3})+"\t"+$vtStyle+"\t"+$vtFont+"\t"+$vtType)
							
						: ((vtVarName#"") & (viTableNum>0) & (viFieldNum=-1))  // array element
							
						: ((vtVarName#"") & (viTableNum>0) & (viFieldNum>0))  // 2D Array Element
							
						: ((vtVarName="") & (viTableNum>0) & (viFieldNum=0))  // Table
							
						: ((vtVarName="") & (viTableNum>0) & (viFieldNum>0))  // Field
							ConsoleMessage(atTableTitles{$vi1}+"\t"+atFormNames{$vi2}+"\t"+atObjectNames{$vi3}+"\t"+Field name:C257(apVariables{$vi3})+"\t"+String:C10(aiPages{$vi3})+"\t"+$vtStyle+"\t"+$vtFont+"\t"+$vtType)
							
					End case 
					
				End if 
				
			End if 
			
		End for 
		
		
		FORM UNLOAD:C1299  //do not forget to unload the form
		
	End for 
	
End for 

// debug copy object names and page numbers
If (<>viDebugMode>410)
	// expand this to loop through the arrays And fill in the data like the alert above
	ARRAY TEXT:C222(atNames; 0)
	ARRAY LONGINT:C221(aiNums; 0)
	COPY ARRAY:C226(atObjectNames; atNames)
	COPY ARRAY:C226(aiPages; aiNums)
	SORT ARRAY:C229(atNames; aiNums; >)
	vText:=""
	For ($vi1; 1; Size of array:C274(atNames))
		vText:=vText+(atNames{$vi1}+"\t"+String:C10(aiNums{$vi1})+"\r")
	End for 
	SET TEXT TO PASTEBOARD:C523(vText)
	ConsoleMessage(vText)
End if 

ALERT:C41("Done")