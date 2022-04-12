//%attributes = {"publishedWeb":true}
//Procedure: GL_Post2QuickBo

C_LONGINT:C283($sourceNum; $tableNum)
C_TEXT:C284($source)
C_TEXT:C284($mystring)
C_POINTER:C301($1)
C_LONGINT:C283($tableNum; $result; $i; $k; $raySize; $incRay)
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
	Path_Set(Storage:C1525.folder.jitAudits)
	$transType:="GENERAL JOURNAL"
	$temName:=$temName+Date_strYrMmDd(Current date:C33)+".iif"
	sumDoc:=EI_UniqueDoc(Storage:C1525.folder.jitAudits+$temName)
	
	//  End if 
	If (OK=1)
		ORDER BY:C49($1->; Field:C253($tableNum; 2)->)
		FIRST RECORD:C50($1->)
		$i:=0
		$mystring:="Trans theCustomer"
		C_LONGINT:C283($docCnt)
		$docCnt:=0
		Repeat 
			ARRAY TEXT:C222(aTmp20Str1; 0)
			ARRAY TEXT:C222(aTmp20Str2; 0)
			ARRAY TEXT:C222(aTmp20Str3; 0)
			ARRAY TEXT:C222(aTmp40Str1; 0)
			ARRAY TEXT:C222(aTmp40Str2; 0)
			$docCnt:=$docCnt+1
			SEND PACKET:C103(sumDoc; "!TRNS"+"\t"+"TRNSTYPE"+"\t"+"ACCNT"+"\t"+"AMOUNT"+"\t"+"DATE"+"\t"+"DOCNUM"+"\r")
			SEND PACKET:C103(sumDoc; "!SPL"+"\t"+"TRNSTYPE"+"\t"+"ACCNT"+"\t"+"AMOUNT"+"\t"+"DATE"+"\t"+"DOCNUM"+"\r")
			SEND PACKET:C103(sumDoc; "!ENDTRNS"+"\t"+"\r")
			$sourceNum:=Num:C11(Substring:C12(Field:C253($tableNum; 2)->; 4; 4)+Substring:C12(Field:C253($tableNum; 2)->; 9; 4))
			$source:=Field:C253($tableNum; 2)->
			While (($i<$k) & ($source=Field:C253($tableNum; 2)->))  //[SalesJrnl]Source
				$i:=$i+1
				INSERT IN ARRAY:C227(aTmp20Str1; 1; 1)
				INSERT IN ARRAY:C227(aTmp20Str2; 1; 1)
				INSERT IN ARRAY:C227(aTmp20Str3; 1; 1)
				INSERT IN ARRAY:C227(aTmp40Str1; 1; 1)
				INSERT IN ARRAY:C227(aTmp40Str2; 1; 1)
				INSERT IN ARRAY:C227(aTmp25Str1; 1; 1)
				LOAD RECORD:C52($1->)
				If (Locked:C147($1->))
					aTmp25Str1{1}:="Locked:  "+String:C10(Record number:C243($1->))
					ADD TO SET:C119($1->; "Errors")
				Else 
					aTmp25Str1{1}:=String:C10($sourceNum)  //Journal Line
				End if 
				aTmp20Str1{1}:="SPL"
				aTmp20Str2{1}:=$transType  //type
				aTmp20Str3{1}:=Field:C253($tableNum; 1)->  //Acct code
				aQueryFieldNames{1}:=String:C10(Field:C253($tableNum; 4)->-Field:C253($tableNum; 5)->)  //Amount    [SalesJrnl]Debit-[SalesJrnl]Credit
				aTmp40Str2{1}:=String:C10(Field:C253($tableNum; 3)->)  //Date
				NEXT RECORD:C51($1->)
			End while 
			$raySize:=Size of array:C274(aTmp20Str1)
			aTmp20Str1{1}:="TRNS"  //first line must be TRNS not SPL
			For ($incRay; 1; $raySize)
				SEND PACKET:C103(sumDoc; aTmp20Str1{$incRay}+"\t"+aTmp20Str2{$incRay}+"\t"+aTmp20Str3{$incRay}+"\t"+aQueryFieldNames{$incRay}+"\t"+aTmp40Str2{$incRay}+"\t"+aTmp25Str1{$incRay}+"\r")
			End for 
			SEND PACKET:C103(sumDoc; "ENDTRNS"+"\t"+"\r")
			CLOSE DOCUMENT:C267(sumDoc)
			App_SetSuffix("iif")
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
		Until ($i>=$k)
	End if 
	If (Records in set:C195("Errors")>0)
		USE SET:C118("Errors")
		ProcessTableOpen($1)
	End if 
	CLEAR SET:C117("Errors")
End if 