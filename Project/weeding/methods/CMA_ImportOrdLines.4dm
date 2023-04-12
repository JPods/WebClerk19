//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/28/10, 01:17:43
// ----------------------------------------------------
// Method: CMA_ImportOrdLines
// Description
// 
//
// Parameters
// ----------------------------------------------------

UNLOAD RECORD:C212([Order:3])
UNLOAD RECORD:C212([OrderLine:49])
UNLOAD RECORD:C212([Customer:2])
UNLOAD RECORD:C212([Item:4])
CONFIRM:C162("Import File")
//CLOSE DOCUMENT(myDoc)
C_TEXT:C284($thePath; $destPath; $1)
If (Count parameters:C259>0)
	
Else 
	$thePath:=Storage:C1525.folder.jitF+"ImportOrderLines"+Folder separator:K24:12
End if 
C_LONGINT:C283($pathOK)
$pathOK:=Test path name:C476($thePath)
If ($pathOK<1)  //make sure the structure of folders is in place
	CREATE FOLDER:C475($thePath)
End if 
$pathOK:=Test path name:C476($thePath+"Processed")
If ($pathOK<1)
	CREATE FOLDER:C475($thePath+"Processed")
End if 
C_BOOLEAN:C305($failedDocs)

$failedDocs:=False:C215
myDoc:=Open document:C264($thePath+"header.txt")
If (OK=1)
	CLOSE DOCUMENT:C267(myDoc)
	myDoc:=Open document:C264($thePath+"lines.txt")
	If (OK=1)
		CLOSE DOCUMENT:C267(myDoc)
		$doDocs:=True:C214
	End if 
End if 

If ($failedDocs)
	ALERT:C41("There be both a 'header.txt' and 'lines.txt' in the 'OrderMaster' folder.")
Else 
	$destPath:=$thePath+"Processed"+Folder separator:K24:12+Date_strYrMmDd
	$pathOK:=Test path name:C476($destPath)
	If ($pathOK<1)
		CREATE FOLDER:C475($destPath)
	End if 
	myDoc:=Open document:C264($thePath+"header.txt")
	C_LONGINT:C283($currentDT)
	$currentDT:=DateTime_DTTo
	C_TEXT:C284($strOM_Date)
	$strOM_Date:="OM_"+String:C10(Current date:C33)
	C_LONGINT:C283($incImport)
	$incImport:=1
	ARRAY LONGINT:C221($aListOrderNums; 0)
	RECEIVE PACKET:C104(myDoc; $theText; "\r")
	TextToArray($theText; ->aText1)
	Repeat 
		RECEIVE PACKET:C104(myDoc; $theText; "\r")
		If (OK=1)
			TextToArray($theText; ->aText2)
			
			C_LONGINT:C283($incRay; $cntRay)
			$cntRay:=Size of array:C274(aText2)
			For ($incRay; 1; $cntRay)
				aText2{$incRay}:=Txt_TrimSpaces(aText2{$incRay})
			End for 
			//make a field matching document and a 
			
			CREATE RECORD:C68([Order:3])
			
			C_BOOLEAN:C305($foundCustomer)
			$noCustomer:=True:C214
			Execute_TallyMaster("OrderImport"; "OrderMaster"; 5)
			aText2{13}:=Replace string:C233(aText2{13}; " "; "")
			ParsePhone(aText2{16}; ->aText2{16}; <>tcLocalArea)
			If (aText2{13}#"")
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=aText2{13})
				If (Records in selection:C76([Customer:2])=1)
					$noCustomer:=False:C215
				End if 
				If (($noCustomer) & (aText2{16}#""))
					QUERY:C277([Customer:2]; [Customer:2]phone:13=aText2{16})
					If (Records in selection:C76([Customer:2])>1)
						$noCustomer:=False:C215
					End if 
				End if 
			End if 
			If ($noCustomer)
				CREATE RECORD:C68([Customer:2])
				DB_InitCustomer
				Execute_TallyMaster("CustomerCreate"; "OrderMaster"; 5)
				[Customer:2]dateOpened:14:=Current date:C33
				[Customer:2]profile5:30:=$strOM_Date
				SAVE RECORD:C53([Customer:2])
			End if 
			Execute_TallyMaster("CustomerImport"; "OrderMaster"; 5)
			SAVE RECORD:C53([Customer:2])
			Execute_TallyMaster("OrderClose"; "OrderMaster"; 5)
			[Order:3]customerID:1:=[Customer:2]customerID:1
			[Order:3]idNum:2:=CounterNew(->[Order:3])
			[Order:3]profile1:61:=aText2{1}
			[Order:3]profile5:104:=$strOM_Date
			[Order:3]approvedBy:115:=[Order:3]profile5:104
			SAVE RECORD:C53([Order:3])
			APPEND TO ARRAY:C911($aListOrderNums; [Order:3]idNum:2)
		End if 
	Until (OK=0)
	CLOSE DOCUMENT:C267(myDoc)
	MOVE DOCUMENT:C540(document; $destPath+Folder separator:K24:12+"header"+String:C10(Current time:C178%60)+".txt")
	
	UNLOAD RECORD:C212([Order:3])
	UNLOAD RECORD:C212([Customer:2])
	myDoc:=Open document:C264($thePath+"lines.txt")
	C_LONGINT:C283($sequenceNum)
	RECEIVE PACKET:C104(myDoc; $theText; "\r")
	TextToArray($theText; ->aText1)
	Repeat 
		RECEIVE PACKET:C104(myDoc; $theText; "\r")
		If (OK=1)
			TextToArray($theText; ->aText2)
			//make a field matching document and a 
			C_LONGINT:C283($incRay; $cntRay)
			$cntRay:=Size of array:C274(aText2)
			For ($incRay; 1; $cntRay)
				aText2{$incRay}:=Txt_TrimSpaces(aText2{$incRay})
			End for 
			If ([Order:3]profile1:61=aText2{1})
				$sequenceNum:=$sequenceNum+1
			Else 
				QUERY:C277([Order:3]; [Order:3]profile1:61=aText2{2})
				$sequenceNum:=1
			End if 
			CREATE RECORD:C68([OrderLine:49])
			
			[OrderLine:49]lineNum:3:=[OrderLine:49]idNum:50
			[OrderLine:49]seq:30:=[OrderLine:49]idNum:50
			[OrderLine:49]idNumOrder:1:=[Order:3]idNum:2
			
			[OrderLine:49]lineProfile1:45:=aText2{1}
			Before_New(->[OrderLine:49])
			//aText2{7}:=Replace string(aText2{7};" ";"")  //this is a problem in customerID
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aText2{7})
			If (Records in selection:C76([Item:4])=0)
				CREATE RECORD:C68([Item:4])
				[Item:4]itemNum:1:=aText2{7}
				Before_New(->[Item:4])
				
				
				
				Execute_TallyMaster("ItemCreate"; "OrderMaster"; 5)
				
				[Item:4]dtItemDate:33:=$currentDT
				[Item:4]profile5:93:=$strOM_Date
				SAVE RECORD:C53([Item:4])
			End if 
			Execute_TallyMaster("OrderLineImport"; "OrderMaster"; 5)
			//[OrderLine]obItem:=$strOM_Date
			SAVE RECORD:C53([OrderLine:49])
			C_LONGINT:C283($incImport)
			If ($incImport>935)
				
			End if 
			$incImport:=$incImport+1
		End if 
	Until (OK=0)
	allowAlerts_boo:=False:C215
	C_LONGINT:C283($cntRay; $incRec)
	$cntRay:=Size of array:C274($aListOrderNums)
	For ($incRec; 1; $cntRay)
		QUERY:C277([Order:3]; [Order:3]idNum:2=$aListOrderNums{$incRec})
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
		QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
		OptKey:=1
		
		
		booAccept:=True:C214
		acceptOrders
		Execute_TallyMaster("OrderFinal"; "OrderMaster"; 5)
	End for 
	allowAlerts_boo:=True:C214
	CLOSE DOCUMENT:C267(myDoc)
	
	QUERY:C277([Order:3]; [Order:3]profile5:104=$strOM_Date)
	ProcessCurrentSelection(->[Order:3])
	DELAY PROCESS:C323(Current process:C322; 120)
	QUERY:C277([Item:4]; [Item:4]profile5:93=$strOM_Date)
	ProcessCurrentSelection(->[Item:4])
	DELAY PROCESS:C323(Current process:C322; 120)
	QUERY:C277([OrderLine:49]; [OrderLine:49]obItem:47=$strOM_Date)
	ProcessCurrentSelection(->[OrderLine:49])
	DELAY PROCESS:C323(Current process:C322; 120)
	QUERY:C277([Customer:2]; [Customer:2]profile5:30=$strOM_Date)
	ProcessCurrentSelection(->[Customer:2])
	
	UNLOAD RECORD:C212([Order:3])
	UNLOAD RECORD:C212([OrderLine:49])
	UNLOAD RECORD:C212([Customer:2])
	UNLOAD RECORD:C212([Item:4])
End if 



