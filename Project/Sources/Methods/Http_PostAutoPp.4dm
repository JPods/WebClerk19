//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Http_PostAutoPp
End if 
C_TEXT:C284($1; $doc; $crlf; $machine; $m; $response; $temp; $theText)
C_LONGINT:C283($stream; $streamStatus; $err)
C_TEXT:C284($2)  //Packed: userName;password;PO

C_BLOB:C604(HTTP_IncomingBlob)
SET BLOB SIZE:C606(HTTP_Data; 0)
TEXT TO BLOB:C554("/Order_AutoPP?AutoPost="+$2; HTTP_Data; UTF8 text without length:K22:17)
NTK_SetURL($1)  //this is a good procedure for parsing a complete URL.  Set each variable here.
//HTTP_TimeOut:=10//seconds
//HTTP_Protocol:="https"//process as SSL
//HTTP_Path:=<>tcCCVerURL//Server command
//HTTP_Host:=<>tcCCVerHost//Server manchine
//HTTP_Port:=<>tcCCVerPort//the Port
C_BLOB:C604(HTTP_IncomingBlob)
$error:=WC_Request("POST")
$response:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)
SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
If ($response#"")
	$p:=Position:C15("class=ProposalNum"; $response)
	If ($p>0)
		[PO:39]comment:27:="Proposal:  "+Substring:C12($response; $p; 50)+"\r"+[PO:39]comment:27
	End if 
	myDoc:=Create document:C266(Storage:C1525.folder.jitExports; "POWeb"+String:C10([PO:39]poNum:5)+".html")
	If (OK=1)
		SEND PACKET:C103(myDoc; $response)
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 