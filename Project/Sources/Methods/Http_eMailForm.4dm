//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-20T00:00:00, 23:53:22
// ----------------------------------------------------
// Method: Http_eMailForm
// Description
// Modified: 12/20/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse; $jitPageList; $jitPageOne; $jitFormDo; $theScript; $sendTo)
$jitAction:=WCapi_GetParameter("Action"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
// use returnPage, returnTable, returnField, returnValue to return to a record
// use returnPage containing AJax to return a text value to the current page
$jitSubject:=WCapi_GetParameter("Subject"; "")
$jitSendTo:=WCapi_GetParameter("SendTo"; "")


Case of 
	: ($jitAction="")
		
		$c:=$1
		$suffix:=""
		$doThis:=0
		
		$jitFormDo:=WCapi_GetParameter("jitFormDo"; "")
		$jitFormat:=WCapi_GetParameter("jitFormat"; "")
		vResponse:=""
		$sendTo:=""
		If ($jitPageOne="")
			$jitPageOne:="eMailForm.html"
		End if 
		If ($jitFormDo#"")
			QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="eMailForms"; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1=$jitFormDo)
			If (Records in selection:C76([TallyResult:73])=1)
				$theScript:=[TallyResult:73]textBlk1:5
				$sendTo:=[TallyResult:73]textBlk2:6
			End if 
		End if 
		REDUCE SELECTION:C351([TallyResult:73]; 0)
		If ($sendTo="")
			Case of 
				: ($jitSendTo#"")
					$sendTo:=$jitSendTo
				: (Storage:C1525.default.email#"")
					$sendTo:=Storage:C1525.default.email
				Else 
					vResponse:="No send to defined."
			End case 
		End if 
		
		
		Case of 
			: ((Storage:C1525.default.emailServer="") | ($sendTo=""))
				vResponse:=vResponse+("<BR>"*Num:C11(vResponse#""))+"No eMail server defined."
				$err:=WC_PageSendWithTags($1; WC_DoPage("Error.html"; ""); 0)
			Else 
				If ($theScript#"")
					$err:=0
					ExecuteText(0; $theScript)
				End if 
				C_LONGINT:C283($p; $pEnd)
				$theText:=$2->
				$theMessage:=""
				$theEnd:=False:C215
				Repeat 
					$theLabel:=""
					$theValue:=""
					$p:=Position:C15("&"; $theText)
					If ($p>0)
						$theText:=Substring:C12($theText; $p+1)
					Else 
						$theEnd:=True:C214
					End if 
					If (Not:C34($theEnd))  //add xml format with format tag
						$p:=Position:C15("="; $theText)
						$pEnd:=Position:C15("&"; $theText)
						If ($p>0)
							$theLabel:=Substring:C12($theText; 1; $p-1)
							If ($pEnd>0)
								$theValue:=Substring:C12($theText; $p+1; $pEnd-$p-1)
							Else 
								$pEnd:=Position:C15("\r"; $theText)
								If ($pEnd>0)
									$theValue:=Substring:C12($theText; $p+1; $pEnd-$p-1)
								Else 
									$theValue:=Substring:C12($theText; $p+1)
								End if 
							End if 
							$theMessage:=$theMessage+("\r"*Num:C11($theMessage#""))+$theLabel+"\t"+$theValue
						Else 
							$theEnd:=True:C214
						End if 
					End if 
				Until ($theEnd)
				//
				vtEmailReceiver:=$sendTo
				vtEmailSubject:=$jitSubject
				vtEmailBody:=vtEmailSubject+"\r"+"\r"+"Received   "+String:C10(Current date:C33)+":  "+String:C10(Current time:C178)
				vtEmailBody:=vtEmailSubject+"\r"+"\r"+$theMessage
				SMTP_SendMsg
				//    
				$err:=WC_PageSendWithTags($1; WC_DoPage($jitPageOne; ""); 0)
		End case 
		
		vResponse:=""
		vcustomerID:=""
End case 