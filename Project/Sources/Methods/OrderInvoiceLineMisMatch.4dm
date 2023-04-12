//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/22/07, 12:23:04
// ----------------------------------------------------
// Method: OrderInvoiceLineMisMatch
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($okToSave; $0)
C_LONGINT:C283($i; $k)
$okToSave:=True:C214
C_TEXT:C284($errList)
C_LONGINT:C283(<>viNoLineCheck)
//<>viNoLineCheck:=0
Case of 
	: (<>viNoLineCheck=0)
		$okToSave:=True:C214
	: (ptCurTable=(->[Order:3]))
		$k:=Size of array:C274(aoUniqueID)
		If ($k>0)
			For ($i; 1; $k)
				If (aoLineAction{$i}>-3)
					QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=aoUniqueID{$i})
					If (Records in selection:C76([OrderLine:49])#1)
						If ($errList="")
							$errList:=String:C10([Order:3]idNum:2)+"\t"+String:C10(Num:C11(booSorted))
						End if 
						TRACE:C157
						$errList:=$errList+"\r"+"[OrderLine]UniqueID missing"+"\t"+String:C10(aoUniqueID{$i})
					Else 
						If ([OrderLine:49]idNumOrder:1#[Order:3]idNum:2)
							If ($errList="")
								$errList:=String:C10([Order:3]idNum:2)+"\t"+String:C10(Num:C11(booSorted))
							End if 
							TRACE:C157
							$errList:=$errList+"\r"+"[OrderLine]OrderNum Mismatch"+"\t"+String:C10([OrderLine:49]idNumOrder:1)
						End if 
					End if 
				End if 
			End for 
			
			If ($errList#"")
				CREATE RECORD:C68([TallyResult:73])
				
				[TallyResult:73]dtCreated:11:=DateTime_DTTo
				[TallyResult:73]dtReport:12:=[TallyResult:73]dtCreated:11
				
				// Modified by: Bill James (2022-12-09T06:00:00Z)
				// mush fix and adjust to data type and object
				//[TallyResult]data:=3
				[TallyResult:73]name:1:="MisMatchOrder"
				[TallyResult:73]salesNameID:31:=Current user:C182
				[TallyResult:73]textBlk1:5:=$errList
				[TallyResult:73]longint1:7:=[Order:3]idNum:2
				[TallyResult:73]nameLong1:24:="[Order]OrderNum"
				SAVE RECORD:C53([TallyResult:73])
				$okToSave:=False:C215
			Else 
				$okToSave:=True:C214
			End if 
		Else 
			$okToSave:=True:C214
		End if 
		
	: (ptCurTable=(->[Invoice:26]))
		$k:=Size of array:C274(aiUniqueID)
		If ($k>0)
			For ($i; 1; $k)
				If (aiLineAction{$i}>-3)
					QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNum:47=aiUniqueID{$i})
					If (Records in selection:C76([InvoiceLine:54])#1)
						If ($errList="")
							$errList:=String:C10([Order:3]idNum:2)+"\t"+String:C10([Invoice:26]idNumOrder:1)+"\t"+String:C10([Invoice:26]idNum:2)+"\t"+String:C10(Num:C11(booSorted))
						End if 
						TRACE:C157
						$errList:=$errList+"\r"+"[InvoiceLine]UniqueID missing"+"\t"+String:C10(aoUniqueID{$i})
					Else 
						If ([InvoiceLine:54]idNumInvoice:1#[Invoice:26]idNum:2)
							If ($errList="")
								$errList:=String:C10([Order:3]idNum:2)+"\t"+String:C10([Invoice:26]idNumOrder:1)+"\t"+String:C10([Invoice:26]idNum:2)+"\t"+String:C10(Num:C11(booSorted))
							End if 
							TRACE:C157
							$errList:=$errList+"\r"+"[InvoiceLine]InvoiceNum Mismatch"+"\t"+String:C10([InvoiceLine:54]idNumInvoice:1)
						End if 
					End if 
				End if 
			End for 
			
			If ($errList#"")
				CREATE RECORD:C68([TallyResult:73])
				
				[TallyResult:73]dtCreated:11:=DateTime_DTTo
				[TallyResult:73]dtReport:12:=[TallyResult:73]dtCreated:11
				
				// Modified by: Bill James (2022-12-09T06:00:00Z)
				// mush fix and adjust to data type and object
				//[TallyResult]data:=Table(->[Invoice])
				[TallyResult:73]name:1:="MisMatchInvoice"
				[TallyResult:73]salesNameID:31:=Current user:C182
				[TallyResult:73]textBlk1:5:=$errList
				[TallyResult:73]longint1:7:=[Order:3]idNum:2
				//[TallyResult]report:=[Invoice]idNum
				[TallyResult:73]nameLong1:24:="[Order]OrderNum"
				[TallyResult:73]nameLong2:25:="[Invoice]InvoiceNum"
				SAVE RECORD:C53([TallyResult:73])
				
				$okToSave:=False:C215
			Else 
				$okToSave:=True:C214
			End if 
		Else 
			$okToSave:=True:C214
		End if 
End case 


If (Not:C34($okToSave))
	If (<>viNoLineCheck=5)
		CONFIRM:C162("Allow MisMatchOpen")
		$okToSave:=(OK=1)
	End if 
	If (Not:C34($okToSave))
		ALERT:C41("Cancel, documentID Mismatch")
		If (Storage:C1525.user.securityLevel<5000)
			jCancelButton
		End if 
	End if 
End if 
$0:=$okToSave