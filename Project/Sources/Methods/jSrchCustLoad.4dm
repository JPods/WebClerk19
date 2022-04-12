//%attributes = {"publishedWeb":true}
//Procedure: jSrchCustLoad

// gqgqgq  

// GetRidOfThis

C_LONGINT:C283(bFind)
C_LONGINT:C283($curRec)
C_POINTER:C301($1; $2; $3; $ptCurFile)  //;$ptMastFile)
C_TEXT:C284(vsEmpty)
C_BOOLEAN:C305($wideSrch; $localSrch; $4; $doAddRec; $doModRec)
$wideSrch:=False:C215
$localSrch:=False:C215
//REDUCE SELECTION([Contact];0)//delete contacts for auto listing
$ptCurFile:=ptCurTable
$curRec:=Record number:C243($1->)
C_BOOLEAN:C305($SrIsAlpha; $SrIsAstrk; $SrIsBlank)
KeyModifierCurrent
If ((Type:C295($3->)=0) | (Type:C295($3->)=2) | (Type:C295($3->)=24))
	$SrIsAlpha:=True:C214
	$SrIsAstrk:=($3->="*")
	$SrIsBlank:=($3->="")
Else 
	$SrIsAlpha:=False:C215
	$SrIsAstrk:=False:C215
	$SrIsBlank:=False:C215
End if 
Case of 
	: (Count parameters:C259=4)
		$wideSrch:=True:C214
		If ($4)
			If ($SrIsAlpha)
				QUERY:C277($1->; $2->=$3->+"@"; *)
			Else 
				QUERY:C277($1->; $2->=$3->; *)
			End if 
			If (CmdKey=0)
				Case of 
					: ($1=(->[Customer:2]))
						QUERY:C277([Customer:2];  & [Customer:2]dateRetired:111=!00-00-00!; *)
					: ($1=(->[Contact:13]))
						QUERY:C277([Contact:13];  & [Contact:13]dateRetired:57=!00-00-00!; *)
					: ($1=(->[zzzLead:48]))
						QUERY:C277([zzzLead:48];  & [zzzLead:48]retired:56=!00-00-00!; *)
					: ($1=(->[Vendor:38]))
						QUERY:C277([Vendor:38];  & [Vendor:38]dateRetired:90=!00-00-00!; *)
					: ($1=(->[Rep:8]))
						QUERY:C277([Rep:8];  & [Rep:8]dateRetired:44=!00-00-00!; *)
					: ($1=(->[RepContact:10]))
						QUERY:C277([RepContact:10];  & [RepContact:10]dateRetired:24=!00-00-00!; *)
				End case 
			End if 
			QUERY:C277($1->)
		End if 
	: ($2->=$3->)  //No Action
		$doModRec:=False:C215
		$doAddRec:=False:C215
	: (Not:C34(($2->=$3->) | ($SrIsBlank)))
		If ($SrIsAstrk=False:C215)
			If ($SrIsAlpha)
				QUERY:C277($1->; $2->=$3->+"@"; *)
			Else 
				QUERY:C277($1->; $2->=$3->; *)
			End if 
			If (CmdKey=0)
				Case of 
					: ($1=(->[Customer:2]))
						QUERY:C277([Customer:2];  & [Customer:2]dateRetired:111=!00-00-00!; *)
					: ($1=(->[Contact:13]))
						QUERY:C277([Contact:13];  & [Contact:13]dateRetired:57=!00-00-00!; *)
					: ($1=(->[zzzLead:48]))
						QUERY:C277([zzzLead:48];  & [zzzLead:48]retired:56=!00-00-00!; *)
					: ($1=(->[Vendor:38]))
						QUERY:C277([Vendor:38];  & [Vendor:38]dateRetired:90=!00-00-00!; *)
					: ($1=(->[Rep:8]))
						QUERY:C277([Rep:8];  & [Rep:8]dateRetired:44=!00-00-00!; *)
					: ($1=(->[RepContact:10]))
						QUERY:C277([RepContact:10];  & [RepContact:10]dateRetired:24=!00-00-00!; *)
				End case 
			End if 
			QUERY:C277($1->)
		End if 
		$localSrch:=True:C214
	Else 
		REDUCE SELECTION:C351([Customer:2]; 0)
		REDUCE SELECTION:C351([zzzLead:48]; 0)
		REDUCE SELECTION:C351([Vendor:38]; 0)
		REDUCE SELECTION:C351([Contact:13]; 0)  //delete contacts for auto listing
End case 
C_POINTER:C301($ptCurStateTable)
C_LONGINT:C283($vHereCurState)
$vHereCurState:=vHere
$ptCurStateTable:=ptCurTable
If (($localSrch) | ($wideSrch))
	Case of 
		: ((ptCurTable=(->[Vendor:38])) | (ptCurTable=(->[ItemXRef:22])) | (ptCurTable=(->[PO:39])) | (ptCurTable=(->[POLine:40])))
			//ptZip:=[Vendor]Zip
			//ptAcct:=[Vendor]VendorID
			//ptName:=[Vendor]Company
			//ptPhone:=[Vendor]Phone
			REDUCE SELECTION:C351([Customer:2]; 0)
			REDUCE SELECTION:C351([zzzLead:48]; 0)
			REDUCE SELECTION:C351([Contact:13]; 0)  //delete contacts for auto listing
			//$ptMastFile:=([Vendor])
		: (ptCurTable=(->[zzzLead:48]))
			//ptZip:=[Lead]Zip
			//ptAcct:=vsEmpty
			//ptName:=[Lead]Company
			//ptPhone:=[Lead]Phone
			//$ptMastFile:=([Lead])
			REDUCE SELECTION:C351([Customer:2]; 0)
			REDUCE SELECTION:C351([Vendor:38]; 0)
			REDUCE SELECTION:C351([Contact:13]; 0)  //delete contacts for auto listing
		: (ptCurTable=(->[Contact:13]))
			//ptZip:=[Lead]Zip
			//ptAcct:=vsEmpty
			//ptName:=[Lead]Company
			//ptPhone:=[Lead]Phone
			//$ptMastFile:=([Lead])
			REDUCE SELECTION:C351([Customer:2]; 0)
			REDUCE SELECTION:C351([Vendor:38]; 0)
			REDUCE SELECTION:C351([zzzLead:48]; 0)  //delete contacts for auto listing
		Else 
			//ptZip:=[Customer]Zip
			//ptAcct:=[Customer]customerID
			//ptName:=[Customer]Company
			//ptPhone:=[Customer]Phone
			//$ptMastFile:=([Customer])
			REDUCE SELECTION:C351([zzzLead:48]; 0)
			REDUCE SELECTION:C351([Vendor:38]; 0)
	End case 
	Case of 
		: (($wideSrch) | (Records in selection:C76($1->)>1) | ($SrIsAstrk))
			viFindCustChkbx:=1
			viDropShip:=0  //set for diff between ShipTo and BillTo
			jCenterWindow(700; 580; 1)
			DIALOG:C40([Customer:2]; "diaFindCusPayme")
			CLOSE WINDOW:C154
			Case of 
				: (myOK=1)  //no longer set in window
					If (vHere<2)
						$doAddRec:=True:C214
					Else 
						ALERT:C41("Add Record within the current layout.")
					End if 
				: (myOK=2)
					If ((vHere=2) & (ptCurTable=(->[Customer:2])) | (ptCurTable=(->[Vendor:38])))
						booPreNext:=True:C214
					End if 
					//    
					If (vHere<2)
						$doModRec:=True:C214
						//  Else 
						//       booPreNext:=True//cannot do this it clears booNew Variables          
					End if 
				Else 
					If ($curRec>-1)
						GOTO RECORD:C242($1->; $curRec)
					End if 
			End case 
		: (Records in selection:C76($1->)=1)
			If (ptCurTable=(->[Customer:2]))
				booPreNext:=True:C214
			End if 
			If (ptCurTable#(->[Control:1]))  //October 28, 1997  added, delete the IF when popup is in control screens
				//  CHOPPED  ContactsLoad(-1)
			End if 
		: (Records in selection:C76($1->)=0)
			If ($curRec>-1)
				GOTO RECORD:C242($1->; $curRec)
			End if 
			BEEP:C151
			BEEP:C151
	End case 
	initCustArrays(1)  //changed from 0, is this OK
	//  If ($1=([Customer]))
	//    LastCustRec:=Record number([Customer])
	//  End if 
	If (($localSrch) | ($wideSrch))
		Case of 
			: ((ptCurTable=(->[Vendor:38])) | (ptCurTable=(->[ItemXRef:22])) | (ptCurTable=(->[PO:39])) | (ptCurTable=(->[POLine:40])))
				srZip:=[Vendor:38]zip:8
				srAcct:=[Vendor:38]vendorID:1
				srCustomer:=[Vendor:38]company:2
				srPhone:=[Vendor:38]phone:10
				srDivision:=""
				
			: (ptCurTable=(->[zzzLead:48]))
				srZip:=[zzzLead:48]zip:10
				srAcct:=String:C10([zzzLead:48]idNum:32)
				srCustomer:=[zzzLead:48]company:5
				srPhone:=[zzzLead:48]phone:4
				srDivision:=String:C10(Lead_GetDivision)
				
			: (ptCurTable=(->[Contact:13]))
				srZip:=[Contact:13]zip:11
				srAcct:=String:C10([Contact:13]idNum:28)
				srCustomer:=[Contact:13]company:23
				srPhone:=[Contact:13]phone:30
				srDivision:=String:C10(Lead_GetDivision)
			Else 
				srZip:=[Customer:2]zip:8
				srAcct:=[Customer:2]customerID:1
				srCustomer:=[Customer:2]company:2
				srPhone:=[Customer:2]phone:13
				srDivision:=String:C10(Cust_GetDivision)
				
		End case 
		
		//    srPhone:=ptPhone//try this again but do not load all the other order
		//  Put  the formating in the form  jFormatPhone(->srPhone)  //items in the next procedure.  October 15, 1995
		// srZip:=ptZip
		//srCustomer:=ptName
		// srAcct:=ptAcct
	End if 
End if 
If ($doModRec)
	//KeyModifierCurrent 
	//ConsoleMessage ("TEST: MODIFY RECORD")
	//If (CapKey=0)
	ProcessTableOpen(Table:C252(ptCurTable)*-1)
	//Else 
	//MODIFY RECORD(ptCurTable->)
	//End if 
End if 
If ($doAddRec)
	Process_AddRecord(Table name:C256($1))
End if 