//%attributes = {"publishedWeb":true}
//Procedure: GL_Sum2Records
//Noah Dykoski  June 25, 1998 / 6:55 PM

C_LONGINT:C283($w; $tableNum)
C_LONGINT:C283($3)
C_TEXT:C284($2)
C_POINTER:C301($1)
C_BOOLEAN:C305($4)
C_TEXT:C284($vText)
$tableNum:=Table:C252($1)
//CREATE EMPTY SET($1;$2)
If (Size of array:C274(aGLAcct)>0)
	If ($4)
		CREATE RECORD:C68([TallyResult:73])
		
		[TallyResult:73]name:1:="AccountingValue"
		[TallyResult:73]purpose:2:="(M)BOM_QtyChange"
		[TallyResult:73]nameProfile1:26:="Current User"
		[TallyResult:73]profile1:17:=Current user:C182
		[TallyResult:73]nameProfile2:27:="Reason"
		[TallyResult:73]profile2:18:="Inv Tally"
		[TallyResult:73]nameProfile3:28:="Process"
		[TallyResult:73]profile3:19:="Inventory"
		[TallyResult:73]dtCreated:11:=DateTime_DTTo
		[TallyResult:73]dtReport:12:=[TallyResult:73]dtCreated:11
	End if 
	$valueDiffer:=0
	For ($w; 1; Size of array:C274(aGLAcct))
		CREATE RECORD:C68($1->)
		C_LONGINT:C283($protectedFieldNum)
		Field:C253($tableNum; 1)->:=aGLAcct{$w}
		Field:C253($tableNum; 2)->:=aGLSource{$w}
		Field:C253($tableNum; 3)->:=aGLDate{$w}
		Field:C253($tableNum; 4)->:=aGLDebit{$w}
		Field:C253($tableNum; 5)->:=aGLCredit{$w}
		Field:C253($tableNum; 6)->:=aGLDiv{$w}
		Field:C253($tableNum; 9)->:=$3
		SAVE RECORD:C53($1->)
		ADD TO SET:C119($1->; $2)
		$valueDiffer:=$valueDiffer+aGLDebit{$w}
		$vText:=aGLAcct{$w}+"\t"+aGLSource{$w}+"\t"+String:C10(aGLDate{$w})+"\t"+String:C10(aGLDebit{$w})+"\t"+String:C10(aGLCredit{$w})+"\t"+String:C10(aGLDiv{$w})+"\r"
		If ($4)
			[TallyResult:73]textBlk1:5:=[TallyResult:73]textBlk1:5+$vText
		Else 
			SEND PACKET:C103(sumDoc; $vText)
		End if 
	End for 
	If ($4)
		[TallyResult:73]nameReal1:20:="Value"
		[TallyResult:73]real1:13:=$valueDiffer
		[TallyResult:73]textBlk1:5:=[TallyResult:73]textBlk1:5+"\r"+vText1
		SAVE RECORD:C53([TallyResult:73])
		UNLOAD RECORD:C212([TallyResult:73])
	End if 
	UNLOAD RECORD:C212($1->)
	vText1:=""
	
	
	
End if 