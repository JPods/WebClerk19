// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/04/15, 14:11:22
// ----------------------------------------------------
// Method: [Default].diaInvAdjusts.Variable169
// Description
// 
//
// Parameters
// ----------------------------------------------------


TRACE:C157

// ### jwm ### 20150721_1518 Check Authority to adjust inventory
C_BOOLEAN:C305($adjByItems)
$adjByItems:=UserInPassWordGroup("AdjustByItem")
If ($adjByItems)
	CONFIRM:C162("Adjust Inventory of Item "+v1+" by "+String:C10(vr2); " Adjust ")
	If (ok=1)
		InvtAdjDiaSave
		// QQQ
		// new method clear and update window
		// ### jwm ### 20150724_1339  begin 
		viRecordsInSelection:=Records in selection:C76([Item:4])
		List_FillOpts(viRecordsInSelection; 0)
		If (eItemList>0)
			//  --  CHOPPED  AL_UpdateArrays(eItemList; -2)
		End if 
		OBJECT SET ENABLED:C1123(b1; False:C215)
		HIGHLIGHT TEXT:C210(v3; 1; 20)
		// ### jwm ### 20150724_1339  end 
		
		// ### jwm ### 20150722_2317
		Execute_TallyMaster("Item"; "AdjustInventory"; 1)
		
	End if 
Else 
	ALERT:C41(Current user:C182+": Does Not Have Authority to Adjust Inventory By Items")
End if   // End Check Group

HIGHLIGHT TEXT:C210(srItem; 1; Length:C16(srItem)+1)  // ### jwm ### 20160622_0857