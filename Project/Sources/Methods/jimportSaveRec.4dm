//%attributes = {"publishedWeb":true}
//(P) importSaveRec 
C_TEXT:C284($Match)
C_LONGINT:C283($1; $0; $cntflds)

//TRACE
$fld2:=0
$SrFld2:=0
vCount:=vCount+1
$doQuery2:=False:C215
If (vSearchBy#"")
	$fld:=Find in array:C230(aMatchField; vSearchBy)
	$SrFld:=Find in array:C230(theFields; vSearchBy)
	If (vSearchBy2#"")
		$fld2:=Find in array:C230(aMatchField; vSearchBy2)
		$SrFld2:=Find in array:C230(theFields; vSearchBy2)
		If (($fld2>0) & ($SrFld2>0))
			$doQuery2:=True:C214
			$SrFld2:=theFldNum{$SrFld2}  //get the field number
		End if 
	End if 
	If (($fld#-1) & ($SrFld#-1))
		//$fld:=aMatchNum{$fld}
		$SrFld:=theFldNum{$SrFld}  //get the field number
		$Match:=aMatchType{$fld}
		Case of 
			: (aImpFields{$fld}="")  //force a new uniqueID if there is no value to match
				REDUCE SELECTION:C351(Table:C252(curTableNum)->; 0)
			: (($Match="*") | ($Match="*"))  //"NOT IMPORTED"
				
			: ($Match="z")  //"NOT IMPORTED"
				//        
			: (($Match="A") | ($Match="T"))
				aImpFields{$fld}:=Replace string:C233(aImpFields{$fld}; Char:C90(34)+Char:C90(34); Char:C90(34))
				QUERY:C277(Table:C252(curTableNum)->; Field:C253(curTableNum; $SrFld)->=aImpFields{$fld}; *)
				If ($doQuery2)
					QUERY:C277(Table:C252(curTableNum)->; Field:C253(curTableNum; $SrFld2)->=aImpFields{$fld2}; *)
				End if 
				QUERY:C277(Table:C252(curTableNum)->)
			: (($Match="R") | ($Match="I") | ($Match="L"))
				If (Num:C11(aImpFields{$fld})>0)
					QUERY:C277(Table:C252(curTableNum)->; Field:C253(curTableNum; $SrFld)->=Num:C11(aImpFields{$fld}); *)
					If ($doQuery2)
						QUERY:C277(Table:C252(curTableNum)->; Field:C253(curTableNum; $SrFld2)->=aImpFields{$fld2}; *)
					End if 
					QUERY:C277(Table:C252(curTableNum)->)
				End if 
			: ($Match="H")
				QUERY:C277(Table:C252(curTableNum)->; Field:C253(curTableNum; $SrFld)->=Time:C179(aImpFields{$fld}); *)
				If ($doQuery2)
					QUERY:C277(Table:C252(curTableNum)->; Field:C253(curTableNum; $SrFld2)->=aImpFields{$fld2}; *)
				End if 
				QUERY:C277(Table:C252(curTableNum)->)
			: ($Match="D")
				QUERY:C277(Table:C252(curTableNum)->; Field:C253(curTableNum; $SrFld)->=Date:C102(aImpFields{$fld}); *)
				If ($doQuery2)
					QUERY:C277(Table:C252(curTableNum)->; Field:C253(curTableNum; $SrFld2)->=aImpFields{$fld2}; *)
				End if 
				QUERY:C277(Table:C252(curTableNum)->)
			: ($Match="B")
				If ((aImpFields{$fld}="1") | (aImpFields{$fld}[[1]]="t@") | (aImpFields{$fld}[[1]]="y@"))
					QUERY:C277(Table:C252(curTableNum)->; Field:C253(curTableNum; $SrFld)->=True:C214; *)
					If ($doQuery2)
						QUERY:C277(Table:C252(curTableNum)->; Field:C253(curTableNum; $SrFld2)->=aImpFields{$fld2}; *)
					End if 
					QUERY:C277(Table:C252(curTableNum)->)
				Else 
					QUERY:C277(Table:C252(curTableNum)->; Field:C253(curTableNum; $SrFld)->=False:C215; *)
					If ($doQuery2)
						QUERY:C277(Table:C252(curTableNum)->; Field:C253(curTableNum; $SrFld2)->=aImpFields{$fld2}; *)
					End if 
					QUERY:C277(Table:C252(curTableNum)->)
				End if 
			: ($Match="P")
				ALERT:C41("Picture Files may not be imported.  Use the Clipboard.")
		End case 
		Case of 
			: (Records in selection:C76(Table:C252(curTableNum)->)=0)
				If ((b52=1) & (itemMakeDoc>?00:00:00?))
					SEND PACKET:C103(itemMakeDoc; "Created"+"\t"+aImpFields{$fld}+"\t"+aImpFields{$fld2}+"\r")
				End if 
				CREATE RECORD:C68(Table:C252(curTableNum)->)
				If (curTableNum=4)
					[Item:4]itemNum:1:=aImpFields{$fld}
					[Item:4]dtReviewed:85:=DateTime_Enter(!2001-01-01!; ?00:00:00?)
				End if 
				jimportSaveRay
			: (Records in selection:C76(Table:C252(curTableNum)->)=1)
				jimportSaveRay
			: (Records in selection:C76(Table:C252(curTableNum)->)>1)
				If ((b52=1) & (itemMakeDoc>?00:00:00?))
					SEND PACKET:C103(itemMakeDoc; "Multiple"+"\t"+aImpFields{$fld}+"\t"+aImpFields{$fld2}+"\r")
				End if 
				If (b51=1)
					$cntRec:=Records in selection:C76(Table:C252(curTableNum)->)
					C_LONGINT:C283($incRec; $cntRec)
					FIRST RECORD:C50(Table:C252(curTableNum)->)
					For ($incRec; 1; $cntRec)
						jimportSaveRay
						NEXT RECORD:C51(Table:C252(curTableNum)->)
					End for 
				Else 
					CONFIRM:C162("There are multiple records.  Create an additional record.")
					If (OK=1)
						CREATE RECORD:C68(Table:C252(curTableNum)->)
						jimportSaveRay
					End if 
				End if 
		End case 
	End if 
Else 
	CREATE RECORD:C68(Table:C252(curTableNum)->)
	jimportSaveRay
End if 
ADD TO SET:C119(Table:C252(curTableNum)->; "Imported")
Case of 
	: ($1=1)
		$0:=jimport_FillRay
	: ($1=0)
		jimpGenImpArray
	: ($1=2)  //drive the next load
		$0:=1
End case 