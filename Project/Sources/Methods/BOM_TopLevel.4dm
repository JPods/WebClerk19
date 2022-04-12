//%attributes = {"publishedWeb":true}
//Procedure BOM_TopLevel
//Peter Fleming
//01/05/02

C_BOOLEAN:C305(NoItemHadParent)
NoItemHadParent:=True:C214
ARRAY TEXT:C222(<>aTopLevelItem; 0)

If (Records in selection:C76([Item:4])>0)
	
	FIRST RECORD:C50([Item:4])
	
	For ($i; 1; Records in selection:C76([Item:4]))
		BOM_TopLevelLoop
		NEXT RECORD:C51([Item:4])
	End for 
	
	If (NoItemHadParent)
		ALERT:C41("Item(s) have no parents.")
	Else 
		<>ptCurTable:=->[Item:4]
		<>prcControl:=0
		C_TEXT:C284($theName)
		$theName:=String:C10(Count user processes:C343)+Table name:C256(<>ptCurTable)
		<>processAlt:=New process:C317("Prs_ShowItems"; <>tcPrsMemory; $theName; Current process:C322)
		Prs_ListActive
	End if 
	
Else 
	ALERT:C41("No Items in selection.")
End if 
