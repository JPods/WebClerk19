//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/09/06, 12:38:41
// ----------------------------------------------------
// Method: Auth_Verisign
// Description
// This method makes a connection to a beta connection service
// provided by Verisign/Paypal.
//
// Parameters
If (False:C215)
	Version_0606
	
End if 
// ----------------------------------------------------
C_LONGINT:C283($offSet)
If (pvCardAction="Trap@")
	pDescript:="Trapped for processing at order shipment."
Else 
	
	C_TEXT:C284($0)  // any warning message
	$0:=""
	//C_Longint($1;$TransactionType)//transaction type
	
	If (<>AuthNetTestMode=True:C214)
		ALERT:C41("Verisign is in test mode!!!")
	End if 
	
	C_TEXT:C284($curName)
	C_TEXT:C284($firstName; $lastName)
	C_LONGINT:C283($pos; $pos2)  //pos1 = used in loop, pos2 = postion before lastName
	$pos:=0
	$pos2:=0
	$curName:=prntAttn
	
	Repeat 
		$pos2:=$pos2+$pos  //position before last found space
		$pos:=Position:C15(" "; $curName)
		$curName:=Substring:C12($curName; $pos+1)
	Until ($pos=0)
	
	$lastName:=$curName
	If ($pos2>0)  // trim the last space off
		$pos2:=$pos2-1
	End if 
	//$firstName:=Substring(prntAttn;0;$pos2)
	
	
	viAuthStat:=<>ciTASError
	
	C_TEXT:C284($url; $host)  // Eventually these should be defauts or something...
	C_LONGINT:C283($port; $timeout; $err)
	$host:=<>tcCCVerHost  //"pilot-payflowpro.verisign.com"
	$port:=<>tcCCVerPort  //443
	$timeout:=30  // seconds
	pvPayHistory:=""
	C_LONGINT:C283(pvPayResponseCode)
	pvPayResponseCode:=0
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="CreditCards@"; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8="Verisign.net")
	If (Records in selection:C76([TallyMaster:60])=1)
		C_TEXT:C284($beforeScript; $afterScript; $thePath)
		$beforeScript:=[TallyMaster:60]script:9
		$afterScript:=[TallyMaster:60]after:7
		vText4:=[TallyMaster:60]build:6
		$thePath:=[TallyMaster:60]path:28
		If ($beforeScript#"")
			ExecuteText(0; $beforeScript)
		End if 
		
		$post:=TagsToText(vText4)
		vText4:=""
	Else 
		C_TEXT:C284($post; $body; $payAmt)
		//MIKE
		
		$payAmt:=String:C10(vrAuthAmt)
		If (Position:C15("."; $payAmt)=0)
			$payAmt:=$payAmt+".00"
		End if 
		
		$body:="<?xml version=\"1.0\" encoding =\"UTF-8\"?>"+Storage:C1525.char.crlf
		$body:=$body+"<XMLPayRequest version=\"2.0\" xmlns=\"http://www.verisign.com/XMLPay\">"+Storage:C1525.char.crlf
		$body:=$body+"   <RequestData>"+Storage:C1525.char.crlf
		$body:=$body+"      <Vendor>"+<>tcCCVerClientID+"</Vendor>"+Storage:C1525.char.crlf
		$body:=$body+"      <Partner>"+<>tcCCPartner+"</Partner>"+Storage:C1525.char.crlf
		$body:=$body+"      <Transactions>"+Storage:C1525.char.crlf
		$body:=$body+"         <Transaction>"+Storage:C1525.char.crlf
		
		Case of 
			: ((pvCardAction="AUTH_ONLY") | (pvCardAction="AUTH_CAPTURE"))
				If (pvCardAction="AUTH_ONLY")
					$typeTag:="Authorization"
				Else 
					If (pvCardAction="AUTH_CAPTURE")
						$typeTag:="Sale"
					End if 
				End if 
				$body:=$body+"            <"+$typeTag+">"+Storage:C1525.char.crlf
				$body:=$body+"               <PayData>"+Storage:C1525.char.crlf
				$body:=$body+"                  <Invoice>"+Storage:C1525.char.crlf
				$body:=$body+"                     <BillTo>"+Storage:C1525.char.crlf
				$body:=$body+"                        <Address>"+Storage:C1525.char.crlf
				$body:=$body+"                           <Street>"+pvAddress1+"</Street>"+Storage:C1525.char.crlf
				$body:=$body+"                           <City>"+pvCity+"</City>"+Storage:C1525.char.crlf
				$body:=$body+"                           <State>"+pvState+"</State>"+Storage:C1525.char.crlf
				$body:=$body+"                           <Zip>"+pvZip+"</Zip>"+Storage:C1525.char.crlf
				$body:=$body+"                           <Country>"+pvCountry+"</Country>"+Storage:C1525.char.crlf
				$body:=$body+"                        </Address>"+Storage:C1525.char.crlf
				$body:=$body+"                     </BillTo>"+Storage:C1525.char.crlf
				$body:=$body+"                     <TotalAmt>"+$payAmt+"</TotalAmt>"+Storage:C1525.char.crlf
				$body:=$body+"                  </Invoice>"+Storage:C1525.char.crlf
				$body:=$body+"                  <Tender>"+Storage:C1525.char.crlf
				$body:=$body+"                     <Card>"+Storage:C1525.char.crlf
				$body:=$body+"                        <CardNum>"+pCreditCard+"</CardNum>"+Storage:C1525.char.crlf
				$body:=$body+"                        <ExpDate>20"+Substring:C12(vsAuthDate; 3; 2)+Substring:C12(vsAuthDate; 1; 2)+"</ExpDate>"+Storage:C1525.char.crlf
				$body:=$body+"                        <NameOnCard>"+prntAttn+"</NameOnCard>"+Storage:C1525.char.crlf  //$firstName+" "+$lastName+"</NameOnCard>"+Storage.char.crlf
				$body:=$body+"                     </Card>"+Storage:C1525.char.crlf
				$body:=$body+"                  </Tender>"+Storage:C1525.char.crlf
				$body:=$body+"               </PayData>"+Storage:C1525.char.crlf
				$body:=$body+"               <ExtData Name=\"VERBOSITY\" Value=\"HIGH\"/>"+Storage:C1525.char.crlf
				$body:=$body+"               <ExtData Name=\"COMMENT1\" Value=\"\"/>"+Storage:C1525.char.crlf
				$body:=$body+"               <ExtData Name=\"COMMENT2\" Value=\"\"/>"+Storage:C1525.char.crlf
				$body:=$body+"            </"+$typeTag+">"+Storage:C1525.char.crlf
			: ((pvCardAction="PRIOR_AUTH_CAPTURE") | (pvCardAction="VOID") | (pvCardAction="CREDIT"))
				If (pvCardAction="PRIOR_AUTH_CAPTURE")
					$typeTag:="Capture"
				Else 
					If (pvCardAction="VOID")
						$typeTag:="Void"
					Else 
						If (pvCardAction="CREDIT")
							$typeTag:="Credit"
						End if 
					End if 
				End if 
				$body:=$body+"            <"+$typeTag+">"+Storage:C1525.char.crlf
				$body:=$body+"               <PNRef>"+pvProcessorTransID+"</PNRef>"+Storage:C1525.char.crlf
				$body:=$body+"               <ExtData Name=\"VERBOSITY\" Value=\"HIGH\"/>"+Storage:C1525.char.crlf
				$body:=$body+"               <ExtData Name=\"COMMENT1\" Value=\"\"/>"+Storage:C1525.char.crlf
				$body:=$body+"               <ExtData Name=\"COMMENT2\" Value=\"\"/>"+Storage:C1525.char.crlf
				$body:=$body+"            </"+$typeTag+">"+Storage:C1525.char.crlf
				
		End case 
		
		$body:=$body+"         </Transaction>"+Storage:C1525.char.crlf
		$body:=$body+"      </Transactions>"+Storage:C1525.char.crlf
		$body:=$body+"   </RequestData>"+Storage:C1525.char.crlf
		$body:=$body+"   <RequestAuth>"+Storage:C1525.char.crlf
		$body:=$body+"      <UserPass>"+Storage:C1525.char.crlf
		$body:=$body+"         <User>"+<>tcCCVerUserName+"</User>"+Storage:C1525.char.crlf
		$body:=$body+"         <Password>"+<>tcCCVerPassword+"</Password>"+Storage:C1525.char.crlf
		$body:=$body+"      </UserPass>"+Storage:C1525.char.crlf
		$body:=$body+"   </RequestAuth>"+Storage:C1525.char.crlf
		$body:=$body+"</XMLPayRequest>"+Storage:C1525.char.crlf
	End if 
	
	NTK_SetURL($host+"/"+$body)  //this is a good procedure for parsing a complete URL.  Set each variable here.
	//HTTP_TimeOut:=10//seconds
	//HTTP_Protocol:="https"//process as SSL
	//HTTP_Path:=<>tcCCVerURL//Server command
	//HTTP_Host:=<>tcCCVerHost//Server manchine
	//HTTP_Port:=<>tcCCVerPort//the Port
	
	$error:=WC_Request("POST")
	$testText:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17; $offSet; 400)
	SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
	
	If ($testText="Error@")
		ALERT:C41($testText)
	Else 
		
		If (<>logDetails=True:C214)
			C_LONGINT:C283($theEventRecNum)
			$theEventRecNum:=ELog_NewRecord(-8; "Verisign"; "Send="+$post+"\r"+"\r"+"//////////////  Response  //////////////"+$result)
		End if 
		
		$vps_result:=Substring:C12($result; Position:C15("<Result>"; $result))
		$vps_result:=Substring:C12($vps_result; Position:C15(">"; $vps_result)+1)
		$vps_result:=Substring:C12($vps_result; 0; Position:C15("<"; $vps_result)-1)
		
		C_TEXT:C284($xmlValue; $vps_result; $result)
		If (($result#"") & ($vps_result="0"))
			Auth_ParseReturn($result)
			If (pvError="0")
				viAuthStat:=<>ciTASAuthed
				viPayAddWin:=0
				myOK:=1
			Else 
				pCardApprv:="PendErr "+pvError
				pDescript:=" Err: "+pvError+("\r"*(Num:C11(pDescript#"")))+pDescript
			End if 
			$xmlPart:=Substring:C12($result; Position:C15(Storage:C1525.char.crlf+Storage:C1525.char.crlf; $result))
			$xmlDoc:=DOM Parse XML variable:C720($xmlPart)
			vFound:=DOM Find XML element:C864($xmlDoc; "/XMLPayResponse/ResponseData/TransactionResults/TransactionResult/AVSResult/Stree"+"tMatch")
			DOM GET XML ELEMENT VALUE:C731(vFound; $xmlValue)
			
			pDescript:=pDescript+"AVS Street Match: "+$xmlValue+Storage:C1525.char.crlf
			
			vFound:=DOM Find XML element:C864($xmlDoc; "/XMLPayResponse/ResponseData/TransactionResults/TransactionResult/AVSResult/ZipMa"+"tch")
			DOM GET XML ELEMENT VALUE:C731(vFound; $xmlValue)
			
			pDescript:=pDescript+"AVS Zip Match: "+$xmlValue+Storage:C1525.char.crlf
			
			
		Else 
			If ($result="")
				//ALERT("Verisign service unavailable.")
			Else 
				$xmlPart:=Substring:C12($result; Position:C15(Storage:C1525.char.crlf+Storage:C1525.char.crlf; $result))
				If (Length:C16($xmlPart)>10)
					$xmlDoc:=DOM Parse XML variable:C720($xmlPart)
					vFound:=DOM Find XML element:C864($xmlDoc; "/XMLPayResponse/ResponseData/TransactionResults/TransactionResult/Message")
					DOM GET XML ELEMENT VALUE:C731(vFound; $xmlValue)
					
					//ALERT("Error Msg: "+$vps_result+" "+$xmlValue)
					pDescript:=$xmlValue
					viAuthStat:=<>ciTASError
				Else 
					//ALERT("Error Msg: "+$vps_result+" "+$xmlValue)
					pDescript:=$xmlValue
					viAuthStat:=<>ciTASError
				End if 
			End if 
		End if 
	End if 
	
End if 