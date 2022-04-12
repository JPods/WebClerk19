//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/17/18, 01:34:11
// ----------------------------------------------------
// Method: ItemNumChange
// Description
// 
//
// Parameters
// ----------------------------------------------------


//
//TRACE
If (Count parameters:C259=1)
	srItemNum:=$1
End if 
C_TEXT:C284(srItemNum; $1)
C_LONGINT:C283($curRec)
C_BOOLEAN:C305($doCombine)
CONFIRM:C162("Also change history?"; "ChangeHistory"; "OnlyThisRecord")
If (OK=0)
	[Item:4]itemNum:1:=srItemNum
Else 
	KeyModifierCurrent
	$curRec:=Record number:C243([Item:4])
	If ($curRec>-1)
		If (<>viDebugMode>410)
			ConsoleMessage("Pushing ItemChange")
		End if 
		PUSH RECORD:C176([Item:4])
		QUERY:C277([Item:4]; [Item:4]itemNum:1=srItemNum)
		Case of 
			: (($curRec=-3) & (Records in selection:C76([Item:4])=0))
				POP RECORD:C177([Item:4])
				[Item:4]itemNum:1:=srItemNum
				If (<>viDebugMode>410)
					ConsoleMessage("ItemNum Pop Record")
				End if 
			: (($curRec=-3) & (Records in selection:C76([Item:4])=1))
				POP RECORD:C177([Item:4])
				jAlertMessage(-9998)
				srItemNum:=""
			: (($curRec>-1) & (OptKey=1) & (Records in selection:C76([Item:4])=1))  //
				
				If (<>viDebugMode>410)
					ConsoleMessage("ItemNum ConsolidateRecs One Record")
				End if 
				POP RECORD:C177([Item:4])
				$doCombine:=ConsolidateRecs(->[Item:4]; ->[Item:4]itemNum:1; ->srItemNum)
				//jrelateClrFiles 
				If ($doCombine)
					DELETE RECORD:C58([Item:4])
					jCancelButton(False:C215)
				Else 
					srItemNum:=[Item:4]itemNum:1
				End if 
			: (Records in selection:C76([Item:4])=0)
				If (<>viDebugMode>410)
					ConsoleMessage("ItemNum ConsolidateRecs No Records")
				End if 
				POP RECORD:C177([Item:4])
				$doCombine:=ConsolidateRecs(->[Item:4]; ->[Item:4]itemNum:1; ->srItemNum)
				If ($doCombine)
					[Item:4]itemNum:1:=srItemNum
					SAVE RECORD:C53([Item:4])
				Else 
					srItemNum:=[Item:4]itemNum:1
				End if 
			Else   //accept new item number
				BEEP:C151
				BEEP:C151
				POP RECORD:C177([Item:4])
				srItemNum:=[Item:4]itemNum:1
		End case 
		If ([Item:4]barCode:34="")
			[Item:4]barCode:34:=srItemNum
		End if 
		If ([Item:4]ean:82="")
			[Item:4]ean:82:=srItemNum
		End if 
		If ([Item:4]mfrItemNum:39="")
			[Item:4]mfrItemNum:39:=srItemNum
		End if 
		If ([Item:4]vendorItemNum:40="")
			[Item:4]vendorItemNum:40:=srItemNum
		End if 
	End if 
End if 