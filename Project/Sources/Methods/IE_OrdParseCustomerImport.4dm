//%attributes = {"publishedWeb":true}
If (False:C215)
	//PM:     IE_OrdParseCustomerImport 
	//Desc.:  Parse passed text for [Customer] import
	//NB:      
	//CB:      IE_OrdImportCustomers
	//New:    04/11/2000.nds   
End if 

C_LONGINT:C283($1; $lIndice)
$lIndice:=$1

C_TEXT:C284($incustomerID)  //(Char(10), customerID) = $incustomerID
$incustomerID:=Substring:C12(IE_OrdFindFieldPtrInArray((->[Customer:2]customerID:1); ->aptCustomerFieldPointers; ->atCustomerImport{$lIndice})->; 1; 10)

QUERY:C277([Customer:2]; [Customer:2]customerID:1=$incustomerID)

C_BOOLEAN:C305($NewCustomer)
$NewCustomer:=False:C215

C_TEXT:C284($inCustPhone)  //(Char(10), customerID) = $inCustPhone
$inCustPhone:=Substring:C12(Txt_StripCharsFromNum(IE_OrdFindFieldPtrInArray((->[Customer:2]phone:13); ->aptCustomerFieldPointers; ->atCustomerImport{$lIndice})->); 1; 20)
C_TEXT:C284($inCustLastName)
$inCustLastName:=Substring:C12(IE_OrdFindFieldPtrInArray((->[Customer:2]nameLast:23); ->aptCustomerFieldPointers; ->atCustomerImport{$lIndice})->; 1; 35)
C_TEXT:C284($inCustAddress1)
$inCustAddress1:=Substring:C12(IE_OrdFindFieldPtrInArray((->[Customer:2]address1:4); ->aptCustomerFieldPointers; ->atCustomerImport{$lIndice})->; 1; 40)

If (Records in selection:C76([Customer:2])=1)
	If ((([Customer:2]phone:13#$inCustPhone) & ([Customer:2]phone:13#"")) | (([Customer:2]nameLast:23#$inCustLastName) & ([Customer:2]nameLast:23#"")) | (([Customer:2]address1:4#$inCustAddress1) & ([Customer:2]address1:4#"")))
		REDUCE SELECTION:C351([Customer:2]; 0)  //don't use a customer unless all params either match or are blank
	End if 
End if 

If (Records in selection:C76([Customer:2])#1)
	//dupe checking
	If ($inCustPhone#"")
		QUERY:C277([Customer:2]; [Customer:2]phone:13=$inCustPhone)
	End if 
	
	C_BOOLEAN:C305($MultiPhones; $MultiLNameAddr)
	$MultiPhones:=False:C215
	$MultiLNameAddr:=False:C215
	
	If (Records in selection:C76([Customer:2])#1)
		If (Records in selection:C76([Customer:2])>1)
			$MultiPhones:=True:C214
		End if 
		If ($inCustLastName#"")
			If ($inCustAddress1#"")
				QUERY:C277([Customer:2]; [Customer:2]nameLast:23=Txt_FormatName($inCustLastName); *)
				QUERY:C277([Customer:2];  & ; [Customer:2]address1:4=Txt_FormatName($inCustAddress1))
			End if 
		End if 
		If (Records in selection:C76([Customer:2])>1)
			$MultiLNameAddr:=True:C214
		End if 
		If (Records in selection:C76([Customer:2])=1)
			If (([Customer:2]phone:13#$inCustPhone) & ([Customer:2]phone:13#""))
				REDUCE SELECTION:C351([Customer:2]; 0)  //don't use a customer unless all params either match or are blank
			End if 
		End if 
	Else 
		If (Records in selection:C76([Customer:2])=1)
			If ((([Customer:2]nameLast:23#$inCustLastName) & ([Customer:2]nameLast:23#"")) | (([Customer:2]address1:4#$inCustAddress1) & ([Customer:2]address1:4#"")))
				REDUCE SELECTION:C351([Customer:2]; 0)  //don't use a customer unless all params either match or are blank
			End if 
		End if 
	End if 
	
	If (Records in selection:C76([Customer:2])#1)
		CREATE RECORD:C68([Customer:2])
		DBCustomer_init
		[Customer:2]alertMessage:79:=[Customer:2]alertMessage:79+"Review customer: Imported "+String:C10(Current date:C33; Internal date short:K1:7)
		If ($MultiPhones)
			[Customer:2]alertMessage:79:=[Customer:2]alertMessage:79+"; Dups in Phone Number"
		End if 
		If ($MultiLNameAddr)
			[Customer:2]alertMessage:79:=[Customer:2]alertMessage:79+"; Dups in Last Name, Address1"
		End if 
		$NewCustomer:=True:C214
	End if 
End if 

asIEOrdImportcustomerID{$lIndice}:=$incustomerID
asIEOrdActualcustomerID{$lIndice}:=[Customer:2]customerID:1

If (Not:C34($NewCustomer))
	C_TEXT:C284($AdSource)
	$AdSource:=[Customer:2]adSource:62  //preserve the original AdSource on existing customers
End if 

C_TEXT:C284($customerID)
$customerID:=[Customer:2]customerID:1  //don't let the number from the import file alter the new value

C_TEXT:C284($AuditComment)
$AuditComment:=IE_OrdFillFieldsByPtrArray(->aptCustomerFieldPointers; ->atCustomerImport{$lIndice})

[Customer:2]customerID:1:=$customerID  //don't let the number from the import file alter the new value

If (Not:C34($NewCustomer))
	[Customer:2]comment:15:=$AuditComment+[Customer:2]comment:15  //note the old values in the comment
	[Customer:2]adSource:62:=$AdSource  //preserve the original AdSource on existing customers
End if 
If ([Customer:2]company:2="")
	[Customer:2]company:2:=[Customer:2]nameLast:23+", "+[Customer:2]nameFirst:73
End if 
[Customer:2]action:60:=vtImportUniqueTag
[Customer:2]phone:13:=Txt_StripCharsFromNum([Customer:2]phone:13)
C_LONGINT:C283($pos)
$pos:=Position:C15(Char:C90(64); [Customer:2]email:81)  // suppression @
If ($pos>0)
	[Customer:2]email:81:=Substring:C12([Customer:2]email:81; 1; $pos-1)+"&~"+Substring:C12([Customer:2]email:81; $pos+1)
End if 

SAVE RECORD:C53([Customer:2])

//End of routine