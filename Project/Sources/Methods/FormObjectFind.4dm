//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/14/17, 00:55:49
// ----------------------------------------------------
// Method: FindFormObject
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

vtTableName:=Request:C163("Enter Table Name"; "Customer")
vtFormName:=Request:C163("Enter Form Name"; "Input1")
vtObjectName:=Request:C163("Enter Object Name"; "Field76")

ARRAY TEXT:C222(atTableTitles; 0)
ARRAY LONGINT:C221(aiTableNums; 0)

GET TABLE TITLES:C803(atTableTitles; aiTableNums)
$viTableNum:=Find in array:C230(atTableTitles; vtTableName)

ARRAY TEXT:C222(atFieldTitles; 0)
ARRAY LONGINT:C221(aiFieldNums; 0)

//GET FIELD TITLES(Table($viTableNum)->;atFieldTitles;aiFieldNums)
//$vi6:=Find in array(atFieldTitles;vtObjectName)

FORM LOAD:C1103(Table:C252($viTableNum)->; vtFormName)
//FORM GET PROPERTIES(Table($viTableNum)->;vtFormName;viwidth;viheight;vinumPages)

ARRAY TEXT:C222(atObjectNames; 0)
ARRAY POINTER:C280(apVariables; 0)
ARRAY LONGINT:C221(aiPages; 0)

// selection of form without execution of events or methods
FORM GET OBJECTS:C898(atObjectNames; apVariables; aiPages; 2)
vi6:=Find in array:C230(atObjectNames; vtObjectName)
If (vi6=-1)
	vi6:=Find in array:C230(apVariables; Get pointer:C304(vtObjectName))
	vtObjectName:=atObjectNames{vi6}
End if 


If (vi6>0)
	RESOLVE POINTER:C394(apVariables{vi6}; vtVarName; viTableNum; viFieldNum)
	If (viFieldNum#-1)
		ALERT:C41("Table:\t\t"+vtTableName+"\rForm:\t\t"+vtFormName+"\rObject:\t\t"+vtObjectName+"\rField:\t\t"+Field name:C257(apVariables{vi6})+"\rPage:\t\t"+String:C10(aiPages{vi6}))
	Else 
		ALERT:C41("Table:\t\t"+vtTableName+"\rForm:\t\t"+vtFormName+"\rObject:\t\t"+vtObjectName+"\rVariable:\t"+vtVarName+"\rPage:\t\t"+String:C10(aiPages{vi6}))
		
	End if 
Else 
	ALERT:C41("Table:\t\t"+vtTableName+"\rForm:\t\t"+vtFormName+"\rObject:\t\t"+vtObjectName+"\rVariable:\t"+vtVarName+"\rPage:\t\t"+"NOT FOUND")
End if 

OBJECT SET FONT:C164(*; vtObjectName; "Arial")

FORM UNLOAD:C1299  //do not forget to unload the form

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
	ConsoleLog(vText)
End if 
