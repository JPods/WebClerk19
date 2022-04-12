//%attributes = {"publishedWeb":true}
//Procedure: CalInsertRay
//Noah Dykoski  June 25, 1998 / 8:09 PM

C_BOOLEAN:C305($myMatch; $9)
C_LONGINT:C283($i; $6; $w)
C_POINTER:C301($1; $2; $3; $4)
C_TEXT:C284($8)
C_TEXT:C284($5)
C_TEXT:C284($7)
$myMatch:=False:C215
$i:=0
Repeat 
	$i:=$i+1
	$w:=Find in array:C230(aServiceRecs; $6; $i)
	If ($w>0)
		$myMatch:=(aServiceTableName{$w}=$7)
		$i:=$w
	End if 
Until (($w=-1) | ($myMatch) | ($i>=Size of array:C274(aServiceRecs)))
If ($w<0)
	$w:=CalRayRecSet(->aServiceDate; $2; ->aServiceTime; $1)
	INSERT IN ARRAY:C227(aServiceDate; $w)  //add it to the arrays
	INSERT IN ARRAY:C227(aServiceTime; $w)
	INSERT IN ARRAY:C227(aServiceAction; $w)
	INSERT IN ARRAY:C227(aServiceVariable; $w)
	INSERT IN ARRAY:C227(aServiceCompany; $w)
	INSERT IN ARRAY:C227(aServiceAttention; $w)
	INSERT IN ARRAY:C227(aServiceRecs; $w)
	INSERT IN ARRAY:C227(aServiceTableName; $w)
End if 
aServiceTime{$w}:=$1->*1  //  ioTime1  // [Contact]ActionTime 
aServiceDate{$w}:=$2->  // ioDate1  // [Contact]ActionDate
aServiceAction{$w}:=$3->  // [Service]Action  // [Contact]Action 
aServiceVariable{$w}:=$4->  // [Service]NoteType  // [Contact]Profile1
aServiceCompany{$w}:=$5  // [Service]Company  // [Contact]Company
aServiceRecs{$w}:=$6  //  Record number([Service])
aServiceTableName{$w}:=$7  //  "S"  // "i" 
aServiceRecs:=$w
aServiceAttention{$w}:=$8  //  [Service]Attention // [Contact]FirstName+" "+[Contact]LastName
