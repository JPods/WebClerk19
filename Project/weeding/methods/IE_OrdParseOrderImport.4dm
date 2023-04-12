//%attributes = {"publishedWeb":true}
If (False:C215)
	//PM:     IE_OrdParseOrderImport 
	//Desc.:  Parse passed text for [Order] import
	//NB:      
	//CB:      IE_OrdImportOrders
	//New:    04/14/2000.nds   
	
	//02/13/03.dmb
	// added credit card type string to TypePayment field
End if 

C_LONGINT:C283($1; $lIndice)
$lIndice:=$1





C_TEXT:C284($incustomerID)  //(Char(10), customerID) = $incustomerID
C_LONGINT:C283($lOrderNum)  //[Order]OrderNum

$incustomerID:=IE_OrdFindFieldPtrInArray((->[Order:3]customerID:1); ->aptOrderFieldPointers; ->atOrderImport{$lIndice})->
$fia:=Find in array:C230(asIEOrdImportcustomerID; $incustomerID)
If ($fia>0)
	$incustomerID:=asIEOrdActualcustomerID{$fia}
Else 
	$incustomerID:=""
End if 
$lOrderNum:=IE_OrdFindFieldPtrInArray((->[Order:3]idNum:2); ->aptOrderFieldPointers; ->atOrderImport{$lIndice})->

QUERY:C277([Customer:2]; [Customer:2]customerID:1=$incustomerID)

Case of 
	: (Records in selection:C76([Customer:2])=1)
		
		EDI_OrdAdd
		C_LONGINT:C283($OrderNum)
		$OrderNum:=[Order:3]idNum:2
		C_TEXT:C284($customerID)
		$customerID:=[Order:3]customerID:1
		
		vsCCNum:=""  //special values that may exist in import, but aren't fields
		vsCCExpire:=""  //blank them here in case they don't appear in data at all
		vrCCAmount:=0
		
		IE_OrdFillFieldsByPtrArray(->aptOrderFieldPointers; ->atOrderImport{$lIndice})
		
		[Order:3]idNum:2:=$OrderNum
		[Order:3]customerID:1:=$customerID
		
		[Order:3]commentProcess:12:=vtImportUniqueTag+"\r"+[Order:3]commentProcess:12
		
		IE_OrdAppendOrdLines($lOrderNum)
		
		EDI_OrdSaveRec  //saves and unloads Orders record
		If ((vsCCNum#"") & (vsCCExpire#""))
			//add payment record     
			QUERY:C277([Order:3]; [Order:3]idNum:2=$OrderNum)
			CREATE RECORD:C68([Payment:28])
			
			[Payment:28]idNumOrder:2:=[Order:3]idNum:2
			[Payment:28]customerID:4:=[Customer:2]customerID:1
			If (vrCCAmount#0)
				[Payment:28]amount:1:=vrCCAmount
				[Payment:28]amountAvailable:19:=vrCCAmount
			Else 
				[Payment:28]amount:1:=[Order:3]total:27
				[Payment:28]amountAvailable:19:=[Order:3]total:27
			End if 
			[Payment:28]creditCardNum:13:=CC_ReturnXedOutCardNum(vsCCNum)
			[Payment:28]creditCardEncode:50:=CC_EncodeDecode(1; vsCCNum; ->[Payment:28]creditCardBlob:53)
			If (Position:C15("/"; vsCCExpire)>0)  //mm/yy
				[Payment:28]dateExpires:14:=Date:C102(Substring:C12(vsCCExpire; 1; 2)+"/1/"+Substring:C12(vsCCExpire; 4; 2))
			Else   //mmyy
				[Payment:28]dateExpires:14:=Date:C102(Substring:C12(vsCCExpire; 1; 2)+"/1/"+Substring:C12(vsCCExpire; 3; 2))
			End if 
			[Payment:28]complete:17:=False:C215
			[Payment:28]typePayment:6:=CC_GetCCTypeString(CC_GetCCTypeConst(vsCCNum))  //set credit card pay type//was "Credit Card"
			[Payment:28]dateDocument:10:=[Order:3]dateDocument:4
			[Payment:28]timeReceived:52:=Current time:C178
			SAVE RECORD:C53([Payment:28])
		End if 
		
		OrdLn_RaySize(-1; 1; Size of array:C274(aoLineAction))  //delete array elements
		
	: (Records in selection:C76([Customer:2])=0)
		// ### bj ### 20210820_1404  --  COMMENTEDOUT because not likely to use the same way
		//ELog_NewRecord(0; atOrderImport{$lIndice}; "Order Import could not find Cust. ID "+$incustomerID)
		ALERT:C41("Error encountered during Order import. Please review Event Log.")
		
	: (Records in selection:C76([Customer:2])>1)
		// ### bj ### 20210820_1404  --  COMMENTEDOUT because not likely to use the same way
		//ELog_NewRecord(0; atOrderImport{$lIndice}; "Order Import found multiple Cust. ID "+$incustomerID)
		ALERT:C41("Error encountered during Order import. Please review Event Log.")
		
End case 

//End of routine
