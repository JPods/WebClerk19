//%attributes = {"publishedWeb":true}
//Procedure BOM_TopLevelCurRec
//Peter Fleming
//01/10/02

ARRAY TEXT:C222(<>aTopLevelItem; 0)
NoItemHadParent:=True:C214

BOM_TopLevelLoop

If (NoItemHadParent)
	ALERT:C41("Item has no parents.")
Else 
	
	<>ptCurTable:=->[Item:4]
	<>prcControl:=0
	C_TEXT:C284($theName)
	$theName:=String:C10(Count user processes:C343)+Table name:C256(<>ptCurTable)
	<>processAlt:=New process:C317("Prs_ShowItems"; <>tcPrsMemory; $theName)
	Process_ListActive
	
End if 

If (False:C215)  //### jwm ### 20120109_1115 commented out change by Bill (did not work)
	//Procedure BOM_TopLevelCurRec
	//Peter Fleming
	//01/10/02
	//testThis
	ARRAY TEXT:C222(<>aTopLevelItem; 0)
	NoItemHadParent:=True:C214
	
	BOM_TopLevelLoop
	
	If (NoItemHadParent)
		ALERT:C41("Item has no parents.")
	Else 
		DB_ShowCurrentSelection(->[Item:4]; ""; 1; "")
	End if 
End if 

