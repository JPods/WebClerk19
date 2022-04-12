//%attributes = {"publishedWeb":true}

//Modified by: Bill James(2015-12-16T00:00:00 Convert_2_v14)


If (False:C215)
	//Method: XRef_BuildFromRay
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

$k:=Size of array:C274(<>aItemLines)
If ($k>0)
	C_TEXT:C284($curItemNum)
	CREATE SET:C116([Item:4]; "Current")
	$curItemNum:=[Item:4]itemNum:1
	//Procedure: BOM_AddChildren
	C_LONGINT:C283($i; $k; $curRecNum)
	C_TEXT:C284($curItemNum)
	C_TEXT:C284($curItemDesc)
	$curRecNum:=Record number:C243([Item:4])
	$curItemNum:=[Item:4]itemNum:1
	$curItemDesc:=[Item:4]description:7
	
	
	//PUSH RECORD([Item])
	For ($i; 1; $k)
		GOTO RECORD:C242([Item:4]; <>aLsSrRec{<>aItemLines{$i}})
		If ($curItemNum=[Item:4]itemNum:1)
			BEEP:C151
			BEEP:C151
		Else 
			CREATE RECORD:C68([ItemXRef:22])
			XRefItem_Fill($curItemNum; $curItemDesc)
			SAVE RECORD:C53([ItemXRef:22])
		End if 
	End for 
	//POP RECORD([Item])
	GOTO RECORD:C242([Item:4]; $curRecNum)
	QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumMaster:1=$curItemNum)
	
End if 

// ALL SUBRECORDS([Item]RelatedDetails)
// $doRelated:=True
// $k:=Records in sub_selection([Item]RelatedDetails)
// FIRST SUBRECORD([Item]RelatedDetails)
// For ($i;1;$k)
// If (=22)
// $doRelated:=False
// End if 
// NEXT SUBRECORD([Item]RelatedDetails)
// End for 
// If ($doRelated)
// CREATE SUBRECORD([Item]RelatedDetails)
// :=22
// End if 
// SAVE RECORD([Item])
// Else 
// ALERT("Use Quick Quotes to select items.")
// End if 

