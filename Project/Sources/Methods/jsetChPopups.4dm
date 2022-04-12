//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-05T00:00:00, 13:12:17
// ----------------------------------------------------
// Method: jsetChPopups
// Description
// Modified: 11/05/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


PopUpNameCleanUp  // make sure to rename before making new records


C_LONGINT:C283($c; $i; $k; $w; $incRec; $lenRay; $Ndx; $RIS)
C_POINTER:C301($ptPopRay; $ptProVar)
C_BOOLEAN:C305($OK)
C_OBJECT:C1216($obSelectLists)

MESSAGES OFF:C175
//  CREATE SET([PopUp];"MySet")
C_TEXT:C284($vtList; $vtName)
$vtList:=SelectList_Declare
C_COLLECTION:C1488($vcPopups)
$vcPopups:=Split string:C1554($vtList; ",")
For each ($vtName; $vcPopups)
	SelectList_Init($vtName)
End for each 

// <>aTypeSale must be managed differently
PricingLvlDflts


If (False:C215)
	
	CREATE SET:C116([PopUp:23]; "Current")
	READ ONLY:C145([PopUp:23])
	ALL RECORDS:C47([PopUp:23])
	$c:=Records in table:C83([PopUp:23])
	FIRST RECORD:C50([PopUp:23])
	For ($incRec; 1; $c)
		If ([PopUp:23]arrayName:3="<>aTQStatus")
			// ### bj ### 20181103_2300  for easy testing
			// need to switch this entire approach into standard lists
		End if 
		
		
		ConsoleMessage([PopUp:23]arrayName:3)
		
		
		$lenRay:=40
		Case of 
			: (([PopUp:23]arrayName:3="<>aRequisitionsProfile1") | ([PopUp:23]arrayName:3="<>aRequisitionsProfile2") | ([PopUp:23]arrayName:3="<>aRequisitionsProfile3") | ([PopUp:23]arrayName:3="<>aRequisitionsProfile4") | ([PopUp:23]arrayName:3="<>aRequisitionsStatus"))
				C_TEXT:C284(<>vRequisitionsProfile1; <>vRequisitionsProfile2; <>vRequisitionsProfile3; <>vRequisitionsProfile4; <>vRequisitionsStatus)
				$OK:=True:C214
				$ptProVar:=Get pointer:C304("<>v"+Substring:C12([PopUp:23]arrayName:3; 4))
				$ptProVar->:=[PopUp:23]listName:4
			: (([PopUp:23]arrayName:3="<>aWorkOrdersProfile1") | ([PopUp:23]arrayName:3="<>aWorkOrdersProfile2") | ([PopUp:23]arrayName:3="<>aWorkOrdersProfile3") | ([PopUp:23]arrayName:3="<>aWorkOrdersProfile4"))
				C_TEXT:C284(<>vWorkOrdersProfile1; <>vWorkOrdersProfile2; <>vWorkOrdersProfile3; <>vWorkOrdersProfile3; <>vWorkOrdersProfile4)
				$OK:=True:C214
				$lenRay:=40
				$ptProVar:=Get pointer:C304("<>v"+Substring:C12([PopUp:23]arrayName:3; 4))
				$ptProVar->:=[PopUp:23]listName:4
			: (([PopUp:23]arrayName:3="<>aPOsProfile1") | ([PopUp:23]arrayName:3="<>aPOsProfile2") | ([PopUp:23]arrayName:3="<>aPOsProfile3") | ([PopUp:23]arrayName:3="<>aWorkOrdersStatus"))
				C_TEXT:C284(<>vPOsProfile1; <>vPOsProfile2; <>vPOsProfile3; <>vWorkOrdersStatus)
				$OK:=True:C214
				$lenRay:=40
				$ptProVar:=Get pointer:C304("<>v"+Substring:C12([PopUp:23]arrayName:3; 4))
				$ptProVar->:=[PopUp:23]listName:4
			: (([PopUp:23]arrayName:3="<>aServicePro@") | ([PopUp:23]arrayName:3="<>aServicePro@"))
				C_TEXT:C284(<>vServiceProfile1; <>vServiceProfile2; <>vServiceProfile3; <>vServiceProfile4)
				$OK:=True:C214
				$lenRay:=40
				If ([PopUp:23]arrayName:3="<>@")
					$clipLen:=4
				Else 
					$clipLen:=3
				End if 
				$ptProVar:=Get pointer:C304("<>v"+Substring:C12([PopUp:23]arrayName:3; $clipLen))
				$ptProVar->:=[PopUp:23]listName:4
			: (([PopUp:23]arrayName:3="<>aTypeSale") | ([PopUp:23]arrayName:3="<>aProspect") | ([PopUp:23]arrayName:3="<>aNeed") | ([PopUp:23]arrayName:3="<>aRank") | ([PopUp:23]arrayName:3="<>aConsign") | ([PopUp:23]arrayName:3="<>aPOsStatus"))
				$OK:=True:C214
				$lenRay:=40
			: (([PopUp:23]arrayName:3="<>aProfile1") | ([PopUp:23]arrayName:3="<>aProfile2") | ([PopUp:23]arrayName:3="<>aProfile3") | ([PopUp:23]arrayName:3="<>aProfile4") | ([PopUp:23]arrayName:3="<>aProfile5"))
				$OK:=True:C214
				$lenRay:=40
				$ptProVar:=Get pointer:C304("<>v"+Substring:C12([PopUp:23]arrayName:3; 4))
				$ptProVar->:=[PopUp:23]listName:4
				
				// ### jwm ### 20171109_1153 new contacts popups
			: (([PopUp:23]arrayName:3="<>aContactsProfile1") | ([PopUp:23]arrayName:3="<>aContactsProfile2") | ([PopUp:23]arrayName:3="<>aContactsProfile3") | ([PopUp:23]arrayName:3="<>aContactsProfile4") | ([PopUp:23]arrayName:3="<>aContactsProfile5"))
				$OK:=True:C214
				$lenRay:=40
				$ptProVar:=Get pointer:C304("<>v"+Substring:C12([PopUp:23]arrayName:3; 4))
				$ptProVar->:=[PopUp:23]listName:4
				
				// ### bj ### 20191212_0725 Re write this whole procedure to generalize it.
				
			: (([PopUp:23]arrayName:3="<>aActionsOrders") | ([PopUp:23]arrayName:3="<>aActionsInvoices") | ([PopUp:23]arrayName:3="<>aActionsProposals"))
				$OK:=True:C214
				$lenRay:=40
				
			: (([PopUp:23]arrayName:3="<>aActionsProjects") | ([PopUp:23]arrayName:3="<>aActionsWorkOrders") | ([PopUp:23]arrayName:3="<>aActionsPOs"))
				$OK:=True:C214
				$lenRay:=40
				
			: (([PopUp:23]arrayName:3="<>aActionsVendors") | ([PopUp:23]arrayName:3="<>aActionsContacts"))
				$OK:=True:C214
				$lenRay:=40
				
				
			: (([PopUp:23]arrayName:3="<>aJobType") | ([PopUp:23]arrayName:3="<>aActions") | ([PopUp:23]arrayName:3="<>aReasons") | ([PopUp:23]arrayName:3="<>aBillInstructions"))
				$OK:=True:C214
				$lenRay:=40
			: (([PopUp:23]arrayName:3="<>aActivities") | ([PopUp:23]arrayName:3="<>aStatus") | ([PopUp:23]arrayName:3="<>aServiceReference"))
				$OK:=True:C214
				$lenRay:=40
			: (([PopUp:23]arrayName:3="<>aNoteType") | ([PopUp:23]arrayName:3="<>aSalutation") | ([PopUp:23]arrayName:3="<>aProposalsStatus") | ([PopUp:23]arrayName:3="<>aFOB"))
				$OK:=True:C214
				$lenRay:=40
			: (([PopUp:23]arrayName:3="<>aOrdersProfile1") | ([PopUp:23]arrayName:3="<>aOrdersProfile2") | ([PopUp:23]arrayName:3="<>aOrdersProfile3") | ([PopUp:23]arrayName:3="<>aOrdersProfile3"))
				$OK:=True:C214
				$lenRay:=40
				$ptProVar:=Get pointer:C304("<>v"+Substring:C12([PopUp:23]arrayName:3; 4))
				$ptProVar->:=[PopUp:23]listName:4
				
			: (([PopUp:23]arrayName:3="<>aItemXRefsAction") | ([PopUp:23]arrayName:3="<>aWOdrawsStatus") | ([PopUp:23]arrayName:3="<>aRequisitionsAction") | ([PopUp:23]arrayName:3="<>aPayAction"))
				$OK:=True:C214
				$lenRay:=40
			: (([PopUp:23]arrayName:3="<>aFilCustPro") | ([PopUp:23]arrayName:3="<>aFilPpPro") | ([PopUp:23]arrayName:3="<>aFilPoPro") | ([PopUp:23]arrayName:3="<>aFilInvPro") | ([PopUp:23]arrayName:3="<>aFilOrdPro") | ([PopUp:23]arrayName:3="<>aFilVdPro"))
				// qqqq check to see where and why these are used. If used, improve their name
				// Modified by: Bill James (2016-02-26T00:00:00)
				$OK:=True:C214
				$lenRay:=40
				
			: (([PopUp:23]arrayName:3="<>aItemsType") | ([PopUp:23]arrayName:3="<>aItemsProfile1") | ([PopUp:23]arrayName:3="<>aItemsProfile2") | ([PopUp:23]arrayName:3="<>aItemsProfile3") | ([PopUp:23]arrayName:3="<>aItemsProfile4") | ([PopUp:23]arrayName:3="<>aItemsProfile5") | ([PopUp:23]arrayName:3="<>aItemsProfile6"))  // ### jwm ### 20161102_1501
				$OK:=True:C214
				$lenRay:=40
				$ptProVar:=Get pointer:C304("<>v"+Substring:C12([PopUp:23]arrayName:3; 4))
				$ptProVar->:=[PopUp:23]listName:4
			: (([PopUp:23]arrayName:3="<>aItemSpecProfile1") | ([PopUp:23]arrayName:3="<>aItemSpecProfile2") | ([PopUp:23]arrayName:3="<>aItemSpecProfile3") | ([PopUp:23]arrayName:3="<>aItemSpecProfile4") | ([PopUp:23]arrayName:3="<>aItemSpecProfile5"))
				$OK:=True:C214
				$lenRay:=40
				$ptProVar:=Get pointer:C304("<>v"+Substring:C12([PopUp:23]arrayName:3; 4))
				$ptProVar->:=[PopUp:23]listName:4
			: (([PopUp:23]arrayName:3="<>aItemSpecProfile6") | ([PopUp:23]arrayName:3="<>aItemSpecProfile7") | ([PopUp:23]arrayName:3="<>aItemSpecProfile8") | ([PopUp:23]arrayName:3="<>aItemSpecProfile9") | ([PopUp:23]arrayName:3="<>aItemSpecProfile10"))
				$OK:=True:C214
				$lenRay:=40
				$ptProVar:=Get pointer:C304("<>v"+Substring:C12([PopUp:23]arrayName:3; 4))
				$ptProVar->:=[PopUp:23]listName:4
			: (([PopUp:23]arrayName:3="<>aItemSpecProfile11") | ([PopUp:23]arrayName:3="<>aItemSpecProfile12") | ([PopUp:23]arrayName:3="<>aItemSpecProfile13") | ([PopUp:23]arrayName:3="<>aItemSpecProfile14"))
				$OK:=True:C214
				$lenRay:=40
				$ptProVar:=Get pointer:C304("<>v"+Substring:C12([PopUp:23]arrayName:3; 4))
				$ptProVar->:=[PopUp:23]listName:4
				
			: ([PopUp:23]arrayName:3="<>aTQStatus")
				$OK:=True:C214
				$lenRay:=40
				<>vTQStatus:=[PopUp:23]listName:4
				
			: ([PopUp:23]arrayName:3="<>aItemSpecProfile15")
				<>vItemSpecProfile15:=[PopUp:23]listName:4
				$OK:=True:C214
				$lenRay:=40
			: ([PopUp:23]arrayName:3="<>aItemSpecProfile16")
				<>vItemSpecProfile16:=[PopUp:23]listName:4
				$OK:=True:C214
				$lenRay:=40
			: ([PopUp:23]arrayName:3="<>aItemSpecProfile17")
				<>vItemSpecProfile17:=[PopUp:23]listName:4
				$OK:=True:C214
				$lenRay:=40
			: ([PopUp:23]arrayName:3="<>aItemSpecProfile18")
				<>vItemSpecProfile18:=[PopUp:23]listName:4
				$OK:=True:C214
				$lenRay:=40
			: ([PopUp:23]arrayName:3="<>aItemSpecProfile19")
				<>vItemSpecProfile19:=[PopUp:23]listName:4
				$OK:=True:C214
				$lenRay:=40
			: ([PopUp:23]arrayName:3="<>aItemSpecProfile20")
				<>vItemSpecProfile20:=[PopUp:23]listName:4
				$OK:=True:C214
				$lenRay:=40
			: ([PopUp:23]arrayName:3="<>aItemSpecProfile21")
				<>vItemSpecProfile21:=[PopUp:23]listName:4
				$OK:=True:C214
				$lenRay:=40
			: ([PopUp:23]arrayName:3="<>aProfile6")
				<>vProfile6:=[PopUp:23]listName:4
				$OK:=False:C215
			: ([PopUp:23]arrayName:3="<>aProfile7")
				<>vProfile7:=[PopUp:23]listName:4
				$OK:=False:C215
				// ### jwm ### 20171109_1309 name only new contact popups
			: ([PopUp:23]arrayName:3="<>aContactsProfile6")
				<>vContactsProfile6:=[PopUp:23]listName:4
				$OK:=False:C215
			: ([PopUp:23]arrayName:3="<>aContactsProfile7")
				<>vContactsProfile7:=[PopUp:23]listName:4
				$OK:=False:C215
				
			: (([PopUp:23]arrayName:3="<>aVendorsProfile1") | ([PopUp:23]arrayName:3="<>aVendorsProfile2") | ([PopUp:23]arrayName:3="<>aVendorsProfile3") | ([PopUp:23]arrayName:3="<>aVendorsProfile4") | ([PopUp:23]arrayName:3="<>aVendorsProfile5"))
				C_TEXT:C284(<>vVendorsProfile1; <>vVendorsProfile2; <>vVendorsProfile3; <>vVendorsProfile4; <>vVendorsProfile5)
				$OK:=True:C214
				$lenRay:=40
				$ptProVar:=Get pointer:C304("<>v"+Substring:C12([PopUp:23]arrayName:3; 4))
				$ptProVar->:=[PopUp:23]listName:4
			: ([PopUp:23]arrayName:3="<>aVendorsProfile6")
				<>vVendorsProfile6:=[PopUp:23]listName:4
				$OK:=False:C215
			: ([PopUp:23]arrayName:3="<>aVendorsProfile7")
				<>vVendorsProfile7:=[PopUp:23]listName:4
				$OK:=False:C215
			: (([PopUp:23]arrayName:3="<>aRepsProfile1") | ([PopUp:23]arrayName:3="<>aRepsProfile2") | ([PopUp:23]arrayName:3="<>aRepsProfile3") | ([PopUp:23]arrayName:3="<>aRepsProfile4") | ([PopUp:23]arrayName:3="<>aRepsProfile5"))
				C_TEXT:C284(<>vRepsProfile1; <>vRepsProfile2; <>vRepsProfile3; <>vRepsProfile4; <>vRepsProfile5)
				$OK:=True:C214
				$lenRay:=40
				$ptProVar:=Get pointer:C304("<>v"+Substring:C12([PopUp:23]arrayName:3; 4))
				$ptProVar->:=[PopUp:23]listName:4
			: ([PopUp:23]arrayName:3="<>aStateList")
				<>vStateList:=[PopUp:23]listName:4
				$OK:=True:C214
				$lenRay:=40
			: ([PopUp:23]arrayName:3="<>aCountryList")
				<>vCountryList:=[PopUp:23]listName:4
				$OK:=True:C214
				$lenRay:=40
			: ([PopUp:23]arrayName:3="<>aSector")
				<>vSector:=[PopUp:23]listName:4
				$OK:=True:C214
				$lenRay:=40
				
			: ([PopUp:23]arrayName:3="<>aCustomersPO")
				<>vCustomerPO:=[PopUp:23]listName:4
				$OK:=True:C214
				$lenRay:=40
				
			: ([PopUp:23]arrayName:3="<>aStateList")
				<>vStateList:=[PopUp:23]listName:4
				$OK:=True:C214
				$lenRay:=40
				
			Else 
				
				$OK:=False:C215
		End case 
		If (False:C215)
			DELETE FROM ARRAY:C228(<>aSector; 1; 1)
			SORT ARRAY:C229(<>aSector)
			INSERT IN ARRAY:C227(<>aSector; 1; 1)
			<>aSector{1}:="Sector"
		End if 
		
		If ($OK)
			
			$ptPopRay:=Get pointer:C304([PopUp:23]arrayName:3)
			//  ALL SUBRECORDS([PopUp]Choices)
			//  $k:=Records in sub_selection([PopupChoice])
			QUERY:C277([PopupChoice:134]; [PopupChoice:134]arrayName:1=[PopUp:23]arrayName:3)
			$k:=Records in selection:C76([PopupChoice:134])
			
			// seems wrong to use this test. It looks like %lenRay is never reset from 40
			// for uniformity, chech the system to set all popup arrays to length of 40
			
			//If ($lenRay=40)
			ARRAY TEXT:C222($ptPopRay->; 0)
			//Else 
			//Array Text($ptPopRay->;0)
			// End if 
			
			If ($k>120)
				INSERT IN ARRAY:C227($ptPopRay->; 1; 1)
				$ptPopRay->{1}:="Too many choices, review data"
			Else 
				C_POINTER:C301(ptPopRay)
				
				ptPopRay:=$ptPopRay
				ConsoleMessage("If ($k>120) ")
				//  ALL SUBRECORDS([PopUp]Choices)
				//List_LoadFrom([PopUp]arrayName; ptPopRay; 1)
				
			End if 
			error:=0
			INSERT IN ARRAY:C227($ptPopRay->; 1; 1)
			$ptPopRay->{1}:=[PopUp:23]listName:4
			$ptPopRay->:=1
			If (<>VIDEBUGMODE>410)
				ConsoleMessage([PopUp:23]listName:4+": "+String:C10(error))
			End if 
			
			// special handling of any popup list
			Case of 
				: ([PopUp:23]arrayName:3="<>aItemsType")
					//TRACE
					INSERT IN ARRAY:C227(<>aItemsTypeAlt; 1)
					<>aItemsTypeAlt{1}:=[PopUp:23]listName:4  //+"_alt"
				: ([PopUp:23]arrayName:3="<>aItemsProfile1")
					//TRACE
					INSERT IN ARRAY:C227(<>aItemsProfile1Alt; 1)
					<>aItemsProfile1Alt{1}:=[PopUp:23]listName:4  //+"_alt"
				: ([PopUp:23]arrayName:3="<>aTypeSale")
					PricingLvlDflts
			End case 
		End if 
		NEXT RECORD:C51([PopUp:23])
	End for 
	READ WRITE:C146([PopUp:23])
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
	UNLOAD RECORD:C212([PopUp:23])
	//
	//SEARCH([GLAccount];[GLAccount]FileRefNum=4)
	//Unique values
	KeyModifierCurrent
	$doTally:=(CmdKey=0)
	If ($doTally)
		ARRAY TEXT:C222(aTmp35Str1; 0)
		READ WRITE:C146([TallySummary:77])
		QUERY:C277([TallySummary:77]; [TallySummary:77]longint1:3=1000)
		SELECTION TO ARRAY:C260([TallySummary:77]profile2:2; aTmp35Str1)
		$k:=Size of array:C274(<>aStatus)
		If ($k=(Size of array:C274(aTmp35Str1)+1))
			For ($i; 1; $k)
				$w:=Find in array:C230(aTmp35Str1; <>aStatus{$i})
				If ($w>0)
					DELETE FROM ARRAY:C228(aTmp35Str1; $w; 1)
				End if 
			End for 
			If (Size of array:C274(aTmp35Str1)=0)
				$doTally:=False:C215
			End if 
		End if 
	End if 
	If ($doTally)
		DELETE SELECTION:C66([TallySummary:77])
		$k:=Size of array:C274(<>aStatus)
		For ($i; 2; $k)
			CREATE RECORD:C68([TallySummary:77])
			
			[TallySummary:77]longint1:3:=1000
			[TallySummary:77]profile1:1:="Status"
			[TallySummary:77]profile2:2:=<>aStatus{$i}
			SAVE RECORD:C53([TallySummary:77])
		End for 
	End if 
End if 
