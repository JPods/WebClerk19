//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/27/13, 16:16:03
// ----------------------------------------------------
// Method: PopEmailToCallReport
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $msgFolder)
If (Count parameters:C259=1)
	$msgFolder:=$1
Else 
	$msgFolder:=Select folder:C670("")
End if 

C_TEXT:C284($from; $to; $cc; $subject; $BodyContent)
C_LONGINT:C283($BdySize; $Err; $i; $k)

ARRAY TEXT:C222($arrayEmails; 0)
DOCUMENT LIST:C474($msgFolder; $arrayEmails)

$k:=Size of array:C274($arrayEmails)
For ($i; 1; $k)
	//
	
	$doCallReport:=False:C215
	If (".@"#$arrayEmails{$i})
		
		$msgfile:=$msgFolder+$arrayEmails{$i}
		//
		$Err:=MSG_Charset(1; 1)
		$Err:=MSG_FindHeader($msgfile; "From"; $from)
		$Err:=MSG_FindHeader($msgfile; "To"; $to)
		$Err:=MSG_FindHeader($msgfile; "Cc"; $cc)
		$Err:=MSG_FindHeader($msgfile; "Subject"; $subject)
		
		
		
		If ($from#"")
			
			$p:=Position:C15("<"; $to)
			If ($p>0)
				$toName:=Substring:C12($to; 1; $p-1)
				$to:=Substring:C12($to; $p+1)
				$to:=Replace string:C233($to; ">"; "")
				vText1:=$toName
				vText1:=Parse_UnWanted(vText1)
				$toName:=vText1
				vText1:=""
			End if 
			
			$to:=$to
			
			$p:=Position:C15("<"; $from)
			If ($p>0)
				$fromName:=Substring:C12($from; 1; $p-1)
				$from:=Substring:C12($from; $p+1)
				$from:=Replace string:C233($from; ">"; "")
			End if 
			
			$from:=$from
			
			READ ONLY:C145([Employee:19])
			QUERY:C277([Employee:19]; [Employee:19]email:16=$to)
			If (Records in selection:C76([Employee:19])>0)
				FIRST RECORD:C50([Employee:19])
				[CallReport:34]actionBy:3:=[Employee:19]nameID:1
			Else 
				[CallReport:34]actionBy:3:=$to
			End if 
			UNLOAD RECORD:C212([Employee:19])
			
			$from:=$from
			QUERY:C277([GenericPC1:92]; [GenericPC1:92]a01:15=$from; *)
			QUERY:C277([GenericPC1:92];  & [GenericPC1:92]a02:16="Spam")
			If (Records in selection:C76([GenericPC1:92])=0)
				CREATE RECORD:C68([CallReport:34])
				
				QUERY:C277([Customer:2]; [Customer:2]email:81=$from)
				If (Records in selection:C76([Customer:2])>0)
					FIRST RECORD:C50([Customer:2])
					[CallReport:34]tableNum:2:=2
					[CallReport:34]customerID:1:=[Customer:2]customerID:1
					[CallReport:34]company:42:=[Customer:2]company:2
					$doCallReport:=True:C214
				Else 
					QUERY:C277([Contact:13]; [Contact:13]email:35=$from)
					If (Records in selection:C76([Contact:13])>0)
						FIRST RECORD:C50([Contact:13])
						[CallReport:34]tableNum:2:=Table:C252(->[Contact:13])
						[CallReport:34]customerID:1:=String:C10([Contact:13]idNum:28)
						[CallReport:34]company:42:=[Contact:13]company:23
						[CallReport:34]contactID:44:=[Contact:13]idNum:28
						
						$doCallReport:=True:C214
					Else 
						QUERY:C277([Rep:8]; [Rep:8]email:22=$from)
						If (Records in selection:C76([Rep:8])>0)
							FIRST RECORD:C50([Rep:8])
							[CallReport:34]tableNum:2:=Table:C252(->[Rep:8])
							[CallReport:34]customerID:1:=[Rep:8]repID:1
							[CallReport:34]company:42:=[Rep:8]company:2
							$doCallReport:=True:C214
						Else 
							QUERY:C277([Vendor:38]; [Vendor:38]email:59=$from)
							If (Records in selection:C76([Vendor:38])>0)
								FIRST RECORD:C50([Vendor:38])
								[CallReport:34]tableNum:2:=Table:C252(->[Vendor:38])
								[CallReport:34]customerID:1:=[Vendor:38]vendorID:1
								[CallReport:34]company:42:=[Vendor:38]company:2
								$doCallReport:=True:C214
							End if 
						End if 
					End if 
				End if 
			End if 
			
			If ($doCallReport)
				
				[CallReport:34]action:15:="Unread Email"
				[CallReport:34]status:34:="Unread"
				[CallReport:34]dateDocument:17:=Current date:C33
				[CallReport:34]feedbackTags:19:="Inbound Email"
				
				[CallReport:34]email:38:=$from
				[CallReport:34]initiatedBy:23:=$fromName
				[CallReport:34]attention:18:=[CallReport:34]initiatedBy:23
				[CallReport:34]profile1:26:=$toName
				
				[CallReport:34]emailStatus:45:="Unread"
				[CallReport:34]subject:14:=$subject
				If ([CallReport:34]tableNum:2>0)
					[CallReport:34]initiatedBy:23:=Table name:C256([CallReport:34]tableNum:2)
				End if 
				$Err:=MSG_MessageSize($msgfile; $HdrSize; $BdySize; $MsgSize)
				$Err:=MSG_GetBody($msgfile; 0; $BdySize; $BodyContent)
				[CallReport:34]comment:16:=$BodyContent
				
			End if 
			$testPath:=$msgFolder+String:C10(Year of:C25(Current date:C33))+Folder separator:K24:12
			If (Test path name:C476($testPath)#0)
				CREATE FOLDER:C475($testPath)
			End if 
			$testPath:=$testPath+String:C10(Month of:C24(Current date:C33))+Folder separator:K24:12
			If (0#Test path name:C476($testPath))
				CREATE FOLDER:C475($testPath)
			End if 
			$testPath:=$testPath+"CRMail"+String:C10([CallReport:34]idNum:22)+".eml"
			MOVE DOCUMENT:C540($msgfile; $testPath)
			//[CallReport]KeyText:=$testPath  // ### jwm ### 20190109_1440 do not overwrite KeyText
			[CallReport:34]feedbackTags:19:=".eml"
			SAVE RECORD:C53([CallReport:34])
			UNLOAD RECORD:C212([CallReport:34])
		End if 
	End if 
End for 