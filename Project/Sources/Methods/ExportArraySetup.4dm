//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/08/11, 22:40:27
// ----------------------------------------------------
// Method: ExportArraySetup
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $theRecName; $2; $thePurpose)  //;$2)
C_TEXT:C284($vtSearch)
C_PICTURE:C286($vpSearch)
C_LONGINT:C283($doThis; $securityLevel; $3)
//
$doThis:=Count parameters:C259


//CLOSE DOCUMENT(myDoc)
//Execute_TallyMaster    //similar

$securityLevel:=1  //
Case of 
	: (Storage:C1525.user.securityLevel>$securityLevel)
		$securityLevel:=Storage:C1525.user.securityLevel
	: (allowAlerts_boo)
		$securityLevel:=Storage:C1525.user.securityLevel
	: (viEndUserSecurityLevel=0)
		$securityLevel:=1
	Else 
		$securityLevel:=viEndUserSecurityLevel
End case 
If ($doThis<1)
	$theRecName:=""
Else 
	If ($doThis<2)
		$theRecName:=$1
		$thePurpose:="Execute_Tally"
	Else 
		If ($doThis<3)
			$theRecName:=$1
			$thePurpose:=$2
		Else 
			If ($doThis<4)
				$theRecName:=$1
				$thePurpose:=$2
				$securityLevel:=$3
			Else 
				$theRecName:=$1
				$thePurpose:=$2
				$securityLevel:=$3
			End if 
		End if 
	End if 
End if 

//Execute_TallyMaster ("emailOrderLines";"EmailExport")
QUERY:C277([TallyMaster:60]; [TallyMaster:60]publish:25>0; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=$securityLevel; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=$theRecName; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3=$thePurpose)
C_LONGINT:C283($tableNum)
$tableNum:=STR_GetTableNumber(Table name:C256([TallyMaster:60]tableNum:1))
If ((Records in selection:C76([TallyMaster:60])=1) & ($tableNum>0))
	myDoc:=Create document:C266(String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33); "00")+String:C10(Day of:C23(Current date:C33); "00")+Substring:C12([RemoteUser:57]company:16; 1; 7)+String:C10(DateTime_DTTo)+".txt")
	
	
	iLoText11:=[TallyMaster:60]script:9  //executes in each record loop
	
	// //Alert("Script to execute with each record")
	// 
	// Query([Customer];[Customer]customerID=[OrderLine]customerID)
	// Query([Order];[Order]OrderNum=[OrderLine]OrderNum)
	// Query([Item];[Item]ItemNum=[OrderLine]ItemNum)
	// Query([Payment];[Payment]OrderNum=[Order]OrderNum)
	// First Record([Payment])
	
	
	iLoText10:=[TallyMaster:60]build:6  //used to get the records to export
	
	//  //Alert("Build the selection")
	// // Alert(stringRecords in selection([Order])))
	// If (Records in selection([Order])=1)
	// QUERY([OrderLine];[OrderLine]OrderNum=[Order]OrderNum)
	// If ([Order]OrderNum#[OrderLine]OrderNum)
	// QUERY([Order];[Order]OrderNum=[OrderLine]OrderNum)
	// End if 
	// If ([Customer]customerID#[OrderLine]customerID)
	// QUERY([Customer];[Customer]customerID#[OrderLine]customerID)
	// End if 
	// Else 
	// RELATE MANY SELECTION([OrderLine]OrderNum)
	// // Alert(stringRecords in selection([OrderLine])))
	// End if 
	// 
	// vtEmailSubject:="Order Data from "+Storage.default.company
	// array text(atEmailCC;2)
	// atEmailCC{1}:=Storage.default.email
	// atEmailCC{2}:="christian@cmashowroom.com"
	// array text(atEmailBCC;1)
	// atEmailBCC{1}:=vtEmailSender
	// //atEmailBCC{2}:="bill@jitcorp.com"
	// //alert("atEmailBCC{1}:=bill@jitcorp.com")
	// //alert(vtEmailSender)
	
	
	
	
	iLoText12:=[TallyMaster:60]after:7  //
	
	
	
	TextToArray([TallyMaster:60]template:29; ->aText11; "\r")  //now each line across the page is loaded into an array element "\t"
	
	// [OrderLine]OrderNum;SalesOrderNum;;//comment
	// [OrderLine]customerID;[OrderLine]customerID;;
	// [MfrCustomerXRef]MfrAccountNum;[MfrCustomerXRef]MfrAccountNum;;
	// [MfrCustomerXRef]Terms;[MfrCustomerXRef]MfrTerms;;
	// [Payment]CreditCardNum;[Payment]CreditCardNum
	// [Payment]DateExpires;[Payment]DateExpires;;
	// [Order]MfrOrdNum;[Order]MfrOrdNum;;
	// [OrderLine]mfrID;[OrderLine]mfrID;;
	// [OrderLine]LineNum;[OrderLine]LineNum;;
	// [OrderLine]AltItem;[OrderLine]AltItem;;
	// [Item]Barcode;[Item]Barcode;;
	// [OrderLine]Description;[OrderLine]Description;;
	// [OrderLine]CommentShipping;[OrderLine]CommentShipping;;
	// [OrderLine]QtyOrdered;[OrderLine]QtyOrdered;###,###,###
	// [OrderLine]QtyShipped;[OrderLine]QtyShipped;###,###,###;//more comment
	// [OrderLine]QtyBackLogged;[OrderLine]QtyBackLogged;###,###,###.00;//comment
	// [OrderLine]UnitPrice;[OrderLine]UnitPrice;;
	// [OrderLine]Discount;[OrderLine]Discount;;
	// [OrderLine]DiscountedPrice;[OrderLine]DiscountedPrice;;
	// [OrderLine]ExtendedCost;[OrderLine]ExtendedCost;;
	// [OrderLine]ExtendedPrice;[OrderLine]ExtendedPrice;;
	// 
	// [Order]CustPONum;[Order]CustPONum;;
	// [Order]DateOrdered;[Order]DateOrdered;;
	// [Order]DateNeeded;[Order]DateNeeded;;
	// [Order]Company;[Order]ShipCompany;;
	// [Order]Address1;[Order]ShipAddress1;;
	// [Order]Address2;[Order]ShipAddress2;;
	// [Order]City;[Order]ShipCity;;
	// [Order]State;[Order]ShipState;;
	// [Order]Zip;[Order]ShipZip;;
	// [Order]Phone;[Order]ShipPhone;;
	// [Order]FAX;[Order]ShipFAX;;
	// [Order]Email;[Order]ShipeMail;;
	// [Order]ShipInstruct;[Order]ShipInstruct;;
	
	
	
	ExecuteText(0; iLoText10)  //find the records to be exported
	//QUERY([Order];[Order]DateNeeded>=!05/15/11!)
	//RELATE MANY SELECTION([OrderLine]OrderNum)
	//ORDER BY([OrderLine];[OrderLine]OrderNum)
	vi2:=Records in selection:C76(Table:C252($tableNum)->)
	//
	FIRST RECORD:C50([OrderLine:49])
	vi4:=Size of array:C274(aText11)
	ARRAY TEXT:C222(iLoaText1; vi4)
	ARRAY TEXT:C222(iLoaText2; vi4)
	ARRAY TEXT:C222(iLoaText3; vi4)
	ARRAY TEXT:C222(iLoaText4; vi4)
	
	
	
	
	
	For (vi3; 1; vi4)
		//aText11{vi3}:=Replace string(aText11{vi3};", ";",")
		//aText11{vi3}:=Replace string(aText11{vi3};"; ";",")
		//aText11{vi3}:=Replace string(aText11{vi3};";";",")
		//aText11{vi3}:=Replace string(aText11{vi3};Char(96),",")
		TextToArray(aText11{vi3}; ->aText10; ";"; True:C214)  //now each line across the page is loaded into an array element "\t"
		
		C_TEXT:C284($firstChar)
		$firstChar:=""
		If (Size of array:C274(aText10)>2)
			If (Length:C16(aText10{3})>0)
				$firstChar:=aText10{3}[[1]]
			End if 
		End if 
		
		Case of 
			: (Size of array:C274(aText10)>3)
				iLoaText1{vi3}:=aText10{1}
				iLoaText2{vi3}:=aText10{2}
				iLoaText3{vi3}:=aText10{3}
				iLoaText4{vi3}:=aText10{4}
			: (Size of array:C274(aText10)>2)
				iLoaText1{vi3}:=aText10{1}
				iLoaText2{vi3}:=aText10{2}
				If ($firstChar=Char:C90(96))
					iLoaText3{vi3}:=""
					iLoaText4{vi3}:=aText10{3}
				Else 
					iLoaText3{vi3}:=aText10{3}
					If (Size of array:C274(aText10)>3)
						iLoaText4{vi3}:=aText10{4}
					End if 
				End if 
			: (Size of array:C274(aText10)>1)
				iLoaText1{vi3}:=aText10{1}
				iLoaText2{vi3}:=aText10{2}
				iLoaText3{vi3}:=""
				iLoaText4{vi3}:=""
			Else 
				iLoaText1{vi3}:=aText11{vi3}
				iLoaText2{vi3}:=aText11{vi3}
				iLoaText3{vi3}:=""
				iLoaText4{vi3}:=""
		End case 
		If (vi3<vi4)
			SEND PACKET:C103(myDoc; iLoaText2{vi3}+"\t")
		Else 
			SEND PACKET:C103(myDoc; iLoaText2{vi3}+"\r")
		End if 
	End for 
	C_TEXT:C284($theValue)
	For (vi1; 1; vi2)
		
		ExecuteText(0; iLoText11)
		If (False:C215)  //make sure related records are defined in the Script Field in the [TallyMaster]
			If ([Order:3]idNum:2#[OrderLine:49]idNumOrder:1)
				QUERY:C277([Order:3]; [Order:3]idNum:2=[OrderLine:49]idNumOrder:1)
			End if 
			If ([Customer:2]customerID:1#[OrderLine:49]customerID:2)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1#[OrderLine:49]customerID:2)
			End if 
		End if 
		
		For (vi3; 1; vi4)
			iLoPointer1:=PointerFromName(iLoaText1{vi3})
			If (Is nil pointer:C315(iLoPointer1))
				SEND PACKET:C103(myDoc; "NameError")
			Else 
				$theValue:=TxtValueFromPointer(iLoPointer1; "")
				SEND PACKET:C103(myDoc; $theValue)
				If (vi3<vi4)
					SEND PACKET:C103(myDoc; "\t")
				Else 
					SEND PACKET:C103(myDoc; "\r")
				End if 
			End if 
		End for 
		NEXT RECORD:C51(Table:C252($tableNum)->)
	End for 
End if 
ExecuteText(0; iLoText12)
CLOSE DOCUMENT:C267(myDoc)





