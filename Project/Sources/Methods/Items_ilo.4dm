//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-06-03T00:00:00, 12:10:09
// ----------------------------------------------------
// Method: Items_ilo
// Description
// Modified: 06/03/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20180614_0932 added unloading of related records

C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
		
	: ($formEvent=On Getting Focus:K2:7)
		
	: ($formEvent=On Losing Focus:K2:8)
		
	: ($formEvent=On Close Box:K2:21)
		jCancelButton
		
	: ($formEvent=On Unload:K2:2)
		
		UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
		READ WRITE:C146(ptCurTable->)
		
		UNLOAD RECORD:C212([ItemSpec:31])  //set the record so it can be opened by others
		READ WRITE:C146([ItemSpec:31])
		
		UNLOAD RECORD:C212([BOM:21])  //set the record so it can be opened by others
		READ WRITE:C146([BOM:21])
		
		UNLOAD RECORD:C212([Profile:59])  //set the record so it can be opened by others
		READ WRITE:C146([Profile:59])
		
		UNLOAD RECORD:C212([Usage:5])  //set the record so it can be opened by others
		READ WRITE:C146([Usage:5])
		
		UNLOAD RECORD:C212([ItemXRef:22])  //set the record so it can be opened by others
		READ WRITE:C146([ItemXRef:22])
		
		UNLOAD RECORD:C212([DInventory:36])  //set the record so it can be opened by others
		READ WRITE:C146([DInventory:36])
		
		UNLOAD RECORD:C212([PriceMatrix:105])  //set the record so it can be opened by others
		READ WRITE:C146([PriceMatrix:105])
		
		UNLOAD RECORD:C212([WorkOrder:66])  //set the record so it can be opened by others
		READ WRITE:C146([WorkOrder:66])
		
		UNLOAD RECORD:C212([ItemSiteBucket:136])  //set the record so it can be opened by others
		READ WRITE:C146([ItemSiteBucket:136])
		
		UNLOAD RECORD:C212([ItemWarehouse:117])  //set the record so it can be opened by others
		READ WRITE:C146([ItemWarehouse:117])
		
	: (Outside call:C328)
		OutSide_Do
	Else 
		
		If ((Is new record:C668([Item:4])) & ($formEvent=On Load:K2:1))
			If (<>vItemNumCreate#"")
				vPartNum:=<>vItemNumCreate
				<>vItemNumCreate:=""
			End if 
			Item_New(1; vPartNum; ""; 1; 1)
			// RelatedRelease 
			
			iLoReal1:=0  // Difference  Buckets
			iLoReal2:=0  // Total Buckets
			iLoReal3:=0  // Difference Locations
			iLoReal4:=0  // Total Locations
			iLoReal5:=0  // pending  Locations
		Else 
			// ### jwm ### 20171020_1655 if record number changes relate records
			If (Record number:C243([Item:4])>-1) & (<>aLastRecNum{4}#Record number:C243([Item:4]))
				<>aLastRecNum{4}:=Record number:C243([Item:4])
				RelatedGet
			End if 
		End if 
		C_LONGINT:C283($formEvent; currentRecordNum)
		
		$formEvent:=iLoProcedure(->[Item:4])
		$doMore:=False:C215
		Case of 
			: (iLoRecordNew)  //set in iLoProcedure only once
				$doMore:=True:C214
			: (iLoRecordChange)  //set in iLoProcedure only once
				OBJECT SET ENTERABLE:C238(srItemNum; False:C215)
				$doMore:=True:C214
		End case 
		If ($doMore)
			
			
			If (<>prcControl=114)
				FORM GOTO PAGE:C247(4)
				aPages:=4
				<>prcControl:=0
			End if 
			ENABLE MENU ITEM:C149(3; 4)
			ARRAY TEXT:C222(aItemsProfile1; 0)
			ARRAY TEXT:C222(aItemsProfile2; 0)
			ARRAY TEXT:C222(aItemsProfile3; 0)
			ARRAY TEXT:C222(aItemsProfile4; 0)
			ARRAY TEXT:C222(aItemsProfile5; 0)  // ### jwm ### 20161104_1544
			ARRAY TEXT:C222(aItemsProfile6; 0)  // ### jwm ### 20161104_1544
			//
			ARRAY TEXT:C222(aPriceForecastOptions; 4)
			aPriceForecastOptions{1}:="Lowest Cost"
			aPriceForecastOptions{2}:="Last/Matrix"
			aPriceForecastOptions{3}:="Matrix"
			aPriceForecastOptions{4}:="Test"
			aPriceForecastOptions:=1
			vrTooling:=0
			//
			
			DateTime_DTFrom([Item:4]dtItemDate:33; ->vDate1; ->vTime1)
			DateTime_DTFrom([Item:4]dtBestUseStart:102; ->iLoDate6)
			DateTime_DTFrom([Item:4]dtBestUseEnd:103; ->iLoDate7)
			DateTime_DTFrom([Item:4]dtReviewed:85; ->iLoDate8)
			Item_SetPopups
			srItemNum:=[Item:4]itemNum:1
			//Item_GetSpec 
			
			C_LONGINT:C283(bPriceMatrixLast)
			bPriceMatrixLast:=1
			$doChange:=(UserInPassWordGroup("UnlockRecord"))
			If (Not:C34($doChange))
				OBJECT SET ENTERABLE:C238([Item:4]publish:60; False:C215)
				OBJECT SET ENTERABLE:C238([Item:4]priceA:2; False:C215)
				OBJECT SET ENTERABLE:C238([Item:4]priceB:3; False:C215)
				OBJECT SET ENTERABLE:C238([Item:4]priceC:4; False:C215)
				OBJECT SET ENTERABLE:C238([Item:4]priceD:5; False:C215)
				OBJECT SET ENTERABLE:C238(vRM1; False:C215)
				OBJECT SET ENTERABLE:C238(vRM2; False:C215)
				OBJECT SET ENTERABLE:C238(vRM3; False:C215)
				OBJECT SET ENTERABLE:C238(vRM4; False:C215)
				OBJECT SET ENTERABLE:C238([Item:4]costGLAccount:22; False:C215)
				OBJECT SET ENTERABLE:C238([Item:4]inventoryGlAccount:23; False:C215)
				OBJECT SET ENTERABLE:C238([Item:4]salesGlAccount:21; False:C215)
				OBJECT SET ENTERABLE:C238(vDate1; False:C215)  //###_jwm_### 20100615
				OBJECT SET ENTERABLE:C238(vTime1; False:C215)  //###_jwm_### 20100615
				
			End if 
			$k:=0
			
			// ### jwm ### 20171020_1655 if record number changes relate records
			If (Record number:C243([Item:4])>-1) & (<>aLastRecNum{4}#Record number:C243([Item:4]))
				<>aLastRecNum{4}:=Record number:C243([Item:4])
				RelatedGet
			End if 
			
			vr1:=0
			curRecNum:=Selected record number:C246([Item:4])
			vRM1:=Margin4Price([Item:4]priceA:2; [Item:4]costAverage:13)
			vRM2:=Margin4Price([Item:4]priceB:3; [Item:4]costAverage:13)
			vRM3:=Margin4Price([Item:4]priceC:4; [Item:4]costAverage:13)
			vRM4:=Margin4Price([Item:4]priceD:5; [Item:4]costAverage:13)
			
			// ### jwm ### 20190910_1713 Andy's permission groups seperate from 4D
			If (IsUserInPermissionGroup("SystemAdmins")=False:C215)
				
				OBJECT SET ENTERABLE:C238(*; "LifecycleStatus"; False:C215)
				OBJECT SET ENTERABLE:C238(*; "DateReleased"; False:C215)
				OBJECT SET ENTERABLE:C238(*; "DateRetired1"; False:C215)
				OBJECT SET ENTERABLE:C238(*; "DateArchived"; False:C215)
				
			End if 
			
			Before_New(ptCurTable)  //last thing to do
			
		End if 
		//every cycle
		If (FORM Get current page:C276=3)
			[Item:4]priceD:5:=[Item:4]priceD:5  //force a modification or any change to the spec      
		End if 
		If (False:C215)
			If ((aPages#FORM Get current page:C276) | (vbNxPvPage))  //changing layout  pages
				vbNxPvPage:=False:C215  //use to adj to menu changes in pages   
				Case of 
					: (aPages=4)  //change to case statement if multiple AreaList on multiple pages   
						//  --  CHOPPED  AL_UpdateArrays(eBOMList; -2)
						// -- AL_SetScroll(eBOMList; 1; 1)
						// -- AL_SetScroll(eParentList; 1; 1)
					: (aPages=7)  //ch
					Else 
						// -- AL_SetScroll(eBOMList; 0; 0)
				End case 
			End if 
		End if 
		booAccept:=(([Item:4]itemNum:1#"") & ([Item:4]description:7#""))
		C_TEXT:C284(RequiredField)
		Case of 
			: ([Item:4]itemNum:1="")
				RequiredField:="ItemNum"  // Field or Variable Name // ### jwm ### 20160603_1157 changed from variable20 to ItemNum in layout
				HIGHLIGHT TEXT:C210([Item:4]itemNum:1; 1; 35)
				ALERT:C41("REQUIRED FILED: ItemNum can not be empty")
			: ([Item:4]description:7="")
				RequiredField:="Description"  // Field or Variable Name  // ### jwm ### 20160603_1157 changed from Field8 to Description in Layout
				HIGHLIGHT TEXT:C210([Item:4]description:7; 1; 35)
				ALERT:C41("REQUIRED FILED: Description can not be empty")
			Else 
				RequiredField:=""
		End case 
End case 


