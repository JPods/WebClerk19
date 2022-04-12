// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/21/07, 13:55:19
// ----------------------------------------------------
// Method: Form Method: iVendors_9
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($formEvent; $curRecNum)
$formEvent:=Form event code:C388
$curRecNum:=Record number:C243([Vendor:38])
Case of 
	: ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)
	: ($formEvent=On Outside Call:K2:11)
		Prs_OutsideCall
	Else 
		If ($formEvent=On Load:K2:1)  //|(booPreNext))//(Before)
			FormSizeAuto  // ### jwm ### 20190430_0748
			jsetBefore(->[Vendor:38])
			$doOnLoad:=True:C214
			//  CHOPPED QA_FillAnswRay(0)
			//  CHOPPED  QA_ALDefine(eAnsListVendors)
			PoArrayManage(0)
			PoLnFillRays(0)
			//  CHOPPED  POALDefine
			//  CHOPPED  POLineALDefine(ePoLines)
			srVarLoad(Table:C252(->[Vendor:38]))
			If (Is new record:C668([Vendor:38]))
				[Vendor:38]vendorID:1:=<>UniqueIDPrefix+String:C10(CounterNew(->[Vendor:38]))
				[Vendor:38]dateOpened:19:=Current date:C33
			Else 
				<>aLastRecNum{Table:C252(ptCurTable)}:=$curRecNum
				jrelateClrFiles(0)
				//  Put  the formating in the form  jFormatPhone(->[Vendor]phone; ->srPhone; ->[Vendor]fax; ->[Vendor]phoneCell)
			End if 
			jNxPvButtonSet
		End if 
		If (ptCurTable#(->[Vendor:38]))  //must be ahead of the next call
			jsetDuringIncl(->[Vendor:38])
			jrelateClrFiles(0)  //rebuild the arrays
		End if 
		If ($curRecNum>-1)
			If (<>aLastRecNum{Table:C252(ptCurTable)}#$curRecNum)  //|($formEvent=On Load))))
				srVarLoad(Table:C252(->[Vendor:38]))  //alert keys on Record number
				<>aLastRecNum{Table:C252(ptCurTable)}:=$curRecNum
				bChangeRec:=0
				jrelateClrFiles(0)
				
				//SET TIMER(60*60*1)
				FontSrchLabels(1)
				////  CHOPPED  ContactsLoad (-1)
				If (<>tcDefaultLockAcctNbr)
					OBJECT SET ENTERABLE:C238(srAcct; False:C215)
				Else 
					OBJECT SET ENTERABLE:C238(srAcct; True:C214)
				End if 
				jNxPvButtonSet
				//  Put  the formating in the form  jFormatPhone(->[Vendor]phone; ->srPhone; ->[Vendor]fax)
				If (([Vendor:38]zone:65=-1) & ([Vendor:38]zip:8#"") & ([Vendor:38]shipVia:63#""))  //should this not be done
					Find Ship Zone(->[Vendor:38]zip:8; ->[Vendor:38]zone:65; ->[Vendor:38]shipVia:63; ->[Vendor:38]country:9; ->[Vendor:38]siteID:97)
				End if 
				curRecNum:=Selected record number:C246([Vendor:38])
			End if 
		End if 
		booAccept:=(([Vendor:38]company:2#"") & ([Vendor:38]vendorID:1#""))
End case 

