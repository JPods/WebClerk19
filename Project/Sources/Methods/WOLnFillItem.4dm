//%attributes = {"publishedWeb":true}
//Procedure: WOLnFillItem
C_TEXT:C284($1; $myItemNum)
C_LONGINT:C283($2; $myTask)
//TRACE
Case of 
	: (Count parameters:C259=0)
		$myItemNum:=""
		$myTask:=-5
	: (Count parameters:C259=1)
		$myItemNum:=$1
		$myTask:=-5
	Else 
		$myItemNum:=$1
		$myTask:=$2
End case 
TRACE:C157
Case of 
	: (($myTask=-3) & (Records in selection:C76([Item:4])=1))
		$myTask:=1
	: ($myItemNum#"")
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$myItemNum+"@")
		If (Records in selection:C76([Item:4])=1)
			$myTask:=1
		Else 
			$myTask:=-5
		End if 
	Else 
		$myTask:=-5
End case 
If ($myTask=1)
	pPartNum:=[Item:4]itemNum:1
	If ([Item:4]unitOfMeasure:11="ByLine@")
		//Qx_PriceThis
	Else 
		vUseBase:=SetPricePoint([Customer:2]typeSale:18)
		[WorkOrder:66]woPrice:47:=Field:C253(4; vUseBase)->  //[Item]PriceA*$cntLines  
	End if 
	[WorkOrder:66]unitCost:19:=[Item:4]costAverage:13
	[WorkOrder:66]costPlanned:15:=[Item:4]costLastInShip:47
	[WorkOrder:66]itemDescript:34:=[Item:4]description:7
	[WorkOrder:66]itemNum:12:=[Item:4]itemNum:1
	C_BOOLEAN:C305($doProfiles)
	If (([WorkOrder:66]profile1:37#"") | ([WorkOrder:66]profile2:38#"") | ([WorkOrder:66]profile3:39#"") | ([WorkOrder:66]profile4:40#""))
		CONFIRM:C162("Keep Existing Profiles")
		If (OK=0)
			$doProfiles:=True:C214
		End if 
	End if 
	If ($doProfiles)
		[WorkOrder:66]profile1:37:=[Item:4]profile1:35
		[WorkOrder:66]profile2:38:=[Item:4]profile2:36
		[WorkOrder:66]profile3:39:=[Item:4]profile3:37
		[WorkOrder:66]profile4:40:=[Item:4]profile4:38
	End if 
	If ([WorkOrder:66]qtyOrdered:13=0)
		[WorkOrder:66]qtyOrdered:13:=[Item:4]qtySaleDefault:15
	End if 
	[WorkOrder:66]mfrID:41:=[Item:4]mfrID:53
	[WorkOrder:66]mfrItemNum:42:=[Item:4]mfrItemNum:39
	pPartNum:=[WorkOrder:66]itemNum:12
	C_BOOLEAN:C305($doSpec)
	$doSpec:=True:C214
	KeyModifierCurrent
	If (OptKey=1)
		If ([Item:4]specid:62="")
			QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]itemNum:1)
		Else 
			QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]specid:62)
		End if 
		If (Records in selection:C76([ItemSpec:31])=1)
			[WorkOrder:66]description:3:=[ItemSpec:31]specification:2
			[WorkOrder:66]description:3:=Txt_jitConvert([WorkOrder:66]description:3)
			UNLOAD RECORD:C212([ItemSpec:31])
		End if 
	End if 
	UNLOAD RECORD:C212([Item:4])
Else 
	<>ptCurTable:=(->[Item:4])
	CREATE SET:C116(<>ptCurTable->; "<>curSelSet")
	//ptCurFile:=(->[Item])
	C_TEXT:C284(<>vItemNum)
	<>vItemNum:=pPartNum
	QuoteQuick
	ptCurTable:=(->[WorkOrder:66])
	//$found:=Prs_CheckRunnin ("QuickQuote")
	//If ($found>0)
	//BRING TO FRONT($found)
	//
	//End if 
	//End if 
End if 