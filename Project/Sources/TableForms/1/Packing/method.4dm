// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 04/14/10, 14:58:56
// ----------------------------------------------------
// Method: Form Method: Packing
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20141210_2252 added definition for <>wtDitherPC
// ### jwm ### 20141210_2252 initialize <>wtDitherPC to zero

C_LONGINT:C283($formEvent; viScanDefault)
$formEvent:=Form event code:C388
//viScanDefault:=3  // ### jwm ### 20180312_0844


Case of 
		
	: ($formEvent=On Load:K2:1)  //  (before)
		
		OBJECT SET SHORTCUT:C1185(*; "variable91"; "{")
		If (<>closeScale=0)
			OBJECT SET ENABLED:C1123(b53; False:C215)  // stop
			OBJECT SET ENABLED:C1123(b54; True:C214)  // startup
		Else 
			OBJECT SET ENABLED:C1123(b53; True:C214)  // stop
			OBJECT SET ENABLED:C1123(b54; False:C215)  // startup
		End if 
		
		C_LONGINT:C283(srSO; eOrdList; showErrorMessage; bInvoice; vbNegScan)
		C_TEXT:C284(pkScaleText)
		C_REAL:C285(<>wtPrecision; <>wtErrPC; <>wtDitherPC)  // ### jwm ### 20141210_2252 added definition for <>wtDitherPC
		OBJECT SET ENABLED:C1123(b3; False:C215)
		vsBarCdFld:=""
		<>wtPrecision:=3
		<>wtPrecisionPC:=2
		<>wtPrecisionFinalPC:=2
		<>wtTarePC:=60  // Tare Weight Percent Limit
		<>wtDitherFactor:=0.016
		<>wtDitherPC:=0  // ### jwm ### 20141210_2252 initialize <>wtDitherPC to zero
		//
		iLoInteger1:=0  //no scale
		showErrorMessage:=1  //alerts
		iLoInteger3:=0  //AutoAllPackages2Invoice
		viScanByAction:=1
		//viScanByAction:=viScanDefault  // ### jwm ### 20180312_0844   // ### jwm ### 20180831_1617
		iLoReal9:=5
		<>vrWeightProduct:=0
		<>vrWeightScale:=0
		<>vrWeightTare:=0
		<>vrWeightErrPC:=0
		
		vsiteID:=DSSetSiteID
		
		//SET COLOR(<>pkScaleComment;-(White +(256*Green )))
		
		//TRACE
		vsWtFormat:="###,###,###"+("."*Num:C11(<>wtPrecision>0))+("0"*<>wtPrecision)
		<>viPixel:=1
		viCountPrecision:=0
		vsCountFormat:="###,###,###"+("."*Num:C11(viCountPrecision#0))+("0"*viCountPrecision)
		//
		If (HFS_Exists(Storage:C1525.folder.jitPrefPath+"PackagePrefs.txt")=1)
			myDoc:=Open document:C264(Storage:C1525.folder.jitPrefPath+"PackagePrefs.txt")
			If (OK=1)
				XMLArrayManagement(0)
				C_TEXT:C284($workingText)
				<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
				RECEIVE PACKET:C104(myDoc; $workingText; <>vEoF)
				CLOSE DOCUMENT:C267(myDoc)
				XMLParseTags($workingText)
				iLoInteger1:=Num:C11(XMLReturnTagValue("NoScale"; (->aXMLTag); (->aXMLValue); String:C10(iLoInteger1)))
				iLoInteger2:=Num:C11(XMLReturnTagValue("alerts"; (->aXMLTag); (->aXMLValue); String:C10(iLoInteger2)))
				iLoInteger3:=Num:C11(XMLReturnTagValue("AutoAllPackages2Invoice"; (->aXMLTag); (->aXMLValue); String:C10(iLoInteger3)))
				viScanByAction:=Num:C11(XMLReturnTagValue("ScanByAction"; (->aXMLTag); (->aXMLValue); String:C10(viScanByAction)))
				<>wtPrecision:=Num:C11(XMLReturnTagValue("<>wtPrecision"; (->aXMLTag); (->aXMLValue); String:C10(<>wtPrecision)))
				<>wtPrecisionPC:=Num:C11(XMLReturnTagValue("<>wtPrecisionPC"; (->aXMLTag); (->aXMLValue); String:C10(<>wtPrecisionPC)))
				<>wtPrecisionFinalPC:=Num:C11(XMLReturnTagValue("<>wtPrecisionFinalPC"; (->aXMLTag); (->aXMLValue); String:C10(<>wtPrecisionFinalPC)))
			End if 
		End if 
		C_LONGINT:C283(ePackagesList)
		viWtPrecision:=<>wtPrecision
		//
		PKDunnage
		//
		//in the selected box
		LT_FillArrayLoadItems(0)
		C_LONGINT:C283($i; $k; $error)
		LT_ALDefineLoadItems(eLoadList; "Arial"; 14; 2)
		vi5:=1
		$k:=Size of array:C274(aLiTagGroup)
		For ($i; 1; $k)
			If (vi5<=aLiTagGroup{$i})
				vi5:=aLiTagGroup{$i}+1
			End if 
		End for 
		//PackOrdLinesAL from the order
		PkOrderLoad(-1234; eOrdList)
		PackOrdLinesAL(eOrdList; "Arial"; 14; 2)
		//
		//TRACE
		PKArrayManage(Records in selection:C76([LoadTag:88]))
		PKALDefine(eShipList; "Arial"; 14; 2)
		//
		ARRAY TEXT:C222(aTmp20Str1; 6)
		aTmp20Str1{1}:="Manual"
		aTmp20Str1{2}:="Find Item"
		aTmp20Str1{3}:="Pack Item"
		aTmp20Str1{4}:="Find Order"
		aTmp20Str1{5}:="Find Package"
		aTmp20Str1{6}:="Find Invoice"
		aTmp20Str1:=1
		//
		ARRAY TEXT:C222(aTmp20Str2; 6)
		aTmp20Str2{1}:="Process"
		aTmp20Str2{2}:="Box"
		aTmp20Str2{3}:="Pallet"
		aTmp20Str2{4}:="Invoice"
		aTmp20Str2{5}:="Clear"
		aTmp20Str2{6}:="In package"
		aTmp20Str2:=1
		//
		ARRAY TEXT:C222(aTmp20Str3; 2)
		aTmp20Str3{1}:="Shred"
		aTmp20Str3{2}:="Package"
		//aTmp20Str3{3}:="Invoice"
		aTmp20Str3:=1
		//
		ARRAY TEXT:C222(aTmp20Str4; 4)
		aTmp20Str4{1}:="Add By One"
		aTmp20Str4{2}:="Backlog"
		aTmp20Str4{3}:="Manual Override"
		aTmp20Str4{4}:="Package"
		aTmp20Str4:=viScanByAction
		//
		ARRAY TEXT:C222(aPalletsAvailable; 1)
		aPalletsAvailable{1}:="Pallets"
		//aPalletsAvailable{2}:="Add to New Pallet"
		//aPalletsAvailable{3}:="Open Pallet Window"
		aPalletsAvailable:=1
		ARRAY LONGINT:C221(aPalletsUniqueID; 1)
		aPalletsUniqueID{1}:=-1
		//
		REDUCE SELECTION:C351([Invoice:26]; 0)
		PKInvoiceFillArrays(0; 0; 0; 0)  //eInvoiceList)
		PKALInvoice(eInvoiceList; "Arial"; 14; 2)
		
		KeyModifierCurrent
		If (((OptKey=1) & (CmdKey=1)) | (<>vbScaleOn=False:C215))  //(Storage.folder.jitF+"jitScale.txt")=1)  Set in jStartup procedure
			<>pkScaleComment:="Scale Off in Defaults"
			iLoInteger1:=1  //Ignor Wt Checkbox
		Else 
			<>pkScaleComment:="Locating Scale"
			PkScaleStart
		End if 
		
	: (Outside call:C328)
		
		Prs_OutsideCall
		//
	: (After:C31)
		<>closeScale:=0
		$found:=Prs_CheckRunnin("Scale")
		If ($found>0)
			POST OUTSIDE CALL:C329($found)
		End if 
		
	Else 
		
		Case of 
			: (doSearch<1)
			: (doSearch=10)  //added qty or line
				$w:=Find in array:C230(aoUniqueID; vlLineUniqueID)
				If ($w>0)
					aOQtyPack{$w}:=aOQtyPack{$w}+iLoReal3
					aOBackLog{$w}:=aOBackLog{$w}-iLoReal3
					//
					$packQty:=aOQtyBL{$w}-aOQtyPack{$w}
					Case of 
						: (viScanByAction=1)
							iLoReal3:=Num:C11($packQty>0)
							iLoReal4:=Round:C94(iLoReal3*aOUnitWt{$w}; viWtPrecision)
						Else 
							iLoReal3:=$packQty
							iLoReal4:=Round:C94(iLoReal3*aOUnitWt{$w}; viWtPrecision)
					End case 
					
					//  CHOPPED  $error:=AL_GetSelect(eOrdList; aoLnSelect)
					//  CHOPPED  AL_GetScroll(eOrdList; viVert; viHorz)
					//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
					// -- AL_SetSelect(eOrdList; aoLnSelect)
					// -- AL_SetScroll(eOrdList; viVert; viHorz)
				End if 
				
		End case 
		doSearch:=0
		HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
		//
		C_LONGINT:C283($i; $k)
		//calc running selected cnt/wt
		$k:=Size of array:C274(aLiQty)
		<>vrWeightProduct:=0
		iLoReal5:=0
		If ($k>0)
			For ($i; 1; $k)
				iLoReal5:=iLoReal5+aLiQty{$i}
				<>vrWeightProduct:=<>vrWeightProduct+(aLiQty{$i}*aLiUnitWt{$i})
			End for 
		End if 
		C_LONGINT:C283(vInvoiceEnable)
		Case of 
			: (vInvoiceEnable=-1)
				OBJECT SET ENABLED:C1123(bInvoice; False:C215)
			: ((Size of array:C274(aLiQty)=0) | (vInvoiceEnable=1))
				OBJECT SET ENABLED:C1123(bInvoice; True:C214)
			: (Size of array:C274(aLiQty)=0)
				OBJECT SET ENABLED:C1123(bInvoice; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(bInvoice; False:C215)
		End case 
		
		
End case 
