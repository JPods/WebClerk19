//%attributes = {"publishedWeb":true}
If (False:C215)
	TCMod_606_67_03_04_Trans
	//Method: TaxSalesReportData
End if 

$doDate:=True:C214
TRACE:C157
C_TEXT:C284($1; $typeReport)
$k:=Count parameters:C259
If ($k=0)
	$typeReport:="Summary by GL"
Else 
	$typeReport:=$1
	//"Detailed by Type"
	//"Detailed by Class"
	//"Detailed by GL"
	//"Summary by Class"
	//"Summary by GL"
	//"Summary by Type"
	If ($k=3)
		$doDate:=False:C215
		vdDateBeg:=$2
		vdDateEnd:=$3
	End if 
End if 
vText2:="Sales Tax Report Period"
If ($doDate)
	jBetweenDates(vText2)
Else 
	OK:=1
End if 
If (OK=1)
	GOTO RECORD:C242([DefaultAccount:32]; 0)
	$defaultSalesGLAccount:=[DefaultAccount:32]itemSalesAcct:24
	UNLOAD RECORD:C212([DefaultAccount:32])
	//          
	ARRAY TEXT:C222(aInvoiceLines_ItemNum; 0)
	ARRAY TEXT:C222(aInvoiceLines_taxID; 0)
	ARRAY REAL:C219(aInvoiceLines_ExtendedPrice; 0)
	ARRAY REAL:C219(aInvoiceLines_SalesTax; 0)
	ARRAY TEXT:C222(aInvoices_TaxJuris; 0)
	ARRAY TEXT:C222(aInvoices_Profile1; 0)
	ARRAY LONGINT:C221(aInvoiceLines_InvoiceNum; 0)
	ARRAY TEXT:C222(aInvoices_Division; 0)
	ARRAY TEXT:C222(aInvoices_salesNameID; 0)
	ARRAY TEXT:C222(aInvoices_RepID; 0)
	//
	ARRAY TEXT:C222(aItems_typeID; 0)
	ARRAY TEXT:C222(aItems_Class; 0)
	ARRAY TEXT:C222(aItems_SalesGLAccount; 0)
	ARRAY TEXT:C222(aItems_MfgID; 0)
	//  
	QUERY:C277([Invoice:26]; [Invoice:26]dateInvoiced:35>=vdDateBeg; *)
	QUERY:C277([Invoice:26];  & [Invoice:26]dateInvoiced:35<=vdDateEnd)
	C_LONGINT:C283($i; $k; $cntLines; $incLines)
	$k:=Records in selection:C76([Invoice:26])
	FIRST RECORD:C50([Invoice:26])
	//ThermoInitExit ("Processing Invoice Lines";$k;True)
	$viProgressID:=Progress New
	
	For ($i; 1; $k)
		//Thermo_Update ($i)//
		ProgressUpdate($viProgressID; $i; $k; "Processing Invoice Lines")
		
		QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
		$cntLines:=Records in selection:C76([InvoiceLine:54])
		FIRST RECORD:C50([InvoiceLine:54])
		For ($incLines; 1; $cntLines)
			//$w:=Find in array(aInvoiceLines_ItemNum;[InvoiceLine]ItemNum)
			//If ($w<1)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[InvoiceLine:54]itemNum:4)
			INSERT IN ARRAY:C227(aInvoiceLines_ItemNum; 1; 1)  //InvoiceLine]ItemNum
			INSERT IN ARRAY:C227(aItems_typeID; 1; 1)  //[Item]typeID
			INSERT IN ARRAY:C227(aInvoiceLines_taxID; 1; 1)  //  InvoiceLine]taxID                   
			INSERT IN ARRAY:C227(aInvoiceLines_ExtendedPrice; 1; 1)  //InvoiceLine]ExtendedPrice
			INSERT IN ARRAY:C227(aInvoiceLines_SalesTax; 1; 1)  //InvoiceLine]SalesTax
			INSERT IN ARRAY:C227(aInvoices_TaxJuris; 1; 1)  //[Invoice]TaxJuris
			INSERT IN ARRAY:C227(aInvoices_Profile1; 1; 1)  //[Invoice]Profile1
			INSERT IN ARRAY:C227(aItems_Class; 1; 1)  //[Item]Class
			INSERT IN ARRAY:C227(aItems_SalesGLAccount; 1; 1)  //[Item]SalesGLAccount
			INSERT IN ARRAY:C227(aInvoiceLines_InvoiceNum; 1; 1)  //[InvoiceLine]InvoiceNum
			INSERT IN ARRAY:C227(aInvoices_Division; 1; 1)  //[Invoice]Division
			INSERT IN ARRAY:C227(aItems_MfgID; 1; 1)
			INSERT IN ARRAY:C227(aInvoices_salesNameID; 1; 1)
			INSERT IN ARRAY:C227(aInvoices_RepID; 1; 1)
			aInvoiceLines_ItemNum{1}:=[InvoiceLine:54]itemNum:4
			If (Records in selection:C76([Item:4])=1)
				aItems_typeID{1}:=[Item:4]type:26
				aItems_Class{1}:=[Item:4]class:92
				aItems_SalesGLAccount{1}:=[Item:4]salesGlAccount:21
				aItems_MfgID{1}:=[Item:4]mfrID:53
			Else 
				aItems_typeID{1}:="Missing"
				aItems_Class{1}:="Missing"
				aItems_SalesGLAccount{1}:=$defaultSalesGLAccount
			End if 
			aInvoiceLines_taxID{1}:=[InvoiceLine:54]taxJuris:14
			aInvoiceLines_ExtendedPrice{1}:=[InvoiceLine:54]extendedPrice:11
			aInvoiceLines_SalesTax{1}:=[InvoiceLine:54]salesTax:15
			aInvoices_TaxJuris{1}:=[Invoice:26]taxJuris:33
			aInvoices_Profile1{1}:=[Invoice:26]profile1:53
			aInvoiceLines_InvoiceNum{1}:=[InvoiceLine:54]invoiceNum:1
			aInvoices_Division{1}:=[Invoice:26]division:41
			aInvoices_salesNameID{1}:=[Invoice:26]salesNameID:23
			aInvoices_RepID{1}:=[Invoice:26]repID:22
			
			NEXT RECORD:C51([InvoiceLine:54])
		End for 
		NEXT RECORD:C51([Invoice:26])
	End for 
	//Thermo_Close 
	Progress QUIT($viProgressID)
	
	//
	If ($typeReport#"Detail@")
		ARRAY TEXT:C222(aItemNum; 0)
		ARRAY TEXT:C222(ataxID; 0)
		ARRAY REAL:C219(aExtendedPrice; 0)
		ARRAY REAL:C219(aSalesTax; 0)
		ARRAY TEXT:C222(aTaxJuris; 0)
		ARRAY TEXT:C222(aProfile1; 0)
		ARRAY LONGINT:C221(aInvoiceNum; 0)
		ARRAY TEXT:C222(aDivision; 0)
		ARRAY TEXT:C222(aMfgID; 0)
		ARRAY TEXT:C222(asalesNameID; 0)
		ARRAY TEXT:C222(aRepID; 0)
		//
		ARRAY TEXT:C222(atypeID; 0)
		ARRAY TEXT:C222(aClass; 0)
		ARRAY TEXT:C222(aSalesGLAccount; 0)
	Else 
		COPY ARRAY:C226(aInvoiceLines_ItemNum; aItemNum)
		COPY ARRAY:C226(aItems_typeID; atypeID)
		COPY ARRAY:C226(aInvoiceLines_taxID; ataxID)
		COPY ARRAY:C226(aInvoiceLines_ExtendedPrice; aExtendedPrice)
		COPY ARRAY:C226(aInvoiceLines_SalesTax; aSalesTax)
		COPY ARRAY:C226(aInvoices_TaxJuris; aTaxJuris)
		COPY ARRAY:C226(aInvoices_Profile1; aProfile1)
		COPY ARRAY:C226(aItems_Class; aClass)
		COPY ARRAY:C226(aItems_SalesGLAccount; aSalesGLAccount)
		COPY ARRAY:C226(aInvoiceLines_InvoiceNum; aInvoiceNum)
		COPY ARRAY:C226(aInvoices_Division; aDivision)
		COPY ARRAY:C226(aItems_MfgID; aMfgID)
		COPY ARRAY:C226(aInvoices_salesNameID; asalesNameID)
		COPY ARRAY:C226(aInvoices_RepID; aRepID)
	End if 
	
	//
	//Sort Array (aItems_SalesGLAccount;aItems_typeID;aInvoices
	//_Profile1;aInvoices_TaxJuris;aInvoiceLines_taxID;aInvoiceLines
	//_InvoiceNum;aInvoices_Division;aInvoiceLines_ItemNum;">"
	//;aInvoiceLines_ExtendedPrice;aInvoiceLines_SalesTax;aItems_Class;">
	//")
	//
	//
	$k:=Size of array:C274(aItems_typeID)
	Case of 
		: ($typeReport="Summary by GL")
			SORT ARRAY:C229(aItems_SalesGLAccount; aItems_typeID; aInvoices_TaxJuris; aInvoiceLines_taxID; aInvoiceLines_ExtendedPrice; aInvoiceLines_SalesTax; aInvoices_Division; aInvoiceLines_ItemNum; aItems_Class)
			For ($i; 1; $k)
				$w:=Find in array:C230(aSalesGLAccount; aItems_SalesGLAccount{$i})
				If ($w<0)
					INSERT IN ARRAY:C227(aItemNum; 1; 1)  //InvoiceLine]ItemNum
					INSERT IN ARRAY:C227(atypeID; 1; 1)  //[Item]typeID
					INSERT IN ARRAY:C227(ataxID; 1; 1)  //  InvoiceLine]taxID                   
					INSERT IN ARRAY:C227(aExtendedPrice; 1; 1)  //InvoiceLine]ExtendedPrice
					INSERT IN ARRAY:C227(aSalesTax; 1; 1)  //InvoiceLine]SalesTax
					INSERT IN ARRAY:C227(aTaxJuris; 1; 1)  //[Invoice]TaxJuris
					INSERT IN ARRAY:C227(aProfile1; 1; 1)  //[Invoice]Profile1
					INSERT IN ARRAY:C227(aClass; 1; 1)  //[Item]Class
					INSERT IN ARRAY:C227(aSalesGLAccount; 1; 1)  //[Item]SalesGLAccount
					INSERT IN ARRAY:C227(aInvoiceNum; 1; 1)  //[InvoiceLine]InvoiceNum
					INSERT IN ARRAY:C227(aDivision; 1; 1)  //[Invoice]Division
					INSERT IN ARRAY:C227(aMfgID; 1; 1)
					INSERT IN ARRAY:C227(asalesNameID; 1; 1)
					INSERT IN ARRAY:C227(aRepID; 1; 1)
					aItemNum{1}:="n/a"
					atypeID{1}:="n/a"
					ataxID{1}:="n/a"
					aExtendedPrice{1}:=aInvoiceLines_ExtendedPrice{$i}
					aSalesTax{1}:=aInvoiceLines_SalesTax{$i}
					aTaxJuris{1}:="n/a"
					aProfile1{1}:="n/a"
					aClass{1}:="n/a"
					aSalesGLAccount{1}:=aItems_SalesGLAccount{$i}
					aInvoiceNum{1}:=-1
					aDivision{1}:=""
				Else 
					aExtendedPrice{$w}:=aExtendedPrice{$w}+aInvoiceLines_ExtendedPrice{$i}
					aSalesTax{$w}:=aSalesTax{$w}+aInvoiceLines_SalesTax{$i}
				End if 
			End for 
			
			
		: ($typeReport="Summary by Class")
			SORT ARRAY:C229(aItems_Class; aItems_SalesGLAccount; aItems_typeID; aInvoices_TaxJuris; aInvoiceLines_taxID; aInvoiceLines_ExtendedPrice; aInvoiceLines_SalesTax; aInvoices_Division; aInvoiceLines_ItemNum)
			//
			For ($i; 1; $k)
				$w:=Find in array:C230(aClass; aItems_Class{$i})
				If ($w<0)
					INSERT IN ARRAY:C227(aItemNum; 1; 1)  //InvoiceLine]ItemNum
					INSERT IN ARRAY:C227(atypeID; 1; 1)  //[Item]typeID
					INSERT IN ARRAY:C227(ataxID; 1; 1)  //  InvoiceLine]taxID                   
					INSERT IN ARRAY:C227(aExtendedPrice; 1; 1)  //InvoiceLine]ExtendedPrice
					INSERT IN ARRAY:C227(aSalesTax; 1; 1)  //InvoiceLine]SalesTax
					INSERT IN ARRAY:C227(aTaxJuris; 1; 1)  //[Invoice]TaxJuris
					INSERT IN ARRAY:C227(aProfile1; 1; 1)  //[Invoice]Profile1
					INSERT IN ARRAY:C227(aClass; 1; 1)  //[Item]Class
					INSERT IN ARRAY:C227(aSalesGLAccount; 1; 1)  //[Item]SalesGLAccount
					INSERT IN ARRAY:C227(aInvoiceNum; 1; 1)  //[InvoiceLine]InvoiceNum
					INSERT IN ARRAY:C227(aDivision; 1; 1)  //[Invoice]Division
					INSERT IN ARRAY:C227(aMfgID; 1; 1)
					INSERT IN ARRAY:C227(asalesNameID; 1; 1)
					INSERT IN ARRAY:C227(aRepID; 1; 1)
					aItemNum{1}:="n/a"
					atypeID{1}:="n/a"
					ataxID{1}:="n/a"
					aExtendedPrice{1}:=aInvoiceLines_ExtendedPrice{$i}
					aSalesTax{1}:=aInvoiceLines_SalesTax{$i}
					aTaxJuris{1}:="n/a"
					aProfile1{1}:="n/a"
					aClass{1}:=aItems_Class{$i}
					aSalesGLAccount{1}:="n/a"
					aInvoiceNum{1}:=-1
					aDivision{1}:=""
				Else 
					aExtendedPrice{$w}:=aExtendedPrice{$w}+aInvoiceLines_ExtendedPrice{$i}
					aSalesTax{$w}:=aSalesTax{$w}+aInvoiceLines_SalesTax{$i}
				End if 
			End for 
			
			
		: ($typeReport="Summary by TaxJuris")
			SORT ARRAY:C229(aInvoices_TaxJuris; aItems_Class; aItems_SalesGLAccount; aItems_typeID; aInvoiceLines_taxID; aInvoiceLines_ExtendedPrice; aInvoiceLines_SalesTax; aInvoices_Division; aInvoiceLines_ItemNum)
			For ($i; 1; $k)
				$w:=Find in array:C230(aTaxJuris; aInvoices_TaxJuris{$i})
				If ($w<0)
					INSERT IN ARRAY:C227(aItemNum; 1; 1)  //InvoiceLine]ItemNum
					INSERT IN ARRAY:C227(atypeID; 1; 1)  //[Item]typeID
					INSERT IN ARRAY:C227(ataxID; 1; 1)  //  InvoiceLine]taxID                   
					INSERT IN ARRAY:C227(aExtendedPrice; 1; 1)  //InvoiceLine]ExtendedPrice
					INSERT IN ARRAY:C227(aSalesTax; 1; 1)  //InvoiceLine]SalesTax
					INSERT IN ARRAY:C227(aTaxJuris; 1; 1)  //[Invoice]TaxJuris
					INSERT IN ARRAY:C227(aProfile1; 1; 1)  //[Invoice]Profile1
					INSERT IN ARRAY:C227(aClass; 1; 1)  //[Item]Class
					INSERT IN ARRAY:C227(aSalesGLAccount; 1; 1)  //[Item]SalesGLAccount
					INSERT IN ARRAY:C227(aInvoiceNum; 1; 1)  //[InvoiceLine]InvoiceNum
					INSERT IN ARRAY:C227(aDivision; 1; 1)  //[Invoice]Division
					INSERT IN ARRAY:C227(aMfgID; 1; 1)
					INSERT IN ARRAY:C227(asalesNameID; 1; 1)
					INSERT IN ARRAY:C227(aRepID; 1; 1)
					aItemNum{1}:="n/a"
					atypeID{1}:="n/a"
					ataxID{1}:="n/a"
					aExtendedPrice{1}:=aInvoiceLines_ExtendedPrice{$i}
					aSalesTax{1}:=aInvoiceLines_SalesTax{$i}
					aTaxJuris{1}:=aInvoices_TaxJuris{$i}
					aProfile1{1}:="n/a"
					aClass{1}:="n/a"
					aSalesGLAccount{1}:="n/a"
					aInvoiceNum{1}:=-1
					aDivision{1}:=""
				Else 
					aExtendedPrice{$w}:=aExtendedPrice{$w}+aInvoiceLines_ExtendedPrice{$i}
					aSalesTax{$w}:=aSalesTax{$w}+aInvoiceLines_SalesTax{$i}
				End if 
			End for 
			
			
		: ($typeReport="Summary by Type")
			SORT ARRAY:C229(aItems_typeID; aInvoices_TaxJuris; aItems_Class; aItems_SalesGLAccount; aInvoiceLines_taxID; aInvoiceLines_ExtendedPrice; aInvoiceLines_SalesTax; aInvoices_Division; aInvoiceLines_ItemNum)
			//
			For ($i; 1; $k)
				$w:=Find in array:C230(aItems_typeID; atypeID{$i})
				If ($w<0)
					INSERT IN ARRAY:C227(aItemNum; 1; 1)  //InvoiceLine]ItemNum
					INSERT IN ARRAY:C227(atypeID; 1; 1)  //[Item]typeID
					INSERT IN ARRAY:C227(ataxID; 1; 1)  //  InvoiceLine]taxID                   
					INSERT IN ARRAY:C227(aExtendedPrice; 1; 1)  //InvoiceLine]ExtendedPrice
					INSERT IN ARRAY:C227(aSalesTax; 1; 1)  //InvoiceLine]SalesTax
					INSERT IN ARRAY:C227(aTaxJuris; 1; 1)  //[Invoice]TaxJuris
					INSERT IN ARRAY:C227(aProfile1; 1; 1)  //[Invoice]Profile1
					INSERT IN ARRAY:C227(aClass; 1; 1)  //[Item]Class
					INSERT IN ARRAY:C227(aSalesGLAccount; 1; 1)  //[Item]SalesGLAccount
					INSERT IN ARRAY:C227(aInvoiceNum; 1; 1)  //[InvoiceLine]InvoiceNum
					INSERT IN ARRAY:C227(aDivision; 1; 1)  //[Invoice]Division
					INSERT IN ARRAY:C227(aMfgID; 1; 1)
					INSERT IN ARRAY:C227(asalesNameID; 1; 1)
					INSERT IN ARRAY:C227(aRepID; 1; 1)
					aItemNum{1}:="n/a"
					atypeID{1}:=aItems_typeID{$i}
					ataxID{1}:="n/a"
					aExtendedPrice{1}:=aInvoiceLines_ExtendedPrice{$i}
					aSalesTax{1}:=aInvoiceLines_SalesTax{$i}
					aTaxJuris{1}:="n/a"
					aProfile1{1}:="n/a"
					aClass{1}:="n/a"
					aSalesGLAccount{1}:="n/a"
					aInvoiceNum{1}:=-1
					aDivision{1}:=""
				Else 
					aExtendedPrice{$w}:=aExtendedPrice{$w}+aInvoiceLines_ExtendedPrice{$i}
					aSalesTax{$w}:=aSalesTax{$w}+aInvoiceLines_SalesTax{$i}
				End if 
			End for 
			
		: ($typeReport="Summary by Division")
			SORT ARRAY:C229(aInvoices_Division; aItems_typeID; aInvoices_TaxJuris; aItems_Class; aItems_SalesGLAccount; aInvoiceLines_taxID; aInvoiceLines_ExtendedPrice; aInvoiceLines_SalesTax; aInvoiceLines_ItemNum)
			For ($i; 1; $k)
				$w:=Find in array:C230(aDivision; aInvoices_Division{$i})
				If ($w<0)
					INSERT IN ARRAY:C227(aItemNum; 1; 1)  //InvoiceLine]ItemNum
					INSERT IN ARRAY:C227(atypeID; 1; 1)  //[Item]typeID
					INSERT IN ARRAY:C227(ataxID; 1; 1)  //  InvoiceLine]taxID                   
					INSERT IN ARRAY:C227(aExtendedPrice; 1; 1)  //InvoiceLine]ExtendedPrice
					INSERT IN ARRAY:C227(aSalesTax; 1; 1)  //InvoiceLine]SalesTax
					INSERT IN ARRAY:C227(aTaxJuris; 1; 1)  //[Invoice]TaxJuris
					INSERT IN ARRAY:C227(aProfile1; 1; 1)  //[Invoice]Profile1
					INSERT IN ARRAY:C227(aClass; 1; 1)  //[Item]Class
					INSERT IN ARRAY:C227(aSalesGLAccount; 1; 1)  //[Item]SalesGLAccount
					INSERT IN ARRAY:C227(aInvoiceNum; 1; 1)  //[InvoiceLine]InvoiceNum
					INSERT IN ARRAY:C227(aDivision; 1; 1)  //[Invoice]Division
					INSERT IN ARRAY:C227(aMfgID; 1; 1)
					INSERT IN ARRAY:C227(asalesNameID; 1; 1)
					INSERT IN ARRAY:C227(aRepID; 1; 1)
					aItemNum{1}:="n/a"
					atypeID{1}:="n/a"
					ataxID{1}:="n/a"
					aExtendedPrice{1}:=aInvoiceLines_ExtendedPrice{$i}
					aSalesTax{1}:=aInvoiceLines_SalesTax{$i}
					aTaxJuris{1}:="n/a"
					aProfile1{1}:="n/a"
					aClass{1}:="n/a"
					aSalesGLAccount{1}:="n/a"
					aInvoiceNum{1}:=-1
					aDivision{1}:=aInvoices_Division{$i}
				Else 
					aExtendedPrice{$w}:=aExtendedPrice{$w}+aInvoiceLines_ExtendedPrice{$i}
					aSalesTax{$w}:=aSalesTax{$w}+aInvoiceLines_SalesTax{$i}
				End if 
			End for 
			//
			
		: ($typeReport="Detailed by ItemNum")
			SORT ARRAY:C229(aItemNum; aClass; aSalesGLAccount; atypeID; aProfile1; aTaxJuris; ataxID; aInvoiceNum; aDivision; aExtendedPrice; aSalesTax)
		: ($typeReport="Detailed by GL")
			SORT ARRAY:C229(aSalesGLAccount; aClass; atypeID; aProfile1; aTaxJuris; ataxID; aInvoiceNum; aDivision; aItemNum; aExtendedPrice; aSalesTax)
		: ($typeReport="Detailed by Type")  //""
			SORT ARRAY:C229(atypeID; aClass; aSalesGLAccount; aProfile1; aTaxJuris; ataxID; aInvoiceNum; aDivision; aItemNum; aExtendedPrice; aSalesTax)
		: ($typeReport="Detailed by Class")  //""
			SORT ARRAY:C229(aClass; atypeID; aProfile1; aSalesGLAccount; aTaxJuris; ataxID; aInvoiceNum; aDivision; aItemNum; aExtendedPrice; aSalesTax)
		: ($typeReport="Detailed by Division")  //""
			SORT ARRAY:C229(aDivision; aTaxJuris; aSalesGLAccount; atypeID; aProfile1; ataxID; aInvoiceNum; aItemNum; aExtendedPrice; aSalesTax; aClass)
		: ($typeReport="Detailed by TaxJuris")  //""
			SORT ARRAY:C229(aTaxJuris; aDivision; aSalesGLAccount; atypeID; aProfile1; ataxID; aInvoiceNum; aItemNum; aExtendedPrice; aSalesTax; aClass)
			//: ($typeReport="Detailed by TaxJuris/GL")//""
			//multi sort array(aTaxJuris;aDivision;aSalesGLAccount;atypeID
			//;aProfile1;ataxID;aInvoiceNum;aItemNum;aExtendedPrice;aSalesTax;aClass)
			//: ($typeReport="Detailed by TaxJuris/GL/Di")//""
			//multi sort array(aTaxJuris;aDivision;aSalesGLAccount;atypeID
			//;aProfile1;ataxID;aInvoiceNum;aItemNum;aExtendedPrice;aSalesTax;aClass)
	End case 
End if 


ARRAY TEXT:C222(aInvoiceLines_ItemNum; 0)
ARRAY TEXT:C222(aInvoiceLines_taxID; 0)
ARRAY REAL:C219(aInvoiceLines_ExtendedPrice; 0)
ARRAY REAL:C219(aInvoiceLines_SalesTax; 0)
ARRAY TEXT:C222(aInvoices_TaxJuris; 0)
ARRAY TEXT:C222(aInvoices_Profile1; 0)
ARRAY LONGINT:C221(aInvoiceLines_InvoiceNum; 0)
ARRAY TEXT:C222(aInvoices_Division; 0)
//
ARRAY TEXT:C222(aItems_typeID; 0)
ARRAY TEXT:C222(aItems_Class; 0)
ARRAY TEXT:C222(aItems_SalesGLAccount; 0)
