//%attributes = {}
// ----------------------------------------------------
// User name (OS): root
// Date and time: 08/13/06, 21:40:50
// ----------------------------------------------------
// Method: RecordAcceptTest
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($1; $0; $acceptTests)
C_POINTER:C301($2)
C_LONGINT:C283($theTableNum)
$0:=False:C215
Case of 
	: (ptCurTable=(->[Control:1]))
		$0:=True:C214  //allow printing from Control without saving
	: (Size of array:C274(<>asiteIDs)>1)  // Modified by: williamjames (130215)
		
		Case of 
			: (ptCurTable=(->[Invoice:26]))
				If ([Invoice:26]siteID:86="")
					$0:=False:C215
					If (allowAlerts_boo)
						jAlertMessage(9251)
					End if 
				End if 
			: (ptCurTable=(->[PO:39]))
				If ([PO:39]siteID:74="")
					$0:=False:C215
					If (allowAlerts_boo)
						jAlertMessage(9251)
					End if 
				End if 
			Else 
				
		End case 
End case 
If (ptCurTable#(->[Control:1]))
	If (Size of array:C274(<>aAcceptTest)=0)
		$0:=$1
	Else 
		If (<>aAcceptTest{Table:C252($2)}="")
			$0:=$1
		Else 
			If (booAccept)  // skip Accept test if already false
				C_LONGINT:C283($tableNum; $countTests; $incTM)
				$tableNum:=Table:C252($2)
				If (<>aAcceptTest{$tableNum}="AcceptStack")
					QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="AcceptTestStack"; *)
					QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=$tableNum; *)
					QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0)
					ARRAY TEXT:C222($scriptsAccept; 0)
					$countTM:=Records in selection:C76([TallyMaster:60])
					If ($countTM>0)
						ORDER BY:C49([TallyMaster:60]; [TallyMaster:60]seq:36)
						FIRST RECORD:C50([TallyMaster:60])
						For ($incTM; 1; $countTM)
							APPEND TO ARRAY:C911($scriptsAccept; [TallyMaster:60]script:9)
							NEXT RECORD:C51([TallyMaster:60])
						End for 
					End if 
					vResponse:=""
					REDUCE SELECTION:C351([TallyMaster:60]; 0)
					myOK:=1  // set so the sequence of tests could be approved and dropped out without running all
					For ($incTM; 1; $countTests)
						If ((booAccept) & (myOK=1))
							ExecuteText(0; $scriptsAccept{$incTM})
							$0:=booAccept
							If (myOK=0)
								$incTM:=$countTests
							End if 
						Else 
							booAccept:=(myOK=1)  // if myOK is 1, booAccept drops out as true
							$0:=booAccept
							$incTM:=$countTM
						End if 
					End for 
				Else 
					vResponse:=""
					// ### jwm ### 20190205_0936 update this
					ExecuteText(0; <>aAcceptTest{Table:C252($2)})
					$0:=booAccept
				End if 
				// Else 
				// jAlertMessage (9231)
				If (False:C215)  // turn off acceptTest)
					ARRAY TEXT:C222(<>aAcceptTest; 0)
				End if 
			End if 
		End if 
	End if 
End if 
If ($0=False:C215)  //&(vResponse=""))
	jAlertMessage(9231)
	If (RequiredField#"")
		HIGHLIGHT TEXT:C210(*; RequiredField; 1; 255)
		RequiredField:=""
	End if 
End if 