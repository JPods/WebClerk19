//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/15/09, 17:15:06
// ----------------------------------------------------
// Method: GL_Post2PeachTr
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TIME:C306(sumDoc)
C_LONGINT:C283($sourceNum)
C_TEXT:C284($source)
C_TEXT:C284($mystring)
C_POINTER:C301($1)
C_LONGINT:C283($tableNum; $result; $i; $k; $raySize; $incRay; $docCNT)
//1, insight; 2, atOnce; 3, Great Plains; 4, MYOB
C_TEXT:C284($temName; $transType)
C_TEXT:C284($myDocName)
Path_Set(Storage:C1525.folder.jitAudits)
$tableNum:=Table:C252($1)
QUERY:C277($1->; Field:C253($tableNum; 8)->=0)
jsetDefaultFile($1)
File_Select("Pending Records are in the Current Selection. Click OK to proceed.")
$k:=Records in selection:C76($1->)
If (($k>0) & (myOK=1))
	Case of 
		: ($1=(->[SalesJournal:50]))
			$temName:="ExpSJ"
		: ($1=(->[PurchaseJournal:51]))
			$temName:="ExpPJ"
			$transType:="CHECK"
		: ($1=(->[CashJournal:52]))
			$temName:="ExpCJ"
			$transType:="DEPOSIT"
	End case 
	TRACE:C157
	$transType:="GENERAL JOURNAL"
	
	If (viSaveChoice=0)
		$temName:=$temName+Date_strYrMmDd(Current date:C33)
		$myDocName:=TC_PutFileNameWC("Name Transfer Document"; $temName)
		If ($myDocName#"")
			If (Length:C16(HFS_ShortName($myDocName))>28)
				$myDocName:=Substring:C12($myDocName; 1; 28)
			End if 
			$docCnt:=$docCnt+1
			sumDoc:=Create document:C266($myDocName+String:C10($docCnt))  //;"txt";"Save Sales Journals")
		Else 
			OK:=0
		End if 
	Else 
		sumDoc:=Create document:C266("")
	End if 
	//  End if 
	If (sumDoc>?00:00:00?)
		ORDER BY:C49($1->; Field:C253($tableNum; 1)->)
		FIRST RECORD:C50($1->)
		$i:=0
		$mystring:="Trans theCustomer"
		C_LONGINT:C283($docCnt)
		$docCnt:=0
		
		
		
		$recInSel:=Records in selection:C76($1->)
		//SEND PACKET(sumDoc;<>cCRLF+"v06.00"+"\t"+"General Journal"+"\t"
		//+String(Field($tableNum;3)->))
		//SEND PACKET(sumDoc;"\t"+""+"\t"+Field($tableNum;1)->+"\t"+Field
		//($tableNum;2)->+"\t"+"0"+"\t"+"")
		//SEND PACKET(sumDoc;"\t"+"0"+"\t"+"N"+"\t"+""+"\t"+"Y"+"\t"+"N"
		//+"\t"+String($recInSel))
		FIRST RECORD:C50($1->)
		For ($incRec; 1; $recInSel)
			SEND PACKET:C103(sumDoc; Txt_Quoted(Field:C253($tableNum; 1)->)+","+Txt_Quoted(String:C10(Field:C253($tableNum; 4)->-Field:C253($tableNum; 5)->))+Storage:C1525.char.crlf)
			NEXT RECORD:C51($1->)
		End for 
		SEND PACKET:C103(sumDoc; Storage:C1525.char.crlf+Storage:C1525.char.crlf)
		$sourceNum:=Num:C11(Substring:C12(Field:C253($tableNum; 2)->; 4; 4)+Substring:C12(Field:C253($tableNum; 2)->; 9; 4))
		$source:=Field:C253($tableNum; 2)->
		
		CLOSE DOCUMENT:C267(sumDoc)
		If (Records in set:C195("Errors")=0)
			$sizeRay:=Records in selection:C76($1->)
			FIRST RECORD:C50($1->)
			For ($incRay; 1; $sizeRay)
				Field:C253($tableNum; 8)->:=2
				SAVE RECORD:C53($1->)
				NEXT RECORD:C51($1->)
			End for 
		Else 
			ALERT:C41("Records "+$source+" contained errors or locked records.  Review and rerun Journal transfer!!!!")
		End if 
	End if 
End if 
If (Records in set:C195("Errors")>0)
	USE SET:C118("Errors")
	ProcessTableOpen($1)
End if 
CLEAR SET:C117("Errors")
