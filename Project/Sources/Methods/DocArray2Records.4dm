//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: DocArray2Records
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($1; $0; $skipAlert)
$myOK:=-1
$skipAlert:=0
If (Count parameters:C259=1)
	If ($1=1)
		ArraySelectAllAreaList(->aRayLines; ->aHtPage)
		CONFIRM:C162("Save ALL lines to database and folder.")
		$myOK:=OK
		$skipAlert:=1
	End if 
End if 
If ($myOK=-1)
	CONFIRM:C162("Save Selected lines to database.")
	$myOK:=OK
End if 
C_LONGINT:C283($i; $k; $myOK)
C_LONGINT:C283($recID)
If ($myOK=1)
	$k:=Size of array:C274(aRayLines)
	For ($i; 1; $k)
		$recID:=Num:C11(aHtvLink{aRayLines{$i}})
		REDUCE SELECTION:C351([Document:100]; 0)
		If ($recID>9)
			QUERY:C277([Document:100]; [Document:100]idUnique:1=$recID)
		End if 
		If (Records in selection:C76([Document:100])#1)
			CREATE RECORD:C68([Document:100])
			
			aHtvLink{aRayLines{$i}}:=String:C10([Document:100]idUnique:1)
		End if   //
		[Document:100]Title:8:=aHtBkGraf{aRayLines{$i}}
		[Document:100]Description:3:=aHtBkColor{aRayLines{$i}}
		[Document:100]KeyText:11:=aHtLink{aRayLines{$i}}
		[Document:100]ImageName:2:=aHtPage{aRayLines{$i}}
		[Document:100]Path:4:=iLoText1
		[Document:100]PathTN:5:=aHtaLink{aRayLines{$i}}
		[Document:100]ImageName:2:=aHtPage{aRayLines{$i}}
		[Document:100]Event:9:=aHtBody{aRayLines{$i}}
		[Document:100]Publish:12:=Num:C11(aHtReason{aRayLines{$i}})
		[Document:100]CopyrightPath:15:=aHtStyle{aRayLines{$i}}
		SAVE RECORD:C53([Document:100])
	End for 
	If ($skipAlert=0)
		jAlertMessage(17004)
	End if 
End if 
$0:=$myOK