//%attributes = {"publishedWeb":true}
C_LONGINT:C283($w)
C_LONGINT:C283($1; $2)  //change type; new RecID
C_BOOLEAN:C305($doInsert)
$doInsert:=True:C214
If ($1=-1)  //deleting a serial use
	$w:=Find in array:C230(aSrIvRec; $2)  //test to see
	If (($w>0) & (aSrIvAct{$w}=3))  //found in arrays and it is new to current invoice
		DELETE FROM ARRAY:C228(aSrIvAct; $w; 1)  //need to change to id the line
		DELETE FROM ARRAY:C228(aSrIvRec; $w; 1)
		DELETE FROM ARRAY:C228(aSrIvLnNum; $w; 1)
		$doInsert:=False:C215
	End if 
End if 
If ($doInsert)
	$w:=Size of array:C274(aSrIvAct)+1
	INSERT IN ARRAY:C227(aSrIvAct; $w; 1)
	INSERT IN ARRAY:C227(aSrIvRec; $w; 1)
	INSERT IN ARRAY:C227(aSrIvLnNum; $w; 1)
	aSrIvAct{$w}:=$1
	aSrIvRec{$w}:=$2
End if 