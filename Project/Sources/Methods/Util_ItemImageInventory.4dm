//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/20/11, 03:11:09
// ----------------------------------------------------
// Method: Method: Util_ItemImageInventory
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($i; $k; $myOK)
If (vHeve<2)
	$k:=Records in selection:C76([Item:4])
Else 
	$k:=1
	$myOK:=1
End if 
If ($k>1)
	myDocName:=""
	$myOK:=EI_CreateDoc(->myDocName; ->myDoc; "")
	FIRST RECORD:C50([Item:4])
End if 
QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8="Document"; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="Admin")
C_TEXT:C284($imagePath; $imageTNPath; $imagePathScript; $imageTNPathScript)
If (Records in selection:C76([TallyMaster:60])=1)
	$imagePathScript:=[TallyMaster:60]script:9
	$imageTNPathScript:=[TallyMaster:60]build:6
	REDUCE SELECTION:C351([TallyMaster:60]; 0)
End if 
$i:=0
If ($myOK=1)
	Repeat 
		$i:=$i+1
		ExecuteText(0; $imagePathScript)
		$imagePathScript:=iLoText1
		ExecuteText(0; $imagePathScript)
		$imagePathScript:=iLoText2
		
		
		
		If ($k>1)
			SEND PACKET:C103(myDoc; [Item:4]itemNum:1+"\t"+"Image"+"\t"+$imagePath)
			
			
			NEXT RECORD:C51([Item:4])
		End if 
	Until ($i=$k)
	
End if 