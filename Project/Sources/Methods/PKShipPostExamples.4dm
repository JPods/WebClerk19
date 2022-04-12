//%attributes = {}
//Script PKExecute_ShipInfo 20060424
//Addition of package information

vC:=Char:C90(44)
vDQ:=Char:C90(34)  //DoubleQuote
vDQC:=Char:C90(34)+Char:C90(44)
vCRLF:=Char:C90(13)+Char:C90(10)

vi2:=Records in selection:C76([Invoice:26])

//File Path for UPS ODBC file
vText1:="C:\\UPS\\Import\\ShipInfo.csv"

//File Path for testing
//vText1:="Macintosh HD:Users:jmedlen:Desktop:ShipInfo.csv"

$result:=Test path name:C476($pathname)
If (HFS_Exists($pathname)=1)
	$result:=HFS_Delete($pathname)
End if 
myDoc:=Create document:C266(vText1)


//ODBC Headers did not work with "3rd" in the header name

vHeader1:="InvoiceNum,Company,Attention,Address1,Address2,Country,Zip,City,"
vHeader2:="State,CustPONum,ShipVia,Phone,FAX,Residential,QVNOption,"
vHeader3:="ShipNotification1,Type,Email,BillingOption,Account,"
vHeader4:="ThirdCompany,ThirdAttention,ThirdAddress1,ThirdAddress2,"
vHeader5:="ThirdCity,ThirdState,ThirdZip,ThirdCountry,ThirdPhone,ThirdFax,"
vHeader6:="PackageType,Weight,DeclaredValueOption,DeclaredValueAmount"+vCRLF

SEND PACKET:C103(myDoc; vHeader1)
SEND PACKET:C103(myDoc; vHeader2)
SEND PACKET:C103(myDoc; vHeader3)
SEND PACKET:C103(myDoc; vHeader4)
SEND PACKET:C103(myDoc; vHeader5)
SEND PACKET:C103(myDoc; vHeader6)

FIRST RECORD:C50([Invoice:26])

For (vi1; 1; vi2)
	
	QUERY:C277([LoadTag:88]; [LoadTag:88]invoiceNum:19=[Invoice:26]invoiceNum:2)
	
	vi4:=Records in selection:C76([LoadTag:88])
	If (vi4=0)
		ALERT:C41("No Boxes to Export for Invoice "+String:C10([Invoice:26]invoiceNum:2))
	End if 
	
	Open window:C153(200; 200; 600; 300; 5; "Export")
	
	FIRST RECORD:C50([LoadTag:88])
	For (vi3; 1; vi4)
		
		ERASE WINDOW:C160
		GOTO XY:C161(2; 1)
		MESSAGE:C88("Exporting Invoice "+String:C10(vi1)+" of "+String:C10(vi2))
		
		QUERY:C277([Carrier:11]; [Carrier:11]carrierid:10=[Invoice:26]shipVia:5; *)
		QUERY:C277([Carrier:11]; [Carrier:11]active:6="True")
		
		If ([Carrier:11]residential:33)  //if Residential is checked
			vtResidential:="Y"
		Else   // If Residential not checked
			vtResidential:="N"
		End if 
		
		If ([Invoice:26]email:76#"")
			vtOption:="Y"
			vtNotify:="Y"
			vtType:="Email"
			vtEmail:=[Invoice:26]email:76
			
		Else 
			vtOption:="N"
			vtNotify:="N"
			vtType:=""
			vtEmail:=""
			
		End if 
		
		If (([Invoice:26]upsBillingOption:81="Bill 3rd Party UPS") & ([Invoice:26]upsReceiverAcct:82#""))  //Bill 3rd Party
			
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
			vtBillTo:="Bill To Third Party"
			vtAccount:=[Invoice:26]upsReceiverAcct:82
			vt3rdCompany:=Substring:C12([Customer:2]company:2; 1; 35)
			vt3rdAttention:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
			vt3rdAddress1:=[Customer:2]address1:4
			vt3rdAddress2:=[Customer:2]address2:5
			vt3rdCity:=[Customer:2]city:6
			vt3rdState:=[Customer:2]state:7
			vt3rdZip:=[Customer:2]zip:8
			vt3rdCountry:=Substring:C12([Customer:2]country:9; 1; 2)
			vt3rdPhone:=[Customer:2]phone:13
			vt3rdFax:=[Customer:2]fax:66
			
		Else 
			
			vtBillTo:="Prepaid & Add"
			vtAccount:=""
			vt3rdCompany:=""
			vt3rdAttention:=""
			vt3rdAddress1:=""
			vt3rdAddress2:=""
			vt3rdCity:=""
			vt3rdState:=""
			vt3rdZip:=""
			vt3rdCountry:=""
			vt3rdPhone:=""
			vt3rdFax:=""
			
		End if 
		
		vtPackageType:="Package"
		vtWeight:=String:C10(Round:C94([LoadTag:88]weightExtended:2; 1))
		
		If ([LoadTag:88]value:24=0)
			vtDeclaredValueOption:="N"
			vtDeclaredValueAmount:="0"
		Else 
			vtDeclaredValueOption:="Y"
			vtDeclaredValueAmount:=String:C10(Round:C94([LoadTag:88]value:24; 0))
		End if 
		
		vtCountry:=Substring:C12([Invoice:26]country:13; 1; 2)
		vtCountry:=Uppercase:C13(vtCountry)
		
		SEND PACKET:C103(myDoc; vDQ+"{O"+String:C10([Invoice:26]orderNum:1)+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]company:7+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]attention:38+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]address1:8+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]address2:9+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtCountry+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]zip:12+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]city:10+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]state:11+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]customerPO:29+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]shipVia:5+vDQ+vC)
		SEND PACKET:C103(myDoc; [Invoice:26]phone:54+vC)
		SEND PACKET:C103(myDoc; [Invoice:26]fax:75+vC)
		SEND PACKET:C103(myDoc; vDQ+vtResidential+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtOption+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtNotify+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtType+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtEmail+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtBillTo+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtAccount+VDQ+vC)
		
		SEND PACKET:C103(myDoc; vDQ+vt3rdCompany+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdAttention+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdAddress1+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdAddress2+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdCity+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdState+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdZip+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdCountry+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdPhone+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdFax+VDQ+vC)
		
		SEND PACKET:C103(myDoc; vDQ+vtPackageType+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtWeight+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtDeclaredValueOption+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtDeclaredValueAmount+VDQ+vCRLF)
		
		NEXT RECORD:C51([LoadTag:88])
	End for 
	
	NEXT RECORD:C51([Invoice:26])
	
End for 

CLOSE DOCUMENT:C267(myDoc)
CLOSE WINDOW:C154


If (False:C215)
	
	
	
	//Script PKExecute_ShipInfo 20060424
	//Addition of package information
	
	vC:=Char:C90(44)
	vDQ:=Char:C90(34)  //DoubleQuote
	vDQC:=Char:C90(34)+Char:C90(44)
	vCRLF:=Char:C90(13)+Char:C90(10)
	
	vi2:=Records in selection:C76([Order:3])
	
	//File Path for UPS ODBC file
	vText1:="C:\\\\UPS\\Import\\ShipInfo.csv"
	
	//File Path for testing
	//vText1:="Macintosh HD:Users:jmedlen:Desktop:ShipInfo.csv"
	
	If (HFS_Exists(vText1)=1)
		vi9:=HFS_Delete(vText1)
	End if 
	myDoc:=Create document:C266(vText1)
	
	
	//ODBC Headers did not work with "3rd" in the header name
	
	vHeader1:="InvoiceNum,Company,Attention,Address1,Address2,Country,Zip,City,"
	vHeader2:="State,CustPONum,ShipVia,Phone,FAX,Residential,QVNOption,"
	vHeader3:="ShipNotification1,Type,Email,BillingOption,Account,"
	vHeader4:="ThirdCompany,ThirdAttention,ThirdAddress1,ThirdAddress2,"
	vHeader5:="ThirdCity,ThirdState,ThirdZip,ThirdCountry,ThirdPhone,ThirdFax,"
	vHeader6:="PackageType,Weight,DeclaredValueOption,DeclaredValueAmount"+vCRLF
	
	SEND PACKET:C103(myDoc; vHeader1)
	SEND PACKET:C103(myDoc; vHeader2)
	SEND PACKET:C103(myDoc; vHeader3)
	SEND PACKET:C103(myDoc; vHeader4)
	SEND PACKET:C103(myDoc; vHeader5)
	SEND PACKET:C103(myDoc; vHeader6)
	
	FIRST RECORD:C50([Order:3])
	
	For (vi1; 1; vi2)
		
		Open window:C153(200; 200; 600; 300; 5; "Export")
		
		
		ERASE WINDOW:C160
		GOTO XY:C161(2; 1)
		MESSAGE:C88("Exporting Invoice "+String:C10(vi1)+" of "+String:C10(vi2))
		
		QUERY:C277([Carrier:11]; [Carrier:11]carrierid:10=[Order:3]shipVia:13; *)
		QUERY:C277([Carrier:11]; [Carrier:11]active:6="True")
		
		If ([Carrier:11]residential:33)  //if Residential is checked
			vtResidential:="Y"
		Else   // If Residential not checked
			vtResidential:="N"
		End if 
		
		If ([Order:3]email:82#"")
			vtOption:="Y"
			vtNotify:="Y"
			vtType:="Email"
			vtEmail:=[Order:3]email:82
			
		Else 
			vtOption:="N"
			vtNotify:="N"
			vtType:=""
			vtEmail:=""
			
		End if 
		
		If (([Order:3]upsBillingOption:89="Bill 3rd Party UPS") & ([Order:3]upsReceiverAcct:90#""))  //Bill 3rd Party
			
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
			vtBillTo:="Bill To Third Party"
			vtAccount:=[Order:3]upsReceiverAcct:90
			vt3rdCompany:=Substring:C12([Customer:2]company:2; 1; 35)
			vt3rdAttention:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
			vt3rdAddress1:=[Customer:2]address1:4
			vt3rdAddress2:=[Customer:2]address2:5
			vt3rdCity:=[Customer:2]city:6
			vt3rdState:=[Customer:2]state:7
			vt3rdZip:=[Customer:2]zip:8
			vt3rdCountry:=Substring:C12([Customer:2]country:9; 1; 2)
			vt3rdPhone:=[Customer:2]phone:13
			vt3rdFax:=[Customer:2]fax:66
			
		Else 
			
			vtBillTo:="Prepaid & Add"
			vtAccount:=""
			vt3rdCompany:=""
			vt3rdAttention:=""
			vt3rdAddress1:=""
			vt3rdAddress2:=""
			vt3rdCity:=""
			vt3rdState:=""
			vt3rdZip:=""
			vt3rdCountry:=""
			vt3rdPhone:=""
			vt3rdFax:=""
			
		End if 
		
		vtPackageType:="Package"
		vtWeight:=String:C10(Round:C94([LoadTag:88]weightExtended:2; 1))
		
		If ([LoadTag:88]value:24=0)
			vtDeclaredValueOption:="N"
			vtDeclaredValueAmount:="0"
		Else 
			vtDeclaredValueOption:="Y"
			vtDeclaredValueAmount:=String:C10(Round:C94([LoadTag:88]value:24; 0))
		End if 
		
		vtCountry:=Substring:C12([Order:3]country:21; 1; 2)
		vtCountry:=Uppercase:C13(vtCountry)
		
		SEND PACKET:C103(myDoc; vDQ+"{O"+String:C10([Order:3]orderNum:2)+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Order:3]company:15+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Order:3]attention:44+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Order:3]address1:16+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Order:3]address2:17+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtCountry+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Order:3]zip:20+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Order:3]city:18+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Order:3]state:19+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Order:3]customerPO:3+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Order:3]shipVia:13+vDQ+vC)
		SEND PACKET:C103(myDoc; [Order:3]phone:67+vC)
		SEND PACKET:C103(myDoc; [Order:3]fax:81+vC)
		SEND PACKET:C103(myDoc; vDQ+vtResidential+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtOption+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtNotify+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtType+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtEmail+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtBillTo+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtAccount+VDQ+vC)
		
		SEND PACKET:C103(myDoc; vDQ+vt3rdCompany+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdAttention+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdAddress1+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdAddress2+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdCity+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdState+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdZip+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdCountry+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdPhone+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdFax+VDQ+vC)
		
		SEND PACKET:C103(myDoc; vDQ+vtPackageType+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtWeight+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtDeclaredValueOption+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtDeclaredValueAmount+VDQ+vCRLF)
		
		
		If (vi2>1)
			NEXT RECORD:C51([Order:3])
		End if 
		
	End for 
	
	CLOSE DOCUMENT:C267(myDoc)
	CLOSE WINDOW:C154
	
	
	
End if 


If (False:C215)
	
	
	//Script PKExecute_ShipInfo 20060424
	//Addition of package information
	
	vC:=Char:C90(44)
	vDQ:=Char:C90(34)  //DoubleQuote
	vDQC:=Char:C90(34)+Char:C90(44)
	vCRLF:=Char:C90(13)+Char:C90(10)
	
	vi2:=Records in selection:C76([Invoice:26])
	
	//File Path for UPS ODBC file
	vText1:="C:\\\\UPS\\Import\\ShipInfo.csv"
	
	//File Path for testing
	//vText1:="Macintosh HD:Users:jmedlen:Desktop:ShipInfo.csv"
	
	If (HFS_Exists(vText1)=1)
		vi9:=HFS_Delete(vText1)
	End if 
	myDoc:=Create document:C266(vText1)
	
	//ODBC Headers did not work with "3rd" in the header name
	
	vHeader1:="InvoiceNum,Company,Attention,Address1,Address2,Country,Zip,City,"
	vHeader2:="State,CustPONum,ShipVia,Phone,FAX,Residential,QVNOption,"
	vHeader3:="ShipNotification1,Type,Email,BillingOption,Account,"
	vHeader4:="ThirdCompany,ThirdAttention,ThirdAddress1,ThirdAddress2,"
	vHeader5:="ThirdCity,ThirdState,ThirdZip,ThirdCountry,ThirdPhone,ThirdFax,"
	vHeader6:="PackageType,Weight,DeclaredValueOption,DeclaredValueAmount"+vCRLF
	
	SEND PACKET:C103(myDoc; vHeader1)
	SEND PACKET:C103(myDoc; vHeader2)
	SEND PACKET:C103(myDoc; vHeader3)
	SEND PACKET:C103(myDoc; vHeader4)
	SEND PACKET:C103(myDoc; vHeader5)
	SEND PACKET:C103(myDoc; vHeader6)
	
	FIRST RECORD:C50([Invoice:26])
	
	For (vi1; 1; vi2)
		
		Open window:C153(200; 200; 600; 300; 5; "Export")
		
		
		ERASE WINDOW:C160
		GOTO XY:C161(2; 1)
		MESSAGE:C88("Exporting Invoice "+String:C10(vi1)+" of "+String:C10(vi2))
		
		QUERY:C277([Carrier:11]; [Carrier:11]carrierid:10=[Invoice:26]shipVia:5; *)
		QUERY:C277([Carrier:11]; [Carrier:11]active:6="True")
		
		If ([Carrier:11]residential:33)  //if Residential is checked
			vtResidential:="Y"
		Else   // If Residential not checked
			vtResidential:="N"
		End if 
		
		If ([Invoice:26]email:76#"")
			vtOption:="Y"
			vtNotify:="Y"
			vtType:="Email"
			vtEmail:=[Invoice:26]email:76
			
		Else 
			vtOption:="N"
			vtNotify:="N"
			vtType:=""
			vtEmail:=""
			
		End if 
		
		If (([Invoice:26]upsBillingOption:81="Bill 3rd Party UPS") & ([Invoice:26]upsReceiverAcct:82#""))  //Bill 3rd Party
			
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
			vtBillTo:="Bill To Third Party"
			vtAccount:=[Invoice:26]upsReceiverAcct:82
			vt3rdCompany:=Substring:C12([Customer:2]company:2; 1; 35)
			vt3rdAttention:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
			vt3rdAddress1:=[Customer:2]address1:4
			vt3rdAddress2:=[Customer:2]address2:5
			vt3rdCity:=[Customer:2]city:6
			vt3rdState:=[Customer:2]state:7
			vt3rdZip:=[Customer:2]zip:8
			vt3rdCountry:=Substring:C12([Customer:2]country:9; 1; 2)
			vt3rdPhone:=[Customer:2]phone:13
			vt3rdFax:=[Customer:2]fax:66
			
		Else 
			
			vtBillTo:="Prepaid & Add"
			vtAccount:=""
			vt3rdCompany:=""
			vt3rdAttention:=""
			vt3rdAddress1:=""
			vt3rdAddress2:=""
			vt3rdCity:=""
			vt3rdState:=""
			vt3rdZip:=""
			vt3rdCountry:=""
			vt3rdPhone:=""
			vt3rdFax:=""
			
		End if 
		
		vtPackageType:="Package"
		vtWeight:=String:C10(Round:C94([LoadTag:88]weightExtended:2; 1))
		
		If ([LoadTag:88]value:24=0)
			vtDeclaredValueOption:="N"
			vtDeclaredValueAmount:="0"
		Else 
			vtDeclaredValueOption:="Y"
			vtDeclaredValueAmount:=String:C10(Round:C94([LoadTag:88]value:24; 0))
		End if 
		
		vtCountry:=Substring:C12([Invoice:26]country:13; 1; 2)
		vtCountry:=Uppercase:C13(vtCountry)
		
		SEND PACKET:C103(myDoc; vDQ+"{O"+String:C10([Invoice:26]orderNum:1)+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]company:7+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]attention:38+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]address1:8+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]address2:9+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtCountry+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]zip:12+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]city:10+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]state:11+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]customerPO:29+vDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+[Invoice:26]shipVia:5+vDQ+vC)
		SEND PACKET:C103(myDoc; [Invoice:26]phone:54+vC)
		SEND PACKET:C103(myDoc; [Invoice:26]fax:75+vC)
		SEND PACKET:C103(myDoc; vDQ+vtResidential+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtOption+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtNotify+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtType+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtEmail+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtBillTo+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtAccount+VDQ+vC)
		
		SEND PACKET:C103(myDoc; vDQ+vt3rdCompany+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdAttention+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdAddress1+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdAddress2+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdCity+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdState+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdZip+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdCountry+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdPhone+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vt3rdFax+VDQ+vC)
		
		SEND PACKET:C103(myDoc; vDQ+vtPackageType+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtWeight+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtDeclaredValueOption+VDQ+vC)
		SEND PACKET:C103(myDoc; vDQ+vtDeclaredValueAmount+VDQ+vCRLF)
		
		
		If (vi2>1)
			NEXT RECORD:C51([Invoice:26])
		End if 
		
	End for 
	
	CLOSE DOCUMENT:C267(myDoc)
	CLOSE WINDOW:C154
	
	
	
End if 