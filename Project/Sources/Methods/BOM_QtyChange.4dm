//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 03/19/13, 13:34:13
// ----------------------------------------------------
// Method: BOM_QtyChange
// Description
// File: BOM_QtyChange.txt
// Parameters
// ----------------------------------------------------
//invBOMQtyChange
//### jwm ### 20130319_1337
//### jwm ### 20130319_1350
// ### jwm ### 20150722_2319 Script to print inventory label


If (UserInPassWordGroup("Costing"))
	C_LONGINT:C283($k; $i; $2; $adjID; $foundIndex)
	C_REAL:C285($Change; $Qty; $3; $4; $fullCost; $tempCost)
	//C_POINTER($5)
	C_TEXT:C284($1)
	C_BOOLEAN:C305($booStat)
	C_TEXT:C284($Comment)
	TRACE:C157
	C_REAL:C285($QtyRequested)
	ARRAY REAL:C219($aQtyLeftOnHand; 0)
	ARRAY TEXT:C222($aItemNumList; 0)
	
	//C_BOOLEAN($bAccountForQtyOnHand)
	//$bAccountForQtyOnHand:=False
	//CONFIRM("Do you want to account for Quantity on Hand when building
	// forcasts?")
	//If (OK=1)
	//$bAccountForQtyOnHand:=True
	//End if 
	
	If (($2>0) & ($3#0))  //  $2=aItemSrRec           $3=vr2
		$Change:=-$3
		$booStat:=($Change>0)
		QUERY:C277([BOM:21]; [BOM:21]itemNum:1=$1)
		$k:=Records in selection:C76([BOM:21])
		If ($k=0)
			ALERT:C41("Item Number "+$1+" does not have a BOM defined.")
		Else 
			$Comment:=(("BREAK OUT "+String:C10($Change))*Num:C11($booStat))+(("ASSEMBLE "+String:C10(-$Change))*Num:C11(Not:C34($booStat)))
			CONFIRM:C162($Comment+" units of "+$1+".")
			If (OK=1)
				IVNT_dRayInit
				$adjID:=DateTime_DTTo
				aLSQtySO{$2}:=0  //was aQtyRecd, seems this needs to be cleared for BOM to operate
				aLsReason{$2}:="BOM Adj Parent"
				// Modified by: Bill James (2016-01-19T00:00:00 Unintended processing)
				// InvtAdjDiaSave 
				READ ONLY:C145([Item:4])
				CREATE SET:C116([Item:4]; "<>Current")
				$fullCost:=0  //
				C_LONGINT:C283($transID)
				$transID:=-DateTime_DTTo
				FIRST RECORD:C50([BOM:21])
				For ($i; 1; $k)
					$QtyRequested:=[BOM:21]qtyInAssembly:3*$Change  // was $Qty:=[BOM]QtyInAssembly*$Change
					
					//If ($bAccountForQtyOnHand)
					//$foundIndex:=Find in array($aItemNumList;[BOM]ChildItem)
					//If ($foundIndex<0)
					//INSERT ELEMENT($aItemNumList;1)
					//$aItemNumList{1}:=[BOM]ChildItem
					//QUERY([Item];[Item]ItemNum=[BOM]ChildItem)
					//INSERT ELEMENT($aQtyLeftOnHand;1)
					//$aQtyLeftOnHand{1}:=[Item]QtyOnHand
					//$foundIndex:=1
					//End if 
					//
					//BOM_BuildCalcQty ($QtyRequested;$aQtyLeftOnHand{$foundIndex}
					//;$Qty)
					//
					//Else 
					$Qty:=$QtyRequested
					//End if 
					
					QUERY:C277([Item:4]; [Item:4]itemNum:1=[BOM:21]childItem:2)
					//        
					$unitMeasBy:=1
					If ([Item:4]unitOfMeasure:11#"")  // Modified by: williamjames (111216 checked for <= length protection)
						If ([Item:4]unitOfMeasure:11[[1]]="*")
							C_REAL:C285($unitMeasBy)
							$unitMeasBy:=Item_PricePer(->[Item:4]unitOfMeasure:11)
						End if 
					End if 
					//     
					If ([Item:4]profile4:38#"Expensed")
						$fullCost:=$fullCost+($Qty*[Item:4]costAverage:13/$unitMeasBy)
					End if 
					Invt_dRecCreate("BM"; $adjID; 0; $1; $transID; "BOM Adj child"; 1; 0; [BOM:21]childItem:2; $Qty; 0; [Item:4]costAverage:13; $1; vsiteID; 0)  //### jwm ### 20130319_1337
					NEXT RECORD:C51([BOM:21])
				End for 
				If ($booStat)
					$tempCost:=Round:C94($fullCost/$3; <>tcDecimalUC)
					$fullCost:=Round:C94(($4*Num:C11($4>0)); <>tcDecimalUC)
					If ($fullCost#$tempCost)
						CREATE RECORD:C68([TallyResult:73])
						
						[TallyResult:73]name:1:="Accountingdeviations"
						[TallyResult:73]purpose:2:="(M)BOM_QtyChange"
						[TallyResult:73]nameProfile1:26:="Current User"
						[TallyResult:73]profile1:17:=Current user:C182
						[TallyResult:73]nameProfile2:27:="Reason"
						[TallyResult:73]profile2:18:="BOM delta"
						[TallyResult:73]nameProfile3:28:="Process"
						[TallyResult:73]profile3:19:="BOM"
						[TallyResult:73]itemNum:34:=[Item:4]itemNum:1
						[TallyResult:73]dtCreated:11:=DateTime_DTTo
						[TallyResult:73]dtReport:12:=[TallyResult:73]dtCreated:11
						C_REAL:C285($valueDiffer)
						$valueDiffer:=$fullCost+$tempCost
						[TallyResult:73]textBlk1:5:=("Parent item cost differs from combined component costs by:  "+String:C10($fullCost+$tempCost; <>tcFormatUC)+" per unit."+"\r"+"\r"+"There are "+String:C10(Abs:C99($3))+" units, TOTAL "+String:C10(Abs:C99($3*($fullCost+$tempCost)); <>tcFormatUC)+".")
						
						[TallyResult:73]nameReal1:20:="Value"
						[TallyResult:73]real1:13:=$valueDiffer
						
						SAVE RECORD:C53([TallyResult:73])
						ALERT:C41([TallyResult:73]textBlk1:5)
						UNLOAD RECORD:C212([TallyResult:73])
						
						
					End if 
					//  $5:=$fullCost
				Else 
					$fullCost:=Round:C94($fullCost/$Change; <>tcDecimalUC)  //-$fullCost
					ALERT:C41("Building at a unit cost of "+String:C10($fullCost)+".")
				End if 
				Invt_dRecCreate("BM"; $adjID; 0; $1; $transID; "Build by BOM"; 4; 0; $1; $3; 0; $fullCost; ""; vsiteID; 0)  //### jwm ### 20130319_1350
				INVT_dInvtApply
				$3:=0
				READ WRITE:C146([Item:4])
				//     If (booAutoInv)//must be after transaction
				TallyInventory
				//    End if 
				USE SET:C118("<>Current")
				CLEAR SET:C117("<>Current")
				viRecordsInSelection:=Records in selection:C76([Item:4])
				List_FillOpts(viRecordsInSelection; 0)
				//
				If (eItemList>0)
					//  --  CHOPPED  AL_UpdateArrays(eItemList; -2)
				End if 
				
				// ### jwm ### 20150722_2319 Script to print inventory label
				Execute_TallyMaster("Single BOM"; "AdjustInventory"; 1)
				
			End if 
			UNLOAD RECORD:C212([BOM:21])
		End if 
	Else 
		ALERT:C41("No value to apply.")
	End if 
End if 