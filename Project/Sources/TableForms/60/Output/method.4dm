
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/03/17, 14:57:38
// ----------------------------------------------------
// Method: [TallyMaster].Output
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20171103_1457 rebuilt output layout to fix popup menus and add sliders

C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Activate:K2:9)
		FormEventOnActivate
	: ($formEvent=On Close Detail:K2:24)
		FormEventCloseDetail
	: ($formEvent=On Unload:K2:2)
		FormEventOnUnloadOLO
	: ($formEvent=On Display Detail:K2:22)
		FormEventOnDisplayDetail
	: ($formEvent=On Header:K2:17)
		FormEventOnHeader
	: ($formEvent=On Selection Change:K2:29)
		FormEventOnSelectionChange
	: ($formEvent=On Open Detail:K2:23)
		FormEventOnOpenDetail
	: ($formEvent=On Close Box:K2:21)
		FormEventOnCloseBox
	: (($formEvent=On Load:K2:1) & (vHere<<>outLayoutTrigger))  //In header
		If (False:C215)
			TCNavigationChange005
		End if 
		$doChange:=(UserInPassWordGroup("Control"))
		If (Not:C34($doChange))
			ALERT:C41("Must be in the Control Password Group.")
			CANCEL:C270  // close the page
		End if 
		jsetInHeader(->[TallyMaster:60])
		OLO_HereAndMenu
		iLo80String1:=""
		iLo80String2:=""
		iLo80String3:=""
		$doArray:=True:C214
		
		If (False:C215)
			If (HFS_Exists($pathToChoices)=1)
				myDoc:=Open document:C264($pathToChoices)
				If (OK=1)
					<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
					RECEIVE PACKET:C104(myDoc; $textToProcess; <>vEoF)
					CLOSE DOCUMENT:C267(myDoc)
					TextToArray($textToProcess; ->aStandardScripts; "\r")
					C_LONGINT:C283($incRay; $cntRay)
					$cntRay:=Size of array:C274(aStandardScripts)
					For ($incRay; $cntRay; 1; -1)
						If ((aStandardScripts{$incRay}="//@") | (aStandardScripts{$incRay}="<@"))
							DELETE FROM ARRAY:C228(aStandardScripts; $incRay; 1)
						Else 
							$p:=Position:C15(":"; aStandardScripts{$incRay})
							If ($p>1)
								aStandardScripts{$incRay}:=Substring:C12(aStandardScripts{$incRay}; 1; $p-1)
							End if 
						End if 
					End for 
					SORT ARRAY:C229(aStandardScripts)
					If (Size of array:C274(aStandardScripts)>26)
						$doArray:=False:C215
					End if 
				End if 
			End if 
			
		End if 
		
		//: ($formEvent=On Header)
	: ($formEvent=On Outside Call:K2:11)  // (Outside call)
		Prs_OutsideCall
End case 

