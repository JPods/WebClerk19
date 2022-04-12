//%attributes = {"publishedWeb":true}
//Procedure: GL_JrnlMtl
C_TEXT:C284($V1; $v2; $v3; $Company)
C_LONGINT:C283($r; $cntRay; $jrnlCnt; $result; $w; $k; $r; $vi1)
C_TEXT:C284($GLSource)
C_DATE:C307($GLDate)
C_BOOLEAN:C305($1; $endView)
C_TEXT:C284($temName)
C_TEXT:C284($myDocName)
C_TEXT:C284($dInvItem; $refItem; $dInvGL; $refGL; $strValue1; $strValue2)
//
READ ONLY:C145([DefaultAccount:32])
TRACE:C157
jBetweenDates("Material Changes")
If (OK=1)
	$dtBegin:=DateTime_Enter(vdDateBeg; ?00:00:00?)
	$dtEnd:=DateTime_Enter(vdDateEnd; ?23:59:59?)
	QUERY:C277([DInventory:36]; [DInventory:36]typeID:14="AJ"; *)
	QUERY:C277([DInventory:36];  | [DInventory:36]typeID:14="MD"; *)
	QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15>=$dtBegin; *)
	QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15<=$dtEnd)
	TRACE:C157
	$k:=Records in selection:C76([DInventory:36])
	If ($k>0)
		GOTO RECORD:C242([DefaultAccount:32]; 0)
		$BMName:="AJ_"+Date_strYrMmDd(Current date:C33)
		$endLoop:=False:C215
		Repeat 
			If (HFS_Exists(Storage:C1525.folder.jitAudits+$BMName)=0)
				sumDoc:=Create document:C266(Storage:C1525.folder.jitAudits+$BMName)
				$endLoop:=True:C214
			Else 
				$vi1:=$vi1+1
				$BMName:=$BMName+String:C10($vi1)
			End if 
		Until ($endLoop)
		SEND PACKET:C103(sumDoc; "Converted dInventory -- Material Adjustments and Draws; "+String:C10(Current time:C178)+"; "+String:C10(Current date:C33)+"."+"\r"+"\r")
		SEND PACKET:C103(sumDoc; "Converting "+String:C10(Records in selection:C76([DInventory:36]))+" records selected."+"\r"+"\r")
		SEND PACKET:C103(sumDoc; "Child Item"+"\t"+"typeID"+"\t"+"Reason"+"\t"+"Date"+"\t"+"Record #"+"\t"+"GL"+"\t"+"Debit"+"\t"+"Credit"+"\t"+"Qty"+"\t"+"Unit Cost"+"\t"+"Doc ID"+"\r"+"\r")
		GL_AcctRayInit(0)
		GL_SumRayInit(0)
		//
		ORDER BY:C49([DInventory:36]; [DInventory:36]itemNum:1)
		
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
			Case of 
				: ([DInventory:36]typeID:14="MD")
					$refGL:=[DefaultAccount:32]materialAdjment:73
				: (([DInventory:36]typeID:14="AJ") & ([DInventory:36]reason:13="Scrap"))
					$refGL:=[DefaultAccount:32]scrapAcct:74
				: ([DInventory:36]typeID:14="AJ")
					$refGL:=[DefaultAccount:32]matlDrawAcct:75
				Else 
					$refGL:=""
			End case 
			If (($dInvGL#$refGL) & ($refGL#""))
				$theValue:=([DInventory:36]qtyOnHand:2*[DInventory:36]unitCost:7)
				If ($theValue>0)
					$strValue1:=String:C10(Abs:C99($theValue); <>tcFormatTt)
					$strValue2:="0.00"
				Else 
					$strValue2:=String:C10(Abs:C99($theValue); <>tcFormatTt)
					$strValue1:="0.00"
				End if 
				jDateTimeRecov([DInventory:36]dtCreated:15; ->vDate1; ->vTime1)
				GL_JrnlSummary($dInvGL; ""; vDate1; Num:C11($strValue1); Num:C11($strValue2); "")
				GL_JrnlSummary($refGL; ""; vDate1; Num:C11($strValue2); Num:C11($strValue1); "")
				SEND PACKET:C103(sumDoc; [DInventory:36]itemNum:1+"\t"+[DInventory:36]typeID:14+"\t"+[DInventory:36]reason:13+"\t"+String:C10(vDate1)+"\t"+String:C10(Record number:C243([DInventory:36]))+"\t"+$dInvGL+"\t"+$strValue1+"\t"+$strValue2+"\t"+String:C10([DInventory:36]qtyOnHand:2)+"\t"+String:C10([DInventory:36]unitCost:7)+"\t"+String:C10([DInventory:36]docid:9)+"\r")
				SEND PACKET:C103(sumDoc; [DInventory:36]itemNum:1+"\t"+[DInventory:36]typeID:14+"\t"+[DInventory:36]reason:13+"\t"+String:C10(vDate1)+"\t"+String:C10(Record number:C243([DInventory:36]))+"\t"+$refGL+"\t"+$strValue2+"\t"+$strValue1+"\r")
			End if 
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
		
		OPEN URL:C673(document)
		
		//spWind:=0
		//spWind:=Open external window(4;40;636;440;8;"";"_4D Calc")//to know
		// if the module is here
		//SP OPEN DOCUMENT (spWind;document)
		CREATE RECORD:C68([TallyResult:73])
		
		[TallyResult:73]name:1:=$BMName
		[TallyResult:73]purpose:2:="MaterialAdjust"
		[TallyResult:73]dtCreated:11:=DateTime_Enter
		[TallyResult:73]dtReport:12:=[TallyResult:73]dtCreated:11
		[TallyResult:73]textBlk1:5:=document
		[TallyResult:73]nameProfile1:26:="Document Type"
		[TallyResult:73]profile1:17:="txt"
		sumDoc:=Open document:C264(document)
		<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
		RECEIVE PACKET:C104(sumDoc; $theText; <>vEoF)
		[TallyResult:73]textBlk2:6:=$theText
		CLOSE DOCUMENT:C267(sumDoc)
		//SP AREA TO FIELD (spWind;Table(->[TallyResult]);Field(->[TallyResults
		//]PictBlk1))
		SAVE RECORD:C53([TallyResult:73])
		ProcessTableOpen(Table:C252(->[TallyResult:73]); ""; "MaterialAdjust")
		REDUCE SELECTION:C351([TallyResult:73]; 0)
		booSendDoc:=False:C215
	End if 
End if 
READ WRITE:C146([DefaultAccount:32])