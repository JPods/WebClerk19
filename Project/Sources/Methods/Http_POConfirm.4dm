//%attributes = {"publishedWeb":true}
//Procedure: Http_POConfirm
C_LONGINT:C283($1)
C_TEXT:C284($0)
ARRAY TEXT:C222(aText1; 48)
aText1{1}:=[Order:3]customerID:1
aText1{2}:=[Order:3]customerPO:3
aText1{3}:=String:C10([Order:3]dateOrdered:4)
aText1{4}:=String:C10([Order:3]dateNeeded:5)
aText1{5}:=[Order:3]repID:8
aText1{6}:=[Order:3]salesNameID:10
aText1{7}:=[Order:3]shipVia:13
aText1{8}:=[Order:3]company:15
aText1{9}:=[Order:3]address1:16
aText1{10}:=[Order:3]address2:17
aText1{11}:=[Order:3]city:18
aText1{12}:=[Order:3]state:19
aText1{13}:=[Order:3]zip:20
aText1{14}:=[Order:3]country:21
aText1{15}:=[Order:3]typeSale:22
aText1{16}:=[Order:3]terms:23
aText1{17}:=String:C10([Order:3]amount:24)
aText1{18}:=String:C10([Order:3]salesTax:28)
aText1{19}:=String:C10([Order:3]shipTotal:30)
aText1{20}:=String:C10([Order:3]total:27)
aText1{21}:=[Order:3]comment:33
aText1{22}:=[Order:3]takenBy:36
aText1{23}:=[Order:3]attention:44
aText1{24}:=[Order:3]fob:45
aText1{25}:=[Order:3]shipInstruct:46
aText1{26}:=[Order:3]profile1:61
aText1{27}:=[Order:3]profile2:62
aText1{28}:=[Order:3]profile3:63
aText1{29}:=[Order:3]docType:64
aText1{30}:=[Order:3]docReference:65
aText1{31}:=[Order:3]orderedBy:66
aText1{32}:=[Order:3]phone:67
aText1{33}:=[Order:3]addressBillTo:71
aText1{34}:=[Order:3]billToCompany:76
aText1{35}:=<>tcDunsNum
aText1{36}:=Storage:C1525.default.domain
aText1{37}:=Storage:C1525.default.company
aText1{38}:=Storage:C1525.default.address1
aText1{39}:=Storage:C1525.default.address2
aText1{40}:=Storage:C1525.default.city
aText1{41}:=Storage:C1525.default.state
aText1{42}:=Storage:C1525.default.zip
aText1{43}:=Storage:C1525.default.country
aText1{44}:=Storage:C1525.default.email
aText1{45}:=Storage:C1525.default.phone
aText1{46}:=Storage:C1525.default.fax
aText1{47}:=String:C10([Order:3]orderNum:2)
aText1{48}:=[Order:3]taxJuris:43
//
POLn_RaySize(0)  //action add; position; number of elements
C_LONGINT:C283($k; $index)
viPOLnCnt:=0
$k:=Size of array:C274(aOLineNum)
For ($index; 1; $k)
	viPOLnCnt:=$index
	aPOLineAction:=$index
	POLn_RaySize(1; (Size of array:C274(aPOLineAction)+1); 1)  //action add; position; number of elements
	aPOLineAction{$index}:=-3  // -3 new, >-1  unchanged selected rec, - 3000 notes changed selected rec
	aPOLineNum{$index}:=aOLineNum{$index}
	aPOUnitMeas{$index}:=aOUnitMeas{$index}
	aPoUnitWt{$index}:=aOUnitWt{$index}
	aPoUnitCost{$index}:=aOUnitPrice{$index}
	aPoPQBIR{$index}:=-1
	aPoTaxable{$index}:=aOTaxable{$index}
	pQtyShip:=0  //default qty recvd = 0
	aPOSerialRc{$index}:=aOSerialRc{$index}
	
	aPOQtyOrder{$index}:=aOQtyOrder{$index}
	aPOQtyRcvd{$index}:=0
	aPoExtWt{$index}:=aPoUnitWt{$index}*aPOQtyOrder{$index}
	aPODescpt{$index}:=aODescpt{$index}
	//  
	aPODiscnt{$index}:=aODiscnt{$index}
	//  
	aPOVATax{$index}:=0
	aPODateExp{$index}:=aoDateReq{$index}
	aPOOrdRef{$index}:=-[Order:3]orderNum:2
	aPODateRcvd{$index}:=!00-00-00!
	If (aOAltItem{$index}#"")
		aPOVndrAlph{$index}:=aOItemNum{$index}
		aPoItemNum{$index}:=aOAltItem{$index}
	Else 
		aPoItemNum{$index}:=aOItemNum{$index}
	End if 
	aPoSeq{$index}:=$index
	//
	If (True:C214)
		PoLnExtend(aPOLineAction)
	End if 
	//aPOCustRef{$index}:=Storage.default.company
End for 
If ([Order:3]salesTax:28#0)
	$index:=viPOLnCnt+1
	viPOLnCnt:=$index
	aPOLineAction:=viPOLnCnt
	POLn_RaySize(1; (Size of array:C274(aPOLineAction)+1); 1)  //action add; position; number of elements
	aPOLineAction{$index}:=-3  // -3 new, >-1  unchanged selected rec, - 3000 notes changed selected rec
	aPOLineNum{$index}:=viPOLnCnt
	aPOUnitMeas{$index}:="tax"
	aPoUnitCost{$index}:=[Order:3]salesTax:28
	aPoPQBIR{$index}:=-1
	pQtyShip:=0
	aPOSerialRc{$index}:=<>ciSRNotSerialized
	aPOQtyOrder{$index}:=1
	aPOQtyRcvd{$index}:=0
	aPODescpt{$index}:="Sales Tax: "+[Order:3]taxJuris:43
	aPOVATax{$index}:=0
	aPOOrdRef{$index}:=-[Order:3]orderNum:2
	aPOVndrAlph{$index}:="Sales Tax:"+[Order:3]taxJuris:43
	aPoItemNum{$index}:="Sales Tax:"+[Order:3]taxJuris:43
	aPoSeq{$index}:=$index
	aPoDscntUP{$index}:=[Order:3]salesTax:28
	aPOExtCost{$index}:=[Order:3]salesTax:28
	aPOBackLog{$index}:=[Order:3]salesTax:28
End if 
If ([Order:3]shipTotal:30#0)
	$index:=viPOLnCnt+1
	viPOLnCnt:=$index
	aPOLineAction:=viPOLnCnt
	POLn_RaySize(1; (Size of array:C274(aPOLineAction)+1); 1)  //action add; position; number of elements
	aPOLineAction{$index}:=-3  // -3 new, >-1  unchanged selected rec, - 3000 notes changed selected rec
	aPOLineNum{$index}:=viPOLnCnt
	aPOUnitMeas{$index}:="ship"
	aPoUnitCost{$index}:=[Order:3]shipTotal:30
	aPoPQBIR{$index}:=-1
	pQtyShip:=0
	aPOSerialRc{$index}:=<>ciSRNotSerialized
	aPOQtyOrder{$index}:=1
	aPOQtyRcvd{$index}:=0
	aPODescpt{$index}:="Shipping FOB: "+[Order:3]fob:45
	aPOVATax{$index}:=0
	aPOOrdRef{$index}:=-[Order:3]orderNum:2
	aPOVndrAlph{$index}:="Shipping"
	aPoItemNum{$index}:="Shipping"
	aPoSeq{$index}:=$index
	aPoDscntUP{$index}:=[Order:3]shipTotal:30
	aPOExtCost{$index}:=[Order:3]shipTotal:30
	aPOBackLog{$index}:=[Order:3]shipTotal:30
End if 

C_LONGINT:C283($rslt; $doc)
C_TEXT:C284($locItems)


If (False:C215)  //rewrite into web service
	TCStrong_prf_v142_RWVar
	WebService_Version0001
	//myDocName:=Storage.folder.jitExportsF+"webClerk"+String([Order]OrderNum)
	//$0:=myDocName
	//If (HFSExists (myDocName)#0)//Both files exist
	//$rslt:=HFSDelete (myDocName)
	//End if 
	//CreateVarFile(myDocName;"JITA";"Text")
	//$doc:=OpenVarFile (myDocName)
	//WriteVarArray($doc;aText1)
	//WriteVarArray ($doc;aPOQtyOrder)
	//WriteVarArray ($doc;aPOQtyRcvd)
	//WriteVarArray ($doc;aPOQtyNow)
	//WriteVarArray ($doc;aPOLnCmplt)
	//WriteVarArray ($doc;aPoQtyBL)
	//WriteVarArray ($doc;aPODescpt)
	//WriteVarArray ($doc;aPOUnitCost)
	//WriteVarArray ($doc;aPODiscnt)
	//WriteVarArray ($doc;aPoDscntUP)
	//WriteVarArray ($doc;aPOExtCost)
	//WriteVarArray ($doc;aPOVATax)
	//WriteVarArray ($doc;aPOTaxable)
	//WriteVarArray ($doc;aPOUnitMeas)
	//WriteVarArray ($doc;aPoUnitWt)
	//WriteVarArray ($doc;aPoBackLog)
	//WriteVarArray ($doc;aPOLineNum)
	//WriteVarArray ($doc;aPODateExp)
	//WriteVarArray ($doc;aPOOrdRef)
	//WriteVarArray ($doc;aPODateRcvd)
	//WriteVarArray ($doc;aPOSerialRc)
	//WriteVarArray ($doc;aPOSerialNm)
	//WriteVarArray ($doc;aPOVndrAlph)
	//WriteVarArray ($doc;aPoItemNum)
	//WriteVarArray ($doc;aPOLineAction)
	//WriteVarArray ($doc;aPoPQBIR)
	//WriteVarArray ($doc;aPoSeq)
	//WriteVarArray ($doc;aPoLComment)
	//WriteVarArray ($doc;aPoNPCosts)
	//WriteVarArray ($doc;aPoDuties)
	//WriteVarArray ($doc;aPoExtWt)
	////
	//WriteVarArray ($doc;aPOCustRef)
	//WriteVarArray ($doc;aPoSiteRef)
	//CloseVarFile ($doc)
	
	
	
End if 
POLn_RaySize(0)  //action add; position; number of elements
// $1 -> SMTP server address
// $2 -> sender email address
// $3 -> recipient address
// $4 -> message subject
// $5 -> message text
// $6 -> attachment pathname (may be empty)
If ($1=1)
	SMTP_SentBy([Customer:2]salesNameID:59; "email")
	vtEmailReceiver:=[Customer:2]email:81  // $3 -> recipient address
	vtEmailSubject:="Order: "+String:C10([Order:3]orderNum:2; "0000-0000")  //  -> Subject
	vtEmailBody:="Thank you for your order received via webClerk."+"\r"+"Check status at:  http://"+Storage:C1525.default.domain+"\r"+aText1{4}
	vtEmailBody:=vtEmailBody+"\r"+"Total:  "+<>tcMONEYCHAR+String:C10([Order:3]total:27; "###,###,##0.00")+"\r"+"Ordered by:  "+[Order:3]orderedBy:66
	vtEmailPath:=myDocName
	SMTP_SendMsg
	ARRAY TEXT:C222(aText1; 0)
	//If (HFSExists (myDocName)#0)//Both files exist
	//$rslt:=HFSDelete (myDocName)
	//End if 
	//If (HFSExists (myDocName+".hqx")#0)//Both files exist
	//$rslt:=HFSDelete (myDocName+".hqx")
	//End if //
End if 