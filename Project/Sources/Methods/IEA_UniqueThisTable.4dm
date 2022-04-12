//%attributes = {"publishedWeb":true}
//Method: IEA_UniqueByTable
//June 7, 2002
C_POINTER:C301($ptTable; $1)
C_BOOLEAN:C305($0)
C_TEXT:C284($curRecStr)
C_LONGINT:C283($curRecLong)
$ptTable:=Table:C252(Table:C252($1))
$0:=False:C215
If (Type:C295($1->)=9)  //LONGINT
	$curRecLong:=$1->
	PUSH RECORD:C176($ptTable->)
	QUERY:C277($ptTable->; $1->=$curRecLong)
	If (Records in selection:C76($ptTable->)=0)
		$0:=True:C214
	End if 
	POP RECORD:C177($ptTable->)
Else 
	$curRecStr:=$1->
	PUSH RECORD:C176($ptTable->)
	QUERY:C277($ptTable->; $1->=$curRecStr)
	If (Records in selection:C76($ptTable->)=0)
		$0:=True:C214
	End if 
	POP RECORD:C177($ptTable->)
End if 