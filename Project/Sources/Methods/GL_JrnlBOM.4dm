//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/11/18, 10:05:51
// ----------------------------------------------------
// Method: GL_JrnlBOM
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($V1; $v2; $v3; $Company)
C_LONGINT:C283($r; $cntRay; $jrnlCnt; $result; $w; $k; $r; $vi1)
C_TEXT:C284($GLSource)
C_DATE:C307($GLDate)
C_BOOLEAN:C305($1; $endView)
C_TEXT:C284($temName)
C_TEXT:C284($myDocName)
C_TEXT:C284($dInvItem; $refItem; $dInvGL; $refGL; $strValue1; $strValue2)
//
jBetweenDates("Material Changes")
If (OK=1)
	$dtBegin:=DateTime_Enter(vdDateBeg; ?00:00:00?)
	$dtEnd:=DateTime_Enter(vdDateEnd; ?23:59:59?)
	QUERY:C277([DInventory:36]; [DInventory:36]typeID:14="BM"; *)
	QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15>=$dtBegin; *)
	QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15<=$dtEnd)
	$k:=Records in selection:C76([DInventory:36])
	If ($k>0)
		$BMName:="BM_"+Date_strYrMmDd(Current date:C33)
		$endLoop:=False:C215
		sumDoc:=EI_UniqueDoc(Storage:C1525.folder.jitAudits+$BMName)
		SEND PACKET:C103(sumDoc; "Converted dInventory -- Bill of Materials; "+String:C10(Current time:C178)+"; "+String:C10(Current date:C33)+"."+"\r"+"\r")
		SEND PACKET:C103(sumDoc; "Converting "+String:C10(Records in selection:C76([DInventory:36]))+" records selected."+"\r"+"\r")
		SEND PACKET:C103(sumDoc; "Child Item"+"\t"+"Parent Item"+"\t"+"Parent GL"+"\t"+"typeID"+"\t"+"Reason"+"\t"+"Date"+"\t"+"Record #"+"\t"+"GL"+"\t"+"Debit"+"\t"+"Credit"+"\t"+"Qty"+"\t"+"Unit Cost"+"\t"+"Doc ID"+"\r"+"\r")
		GL_AcctRayInit(0)
		GL_SumRayInit(0)
		//
		ORDER BY:C49([DInventory:36]; [DInventory:36]projectNum:8; [DInventory:36]itemNum:1)
		//  ThermoInitExit ("Converting dInventory";$k;True)
		READ ONLY:C145([DInventory:36])
		FIRST RECORD:C50([DInventory:36])
		For ($w; 1; $k)
			//  ThermoUpdate ($w)
			If (<>ThermoAbort)
				$w:=$k
			End if 
			GL_AcctRayInit(0)
			If ([DInventory:36]itemNum:1#$dInvItem)
				$dInvItem:=[DInventory:36]itemNum:1
				QUERY:C277([Item:4]; [Item:4]itemNum:1=[DInventory:36]itemNum:1)
				$dInvGL:=[Item:4]inventoryGlAccount:23
				UNLOAD RECORD:C212([Item:4])
			End if 
			If ([DInventory:36]note:18#$refItem)
				$refItem:=[DInventory:36]note:18
				QUERY:C277([Item:4]; [Item:4]itemNum:1=[DInventory:36]note:18)
				$refGL:=[Item:4]inventoryGlAccount:23
				//If ($refGL="")
				//$refGL:=$dInvGL
				//End if 
				UNLOAD RECORD:C212([Item:4])
			End if 
			//If (($dInvGL#$refGL)&($refItem#"")&($refItem#$dInvItem))
			$theValue:=([DInventory:36]qtyOnHand:2*[DInventory:36]unitCost:7)
			If ($theValue<0)
				$strValue1:=String:C10(Abs:C99($theValue); <>tcFormatTt)
				$strValue2:="0.00"
				SEND PACKET:C103(sumDoc; [DInventory:36]itemNum:1+"\t"+[DInventory:36]note:18+"\t"+$refGL+"\t"+[DInventory:36]typeID:14+"\t"+[DInventory:36]reason:13+"\t"+String:C10(vDate1)+"\t"+String:C10([DInventory:36]projectNum:8)+"\t"+$dInvGL+"\t"+$strValue2+"\t"+$strValue1+"\t"+String:C10([DInventory:36]qtyOnHand:2)+"\t"+String:C10([DInventory:36]unitCost:7)+"\t"+String:C10([DInventory:36]docid:9)+"\r")
			Else 
				$strValue2:=String:C10(Abs:C99($theValue); <>tcFormatTt)
				$strValue1:="0.00"
				SEND PACKET:C103(sumDoc; [DInventory:36]itemNum:1+"\t"+[DInventory:36]note:18+"\t"+$refGL+"\t"+[DInventory:36]typeID:14+"\t"+[DInventory:36]reason:13+"\t"+String:C10(vDate1)+"\t"+String:C10([DInventory:36]projectNum:8)+"\t"+$dInvGL+"\t"+$strValue2+"\t"+$strValue1+"\t"+String:C10([DInventory:36]qtyOnHand:2)+"\t"+String:C10([DInventory:36]unitCost:7)+"\t"+String:C10([DInventory:36]docid:9)+"\r")
			End if 
			jDateTimeRecov([DInventory:36]dtCreated:15; ->vDate1; ->vTime1)
			GL_JrnlSummary($dInvGL; ""; vDate1; Num:C11($strValue2); Num:C11($strValue1); "")
			//GL_JrnlSummary ($refGL;"";vDate1;Num($strValue1);Num($strValue2);0)
			
			//End if 
			NEXT RECORD:C51([DInventory:36])
		End for 
		SEND PACKET:C103(sumDoc; "\r"+"\r"+"\r")
		$k:=Size of array:C274(aGLAcct)
		SEND PACKET:C103(sumDoc; "GL"+"\t"+"Debit"+"\t"+"Credit"+"\r")
		For ($i; 1; $k)
			SEND PACKET:C103(sumDoc; aGLAcct{$i}+"\t"+String:C10(aGLDebit{$i})+"\t"+String:C10(aGLCredit{$i})+"\r")
		End for 
		UNLOAD RECORD:C212([DInventory:36])
		NEXT RECORD:C51([DInventory:36])
		// ThermoClose 
		UNLOAD RECORD:C212([DefaultAccount:32])
		READ WRITE:C146([DefaultAccount:32])
		GL_AcctRayInit(0)
		GL_SumRayInit(0)
		myTotalCost:=0
		ARRAY TEXT:C222(LCusList; 0)
		ARRAY TEXT:C222(LCusName; 0)
		//  arrayPartClr //July 12, 1995
		CLOSE DOCUMENT:C267(sumDoc)
		spWind:=0
		
		CREATE RECORD:C68([TallyResult:73])
		
		[TallyResult:73]name:1:=$BMName
		[TallyResult:73]purpose:2:="BillMaterials"
		[TallyResult:73]dtCreated:11:=DateTime_Enter
		[TallyResult:73]dtReport:12:=[TallyResult:73]dtCreated:11
		[TallyResult:73]textBlk1:5:=document
		[TallyResult:73]nameProfile1:26:="Document Type"
		[TallyResult:73]profile1:17:="txt"
		
		
		[TallyResult:73]textBlk2:6:=Document to text:C1236(document)
		
		OPEN URL:C673(document)
		
		SAVE RECORD:C53([TallyResult:73])
		ProcessTableOpen(Table:C252(->[TallyResult:73]); ""; "BillMaterials")
		REDUCE SELECTION:C351([TallyResult:73]; 0)
		booSendDoc:=False:C215
	End if 
End if 
