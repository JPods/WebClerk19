//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/19/21, 10:01:16
// ----------------------------------------------------
// Method: POIP_AddItem
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE($viAreaList : Real)
//eItemOrd

C_LONGINT:C283($i; $k)
KeyModifierCurrent
//  CHOPPED  $error:=AL_GetSelect($viAreaList; aItemLines)
$k:=Size of array:C274(aItemLines)
For ($i; 1; $k)
	Case of 
		: (OptKey=1)
			//TRACE
			READ WRITE:C146([Item:4])
			If (aLsSrRec{aItemLines{$i}}<0)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=aLsItemNum{aItemLines{$i}})
			Else 
				GOTO RECORD:C242([Item:4]; aLsSrRec{aItemLines{$i}})
			End if 
			UNLOAD RECORD:C212([Item:4])
			ProcessTableOpen(Table:C252(->[Item:4])*-1)
			//doItemList:=True
		: (Size of array:C274(aLsSrRec)=0)
			//drop out      
			TRACE:C157
		: (aLsSrRec{aItemLines{$i}}>-1)
			GOTO RECORD:C242([Item:4]; aLsSrRec{aItemLines{$i}})
			listItemsFill(ptCurTable; True:C214)
		Else 
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aLsItemNum{aItemLines{$i}})
			listItemsFill(ptCurTable; True:C214)
	End case 
End for 
