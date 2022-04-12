//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/28/11, 08:56:40
// ----------------------------------------------------
// Method: Method: RepTimeOut
// Description
// 
//
// Parameters
// ----------------------------------------------------

Storage:C1525.user.securityLevel:=5000  //force for testing

$testingReturns:=False:C215

$myPathOut:=Storage:C1525.folder.jitF
//If there is not a data exchange folder create one
C_TEXT:C284($myPathOut; $myPathIn; $myPathCompleted; $myPathOut)
C_LONGINT:C283($result)
QUERY:C277([Map:84]; [Map:84]purpose:5="RepTimeOut"; *)
QUERY:C277([Map:84];  & [Map:84]name:6="ExportPath"; *)
If (Records in selection:C76([Map:84])=1)
	$myPathOut:=[Map:84]path:3
Else 
	$myPathOut:=Storage:C1525.folder.jitF+"RepTimeFromWebClerk"+Folder separator:K24:12
	If (False:C215)
		If (Is macOS:C1572)
			$myPathOut:=Storage:C1525.folder.jitF+"RepTimeFromWebClerk"
		Else 
			$myPathOut:="C:\repTime\repTimePad\\InfoIn"
		End if 
	End if 
End if 
$result:=Test path name:C476($myPathOut)
If ($result#0)
	CREATE FOLDER:C475($myPathOut)
End if 


If (False:C215)
	$myDocName:=$myPathOut+"import_order.xml"
	If (Test path name:C476($myDocName)#1)
		Execute_TallyMaster("export_order"; "RepTimeOut")
		ALL RECORDS:C47([Order:3])
		$k:=Records in selection:C76([Order:3])
		If ($k>0)
			QUERY:C277([Map:84]; [Map:84]purpose:5="RepTimeOut@"; *)
			QUERY:C277([Map:84];  & [Map:84]name:6="export_order")
			
			QUERY:C277([Map:84]; [Map:84]purpose:5="RepTimeOut@"; *)
			QUERY:C277([Map:84];  & [Map:84]name:6="export_order")
			
			QUERY:C277([Map:84]; [Map:84]name:6="export_order")
			
			If (Records in selection:C76([Map:84])=0)
				ALERT:C41("Missing Orders Maps")
			Else 
				myDoc:=Create document:C266($myDocName)
				ORDER BY:C49([Map:84]; [Map:84]seq:18)
				ARRAY LONGINT:C221($aMapRecNum; 0)
				ARRAY LONGINT:C221($aMapFieldNum; 0)
				ARRAY LONGINT:C221($aMapTableNum; 0)
				ARRAY TEXT:C222($aMapTag; 0)
				ARRAY LONGINT:C221($aMapSeq; 0)
				ARRAY TEXT:C222($aMapScript; 0)
				ARRAY TEXT:C222($aMapCatagory; 0)
				SELECTION TO ARRAY:C260([Map:84]; $aMapRecNum; [Map:84]tableNum:15; $aMapTableNum; [Map:84]fieldNum:16; $aMapFieldNum; [Map:84]controllingTag:1; $aMapTag; [Map:84]script:4; $aMapScript; [Map:84]seq:18; $aMapSeq; [Map:84]category:12; $aMapCatagory)
				SORT ARRAY:C229($aMapSeq; $aMapRecNum; $aMapTableNum; $aMapFieldNum; $aMapTag; $aMapScript)
				$cntArray:=Size of array:C274($aMapSeq)
				FIRST RECORD:C50([Order:3])
				SEND PACKET:C103(myDoc; "<OrderList><Order>")
				For ($i; 1; $k)
					For ($incRay; 1; $cntArray)
						If ($aMapCatagory{$incRay}="Script@")
							vText10:=""
							GOTO RECORD:C242([Map:84]; $aMapRecNum{$incRay})
							ExecuteText(0; [Map:84]script:4)
							REDUCE SELECTION:C351([Map:84]; 0)
							If (($aMapTableNum{$incRay}>0) & ($aMapFieldNum{$incRay}>0))
								SEND PACKET:C103(myDoc; "<"+$aMapTag{$incRay}+">"+vText10+"</"+$aMapTag{$incRay}+">")
							End if 
						Else 
							If (($aMapTableNum{$incRay}>0) & ($aMapFieldNum{$incRay}>0))
								SEND PACKET:C103(myDoc; "<"+$aMapTag{$incRay}+">"+Txt_Return2String(Field:C253($aMapTableNum{$incRay}; $aMapFieldNum{$incRay}))+"</"+$aMapTag{$incRay}+">")
							End if 
						End if 
					End for 
					NEXT RECORD:C51([Order:3])
					SEND PACKET:C103(myDoc; "</Order>")
					If ($testingReturns)
						SEND PACKET:C103(myDoc; "\r"+"\r")
					End if 
					If ($i<$k)
						SEND PACKET:C103(myDoc; "<Order>")
					End if 
				End for 
				SEND PACKET:C103(myDoc; "</OrderList>")
				CLOSE DOCUMENT:C267(myDoc)
			End if 
		End if 
	End if 
End if 







//If (False)

If (False:C215)
	$myDocName:=$myPathOut+"import_mfct.xml"
	If (Test path name:C476($myDocName)#1)
		Execute_TallyMaster("export_mfct"; "RepTimeOut")
		If ($testingReturns)
			QUERY:C277([Customer:2]; [Customer:2]mfrLocationid:67<-100)
		End if 
		$cnt:=Records in selection:C76([Customer:2])
		If ($cnt>0)
			
			myDoc:=Create document:C266($myDocName)
			If (OK=1)
				SEND PACKET:C103(myDoc; "<ManufacturerList>")
				
				FIRST RECORD:C50([Customer:2])
				For ($inc; 1; $cnt)
					SEND PACKET:C103(myDoc; "<Manufacturer>")
					SEND PACKET:C103(myDoc; "<FullName>"+[Customer:2]company:2+"</FullName>")
					SEND PACKET:C103(myDoc; "<Mfg4Letter>"+[Customer:2]customerID:1+"</Mfg4Letter>")
					SEND PACKET:C103(myDoc; "<Address1>"+[Customer:2]address1:4+"</Address1>")
					SEND PACKET:C103(myDoc; "<Address2>"+[Customer:2]address2:5+"</Address2>")
					SEND PACKET:C103(myDoc; "<City>"+[Customer:2]city:6+"</City>")
					SEND PACKET:C103(myDoc; "<StateProv>"+[Customer:2]state:7+"</StateProv>")
					SEND PACKET:C103(myDoc; "<ZipPostal>"+[Customer:2]zip:8+"</ZipPostal>")
					SEND PACKET:C103(myDoc; "<PrimaryPhone>"+[Customer:2]phone:13+"</PrimaryPhone>")
					SEND PACKET:C103(myDoc; "</Manufacturer>")
					NEXT RECORD:C51([Customer:2])
					If ($testingReturns)
						SEND PACKET:C103(myDoc; "\r"+"\r")
					End if 
				End for 
				SEND PACKET:C103(myDoc; "</ManufacturerList>"+"\r")
				CLOSE DOCUMENT:C267(myDoc)
			End if 
		End if 
	End if 
End if 

$myDocName:=$myPathOut+"import_cust.xml"
If (Test path name:C476($myDocName)#1)
	
	Execute_TallyMaster("import_cust_search"; "RepTimeOut")
	
	If ($testingReturns)
		QUERY:C277([Customer:2]; [Customer:2]mfrLocationid:67>-1)
	End if 
	ALL RECORDS:C47([Customer:2])
	REDUCE SELECTION:C351([Customer:2]; 10)
	
	myDoc:=Create document:C266($myDocName)
	If (OK=1)
		SEND PACKET:C103(myDoc; "<CustomerList>")
		$cnt:=Records in selection:C76([Customer:2])
		FIRST RECORD:C50([Customer:2])
		For ($inc; 1; $cnt)
			$doContact:=False:C215  //set baseline
			SEND PACKET:C103(myDoc; "<Customer>")
			SEND PACKET:C103(myDoc; "<RemoteID>"+[Customer:2]customerID:1+"</RemoteID>")
			SEND PACKET:C103(myDoc; "<customerID>"+[Customer:2]remoteid:122+"</customerID>")
			SEND PACKET:C103(myDoc; "<CustomerName>"+[Customer:2]company:2+"</CustomerName>")
			SEND PACKET:C103(myDoc; "<Address1>"+[Customer:2]address1:4+"</Address1>")
			SEND PACKET:C103(myDoc; "<Address2>"+[Customer:2]address2:5+"</Address2>")
			SEND PACKET:C103(myDoc; "<City>"+[Customer:2]city:6+"</City>")
			SEND PACKET:C103(myDoc; "<StateProv>"+[Customer:2]state:7+"</StateProv>")
			SEND PACKET:C103(myDoc; "<ZipPostal>"+[Customer:2]zip:8+"</ZipPostal>")
			SEND PACKET:C103(myDoc; "<PrimaryPhone>"+[Customer:2]phone:13+"</PrimaryPhone>")
			REDUCE SELECTION:C351([Contact:13]; 0)
			If ([Customer:2]contactShipTo:93>0)
				QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Customer:2]contactShipTo:93)
				If (Records in selection:C76([Contact:13])=1)
					$doContact:=True:C214
				End if 
			End if 
			If ($doContact)
				SEND PACKET:C103(myDoc; "<ShipPhone>"+[Contact:13]phone:30+"</ShipPhone>")
				SEND PACKET:C103(myDoc; "<ShipFax>"+[Contact:13]fax:31+"</ShipFax>")
			Else 
				SEND PACKET:C103(myDoc; "<ShipPhone>"+[Customer:2]phoneCell:99+"</ShipPhone>")
				SEND PACKET:C103(myDoc; "<ShipFax>"+[Customer:2]fax:66+"</ShipFax>")
			End if 
			//<CustomerName>Kitchen Pals</CustomerName>
			//<Address1>1871 Flowering Drive</Address1>
			//<Address2></Address2>
			//<City>Grayson</City>
			//<StateProv>GA</StateProv>
			//<ZipPostal>30017</ZipPostal>
			//<PrimaryPhone></PrimaryPhone>
			//<ShipPhone></ShipPhone>
			//<ShipFax></ShipFax>
			REDUCE SELECTION:C351([Contact:13]; 0)
			If ([Customer:2]contactBillTo:92>0)
				QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Customer:2]contactBillTo:92)
				If (Records in selection:C76([Contact:13])=1)
					$doContact:=True:C214
				End if 
			End if 
			//<BillCustomerName>Kitchen Pals</BillCustomerName>
			//<BillAddress1>1871 Flowering Drive</BillAddress1>
			//<BillAddress2></BillAddress2>
			//<BillCity>Grayson</BillCity>
			//<BillStateProv>GA</BillStateProv>
			//<BillZipPostal>30017</BillZipPostal>
			//<BillPhone></BillPhone>
			//<BillFax></BillFax>
			If ($doContact)
				SEND PACKET:C103(myDoc; "<BillCustomerName>"+[Contact:13]company:23+"</BillCustomerName>")
				SEND PACKET:C103(myDoc; "<BillAddress1>"+[Contact:13]address1:6+"</BillAddress1>")
				SEND PACKET:C103(myDoc; "<BillAddress2>"+[Contact:13]address2:7+"</BillAddress2>")
				SEND PACKET:C103(myDoc; "<BillCity>"+[Contact:13]city:8+"</BillCity>")
				SEND PACKET:C103(myDoc; "<BillStateProv>"+[Contact:13]state:9+"</BillStateProv>")
				SEND PACKET:C103(myDoc; "<BillZipPostal>"+[Contact:13]zip:11+"</BillZipPostal>")
				SEND PACKET:C103(myDoc; "<BillPhone>"+[Contact:13]phone:30+"</BillPhone>")
				SEND PACKET:C103(myDoc; "<BillFax>"+[Contact:13]fax:31+"</BillFax>")
			Else 
				
				SEND PACKET:C103(myDoc; "<BillCustomerName>"+[Customer:2]company:2+"</BillCustomerName>")
				SEND PACKET:C103(myDoc; "<BillAddress1>"+[Customer:2]address1:4+"</BillAddress1>")
				SEND PACKET:C103(myDoc; "<BillAddress2>"+[Customer:2]address2:5+"</BillAddress2>")
				SEND PACKET:C103(myDoc; "<BillCity>"+[Customer:2]city:6+"</BillCity>")
				SEND PACKET:C103(myDoc; "<BillStateProv>"+[Customer:2]state:7+"</BillStateProv>")
				SEND PACKET:C103(myDoc; "<BillZipPostal>"+[Customer:2]zip:8+"</BillZipPostal>")
				SEND PACKET:C103(myDoc; "<BillPhone>"+[Customer:2]phone:13+"</BillPhone>")
				SEND PACKET:C103(myDoc; "<BillFax>"+[Customer:2]fax:66+"</BillFax>")
			End if 
			SEND PACKET:C103(myDoc; "<SalesmanName>"+[Customer:2]salesNameID:59+"</SalesmanName>")
			SEND PACKET:C103(myDoc; "<TermList>"+[Customer:2]terms:33+"</TermList>")
			SEND PACKET:C103(myDoc; "</Customer>")
			NEXT RECORD:C51([Customer:2])
			
			If ($testingReturns)
				SEND PACKET:C103(myDoc; "\r"+"\r")
			End if 
		End for 
		SEND PACKET:C103(myDoc; "</CustomerList>"+"\r")
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 

$myDocName:=$myPathOut+"import_cat.xml"
If (Test path name:C476($myDocName)#1)
	Execute_TallyMaster("import_cat_search"; "RepTimeOut")
	If ($testingReturns)
		QUERY:C277([Item:4]; [Item:4]itemNum:1#"COM@")
		ALL RECORDS:C47([Item:4])
	End if 
	ALL RECORDS:C47([Item:4])
	REDUCE SELECTION:C351([Item:4]; 10)
	myDoc:=Create document:C266($myDocName)
	If (OK=1)
		SEND PACKET:C103(myDoc; "<ItemList>")
		$cnt:=Records in selection:C76([Item:4])
		FIRST RECORD:C50([Item:4])
		For ($inc; 1; $cnt)
			SEND PACKET:C103(myDoc; "<Item>")
			SEND PACKET:C103(myDoc; "<MfctName>"+[Item:4]mfrName:91+"</MfctName>")
			SEND PACKET:C103(myDoc; "<MfgCode>"+[Item:4]mfrName:91+"</MfgCode>")
			SEND PACKET:C103(myDoc; "<ItemNum>"+[Item:4]vendorItemNum:40+"</ItemNum>")
			SEND PACKET:C103(myDoc; "<RemoteID>"+[Item:4]itemNum:1+"</RemoteID>")
			SEND PACKET:C103(myDoc; "<Description>"+[Item:4]description:7+"</Description>")
			SEND PACKET:C103(myDoc; "<Minimum>"+String:C10([Item:4]qtySaleDefault:15)+"</Minimum>")
			SEND PACKET:C103(myDoc; "<UnitPrice>"+String:C10([Item:4]priceD:5)+"</UnitPrice>")
			SEND PACKET:C103(myDoc; "<ProductCode>"+[Item:4]barCode:34+"</ProductCode>")
			SEND PACKET:C103(myDoc; "</Item>")
			NEXT RECORD:C51([Item:4])
			If ($testingReturns)
				SEND PACKET:C103(myDoc; "\r"+"\r")
			End if 
		End for 
		SEND PACKET:C103(myDoc; "</ItemList>"+"\r")
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 

If (False:C215)
	$myDocName:=$myPathOut+"import_pricestructure.xml"
	If (Test path name:C476($myDocName)#1)
		Execute_TallyMaster("export_pricestructure"; "RepTimeOut")
		If ($testingReturns)
			ALL RECORDS:C47([PriceMatrix:105])
		End if 
		$cnt:=Records in selection:C76([PriceMatrix:105])
		If ($cnt>0)
			myDoc:=Create document:C266($myDocName)
			If (OK=1)
				SEND PACKET:C103(myDoc; "<PriceStructureList>")
				$cnt:=Records in selection:C76([PriceMatrix:105])
				FIRST RECORD:C50([PriceMatrix:105])
				For ($inc; 1; $cnt)
					SEND PACKET:C103(myDoc; "<PriceStructure>")
					QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=[PriceMatrix:105]itemNum:11)
					SEND PACKET:C103(myDoc; "<MfctName>"+[Item:4]mfrName:91+"</MfctName>")
					SEND PACKET:C103(myDoc; "<ItemNum>"+[PriceMatrix:105]itemNum:11+"</ItemNum>")
					SEND PACKET:C103(myDoc; "<LowRange>"+String:C10([PriceMatrix:105]quantityMin:4)+"</LowRange>")
					SEND PACKET:C103(myDoc; "<HighRange>"+String:C10([PriceMatrix:105]quantityMax:5)+"</HighRange>")
					SEND PACKET:C103(myDoc; "<Price>"+String:C10([PriceMatrix:105]price:6)+"</Price>")
					SEND PACKET:C103(myDoc; "</PriceStructure>")
					NEXT RECORD:C51([PriceMatrix:105])
					If ($testingReturns)
						SEND PACKET:C103(myDoc; "\r"+"\r")
					End if 
				End for 
				SEND PACKET:C103(myDoc; "</PriceStructureList>"+"\r")
				CLOSE DOCUMENT:C267(myDoc)
			End if 
		End if 
	End if 
End if 

$myDocName:=$myPathOut+"import_custcontact.xml"
If (Test path name:C476($myDocName)#1)
	myDoc:=Create document:C266($myDocName)
	CLOSE DOCUMENT:C267(myDoc)
End if 
//
$myDocName:=$myPathOut+"import_custnumber.xml"
If (Test path name:C476($myDocName)#1)
	myDoc:=Create document:C266($myDocName)
	CLOSE DOCUMENT:C267(myDoc)
End if 
//
$myDocName:=$myPathOut+"import_customerterms.xml"
If (Test path name:C476($myDocName)#1)
	myDoc:=Create document:C266($myDocName)
	Execute_TallyMaster("import_customerterms_search"; "RepTimeOut")
	ALL RECORDS:C47([Payment:28])
	$k:=Records in selection:C76([Payment:28])
	If ($k>0)
		QUERY:C277([Map:84]; [Map:84]purpose:5="RepTimeOut@"; *)
		QUERY:C277([Map:84];  & [Map:84]name:6="import_customerterms")
		If (Records in selection:C76([Map:84])=0)
			ALERT:C41("Missing import_customerterms Maps")
		Else 
			myDoc:=Create document:C266($myDocName)
			ORDER BY:C49([Map:84]; [Map:84]seq:18)
			ARRAY LONGINT:C221($aMapRecNum; 0)
			ARRAY LONGINT:C221($aMapFieldNum; 0)
			ARRAY LONGINT:C221($aMapTableNum; 0)
			ARRAY TEXT:C222($aMapTag; 0)
			ARRAY LONGINT:C221($aMapSeq; 0)
			ARRAY TEXT:C222($aMapScript; 0)
			ARRAY TEXT:C222($aMapCatagory; 0)
			SELECTION TO ARRAY:C260([Map:84]; $aMapRecNum; [Map:84]tableNum:15; $aMapTableNum; [Map:84]fieldNum:16; $aMapFieldNum; [Map:84]controllingTag:1; $aMapTag; [Map:84]script:4; $aMapScript; [Map:84]seq:18; $aMapSeq; [Map:84]category:12; $aMapCatagory)
			SORT ARRAY:C229($aMapSeq; $aMapRecNum; $aMapTableNum; $aMapFieldNum; $aMapTag; $aMapScript)
			$cntArray:=Size of array:C274($aMapSeq)
			FIRST RECORD:C50([OrderLine:49])
			SEND PACKET:C103(myDoc; "<CustomerTermsList><CustomerTerms>")
			For ($i; 1; $k)
				For ($incRay; 1; $cntArray)
					If ($aMapCatagory{$incRay}="Script@")
						vText10:="Build"
						ExecuteText(0; $aMapScript{$incRay})
						SEND PACKET:C103(myDoc; "<"+$aMapTag{$incRay}+">"+vText10+"</"+$aMapTag{$incRay}+">")
					Else 
						If (($aMapTableNum{$incRay}>0) & ($aMapFieldNum{$incRay}>0))
							SEND PACKET:C103(myDoc; "<"+$aMapTag{$incRay}+">"+Txt_Return2String(Field:C253($aMapTableNum{$incRay}; $aMapFieldNum{$incRay}))+"</"+$aMapTag{$incRay}+">")
						End if 
					End if 
				End for 
				NEXT RECORD:C51([OrderLine:49])
				SEND PACKET:C103(myDoc; "</CustomerTerms>")
				If ($testingReturns)
					SEND PACKET:C103(myDoc; "\r"+"\r")
				End if 
				If ($i<$k)
					SEND PACKET:C103(myDoc; "<CustomerTerms>")
				End if 
			End for 
			SEND PACKET:C103(myDoc; "</CustomerTermsList>")
			CLOSE DOCUMENT:C267(myDoc)
		End if 
	End if 
End if 










//
$myDocName:=$myPathOut+"import_sizecolorstyler.xml"
If (Test path name:C476($myDocName)#1)
	myDoc:=Create document:C266($myDocName)
	CLOSE DOCUMENT:C267(myDoc)
End if 
//
$myDocName:=$myPathOut+"import_order.xml"
If (Test path name:C476($myDocName)#1)
	//If ($testingReturns)
	ALL RECORDS:C47([Order:3])
	
	Execute_TallyMaster("import_order_search"; "RepTimeOut")
	$k:=Records in selection:C76([Order:3])
	If ($k>0)
		QUERY:C277([Map:84]; [Map:84]purpose:5="RepTimeOut"; *)
		QUERY:C277([Map:84];  & [Map:84]name:6="import_order")
		
		If (Records in selection:C76([Map:84])=0)
			//ALERT("Missing export_order Maps")
			Execute_TallyMaster("MapOrders"; "RepTimeOut")
		End if 
		
		If (Records in selection:C76([Map:84])>0)
			myDoc:=Create document:C266($myDocName)
			ORDER BY:C49([Map:84]; [Map:84]seq:18)
			ARRAY LONGINT:C221($aMapRecNum; 0)
			ARRAY LONGINT:C221($aMapFieldNum; 0)
			ARRAY LONGINT:C221($aMapTableNum; 0)
			ARRAY TEXT:C222($aMapTag; 0)
			ARRAY LONGINT:C221($aMapSeq; 0)
			ARRAY TEXT:C222($aMapScript; 0)
			ARRAY TEXT:C222($aMapCatagory; 0)
			SELECTION TO ARRAY:C260([Map:84]; $aMapRecNum; [Map:84]tableNum:15; $aMapTableNum; [Map:84]fieldNum:16; $aMapFieldNum; [Map:84]controllingTag:1; $aMapTag; [Map:84]script:4; $aMapScript; [Map:84]seq:18; $aMapSeq; [Map:84]category:12; $aMapCatagory)
			SORT ARRAY:C229($aMapSeq; $aMapRecNum; $aMapTableNum; $aMapFieldNum; $aMapTag; $aMapScript)
			$cntArray:=Size of array:C274($aMapSeq)
			FIRST RECORD:C50([Order:3])
			SEND PACKET:C103(myDoc; "<OrderList><Order>")
			For ($i; 1; $k)
				For ($incRay; 1; $cntArray)
					If ($aMapCatagory{$incRay}="Script@")
						vText10:="Build"
						ExecuteText(0; $aMapScript{$incRay})
						SEND PACKET:C103(myDoc; "<"+$aMapTag{$incRay}+">"+vText10+"</"+$aMapTag{$incRay}+">")
					Else 
						If (($aMapTableNum{$incRay}>0) & ($aMapFieldNum{$incRay}>0))
							SEND PACKET:C103(myDoc; "<"+$aMapTag{$incRay}+">"+Txt_Return2String(Field:C253($aMapTableNum{$incRay}; $aMapFieldNum{$incRay}))+"</"+$aMapTag{$incRay}+">")
						End if 
					End if 
				End for 
				NEXT RECORD:C51([Order:3])
				SEND PACKET:C103(myDoc; "</Order>")
				If ($testingReturns)
					SEND PACKET:C103(myDoc; "\r"+"\r")
				End if 
				If ($i<$k)
					SEND PACKET:C103(myDoc; "<Order>")
				End if 
			End for 
			SEND PACKET:C103(myDoc; "</OrderList>")
			CLOSE DOCUMENT:C267(myDoc)
		End if 
	End if 
End if 

$myDocName:=$myPathOut+"import_orderdetail.xml"
If (Test path name:C476($myDocName)#1)
	Execute_TallyMaster("import_orderdetail_search"; "RepTimeOut")
	ALL RECORDS:C47([OrderLine:49])
	$k:=Records in selection:C76([OrderLine:49])
	If ($k>0)
		QUERY:C277([Map:84]; [Map:84]purpose:5="RepTimeOut@"; *)
		QUERY:C277([Map:84];  & [Map:84]name:6="import_orderdetail")
		If (Records in selection:C76([Map:84])=0)
			ALERT:C41("Missing export_orderdetail Maps")
		Else 
			myDoc:=Create document:C266($myDocName)
			ORDER BY:C49([Map:84]; [Map:84]seq:18)
			ARRAY LONGINT:C221($aMapRecNum; 0)
			ARRAY LONGINT:C221($aMapFieldNum; 0)
			ARRAY LONGINT:C221($aMapTableNum; 0)
			ARRAY TEXT:C222($aMapTag; 0)
			ARRAY LONGINT:C221($aMapSeq; 0)
			ARRAY TEXT:C222($aMapScript; 0)
			ARRAY TEXT:C222($aMapCatagory; 0)
			SELECTION TO ARRAY:C260([Map:84]; $aMapRecNum; [Map:84]tableNum:15; $aMapTableNum; [Map:84]fieldNum:16; $aMapFieldNum; [Map:84]controllingTag:1; $aMapTag; [Map:84]script:4; $aMapScript; [Map:84]seq:18; $aMapSeq; [Map:84]category:12; $aMapCatagory)
			SORT ARRAY:C229($aMapSeq; $aMapRecNum; $aMapTableNum; $aMapFieldNum; $aMapTag; $aMapScript)
			$cntArray:=Size of array:C274($aMapSeq)
			FIRST RECORD:C50([OrderLine:49])
			SEND PACKET:C103(myDoc; "<OrderDetailList><OrderDetail>")
			For ($i; 1; $k)
				For ($incRay; 1; $cntArray)
					If ($aMapCatagory{$incRay}="Script@")
						vText10:="Build"
						ExecuteText(0; $aMapScript{$incRay})
						SEND PACKET:C103(myDoc; "<"+$aMapTag{$incRay}+">"+vText10+"</"+$aMapTag{$incRay}+">")
					Else 
						If (($aMapTableNum{$incRay}>0) & ($aMapFieldNum{$incRay}>0))
							SEND PACKET:C103(myDoc; "<"+$aMapTag{$incRay}+">"+Txt_Return2String(Field:C253($aMapTableNum{$incRay}; $aMapFieldNum{$incRay}))+"</"+$aMapTag{$incRay}+">")
						End if 
					End if 
				End for 
				NEXT RECORD:C51([OrderLine:49])
				SEND PACKET:C103(myDoc; "</OrderDetail>")
				If ($testingReturns)
					SEND PACKET:C103(myDoc; "\r"+"\r")
				End if 
				If ($i<$k)
					SEND PACKET:C103(myDoc; "<OrderDetail>")
				End if 
			End for 
			SEND PACKET:C103(myDoc; "</OrderDetailList>")
			CLOSE DOCUMENT:C267(myDoc)
		End if 
	End if 
	
End if 


