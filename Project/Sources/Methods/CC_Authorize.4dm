//%attributes = {"publishedWeb":true}
// CC_Authorize
// Matt Hartzler 20010813

//2auth amount;3Acct Num;4Auth Date;5Auth Status;6Drv Lic State;7Track 1;8Track 2
//9Auth Code;10Reference Num;11Response Text;12Card Type num;13Card Issuer
//14AVS Address;15AVS Zip;16InvoiceNum;17customerID
//transaction type: Auth=1,Auth No Capture=2,Credit=3,Void=4,Post Auth=5
//Card type:Credit=1;T&E=2;PrivateLabel=3,CheckMICR=4,CheckDL=5,Debit(Future)=9
//Status type: pending=0; authed=1; declined=2,
//referal=3, error=4,voided=5,other=6,pick-up=7
If (False:C215)
	//Date: 09/20/02
	//Who: Dan Bentson, Arkware
	//Description: Added $AccntName as param
	
	//Date: 03/12/02
	//Who: Dan Bentson, Arkware
	//Description: Added Comment (optional) to be set to warning message if passed in
	VERSION_960
End if 

C_LONGINT:C283($AuthMode)  // Auth Method
C_LONGINT:C283($1; $TransactionType)  //transaction type
C_POINTER:C301($2; $AuthAmountPtr)
C_POINTER:C301($3; $AcctNumPtr)
C_POINTER:C301($4; $AuthDatePtr)
C_POINTER:C301($5; $AuthStatusPtr)
C_POINTER:C301($6; $DrvLicStatePtr)
C_POINTER:C301($7; $Track1Ptr)
C_POINTER:C301($8; $Track2Ptr)
C_POINTER:C301($9; $AuthCodePtr)
C_POINTER:C301($10; $RefNumPtr)
C_POINTER:C301($11; $ResponseTextPtr)
C_POINTER:C301($12; $CardTypeNumPtr)
C_POINTER:C301($13; $CardIssuerPtr)
C_POINTER:C301($14; $AVSAddressPtr)
C_POINTER:C301($15; $AVSZipPtr)
C_POINTER:C301($16; $InvoiceNumPtr)
C_POINTER:C301($17; $customerIDPtr)
C_POINTER:C301($18; $ProcessorTransIDPtr)
C_POINTER:C301($19; $SalesTax)
C_POINTER:C301($20; $CustPONum)
C_POINTER:C301($21; $AccntName)
C_POINTER:C301($22; $Comment)
$TransactionType:=$1
$AuthAmountPtr:=$2
$AcctNumPtr:=$3
$AuthDatePtr:=$4
$AuthStatusPtr:=$5
$DrvLicStatePtr:=$6
$Track1Ptr:=$7
$Track2Ptr:=$8
$AuthCodePtr:=$9
$RefNumPtr:=$10
$ResponseTextPtr:=$11
$CardTypeNumPtr:=$12
$CardIssuerPtr:=$13
$AVSAddressPtr:=$14
$AVSZipPtr:=$15
$InvoiceNumPtr:=$16
$customerIDPtr:=$17
$ProcessorTransIDPtr:=$18
$SalesTax:=$19
$CustPONum:=$20
$AccntName:=$21

If (Count parameters:C259>=22)
	$Comment:=$22
End if 

C_LONGINT:C283(pPayRecordAuth)
pvProcessorTransID:=""
pvError:=""


pCardApprv:=""
vsReferNum:=""
vsRspnText:=""
pvCardExpire:=""
// Check the [default] to see which method to use
$authMode:=<>tcCcDevice
Case of 
	: ($authMode=<>ciCCDevSOAP)  //CHASE merchant services
		
	: ($authMode=<>ciCCDevCHASE)  //CHASE merchant services
		
		
		
	: ($authMode=<>ciCCDevAuthNet)  //Authorize.net
		
		
		
	: (($authMode=<>ciCCDevMaSu) | ($authMode=<>ciCCDevMaMu))  // Mac Authorize
		TRACE:C157
		
End case 
