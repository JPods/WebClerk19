//%attributes = {"publishedWeb":true}
// Auth_Chase
// Matt Hartzler 20010813

//Chase CC verification.
//DO NOT OPEN ON MAC, IS WINDOWS ONLY
//Revert and close if on Mac and screwed up the Plug-in call

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

If (Not:C34(Is macOS:C1572))
	C_LONGINT:C283($ret)
	C_TEXT:C284($chaseDate)
	C_TEXT:C284($authCode)
	C_TEXT:C284($errorMsg)
	C_TEXT:C284($transid)
	C_TEXT:C284($transtype)
	$transid:=$ProcessorTransIDPtr->
	//$chaseDate:=Util_FormatDate ($AuthDatePtr->;"MM/YY")
	$chaseDate:=Substring:C12($AuthDatePtr->; 1; 2)+"/"+Substring:C12($AuthDatePtr->; 3; 2)
	
	Case of 
		: ($TransactionType=<>ciATAuthCap)
			$transtype:="Auth"
		: ($TransactionType=<>ciATAuthNoC)
			$transtype:="PreAuth"
		: ($TransactionType=<>ciATPstAuth)
			$transtype:="PostAuth"
		: ($TransactionType=<>ciATCredit)
			$transtype:="Credit"
		: ($TransactionType=<>ciATVoid)
			$transtype:="Void"
	End case 
	
	// Call The Pluggin, and assign the results to the outgoing params
	
	C_LONGINT:C283(vLCommentedOut)
	//Commented Out for compile
	//CCAuthTranCHASE ("Y";$transtype;$AcctNumPtr->;$chaseDate;String
	//($AuthAmountPtr->*100);String($InvoiceNumPtr->);$customerIDPtr->;$ret
	//;$authCode;$errorMsg;$transid)
	
	Case of   // Map from Chase pluggin code to theCustomer code
		: ($ret=0)
			$AuthStatusPtr->:=<>ciTASAuthed
		: ($ret=1)
			$AuthStatusPtr->:=<>ciTASDeclin
		Else 
			$AuthStatusPtr->:=<>ciTASError
	End case 
	$AuthCodePtr->:=$authCode
	$ResponseTextPtr->:=$errorMsg
	$ProcessorTransIDPtr->:=$transid
End if 