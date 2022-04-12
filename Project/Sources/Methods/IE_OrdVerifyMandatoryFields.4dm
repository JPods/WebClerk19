//%attributes = {"publishedWeb":true}
//Method: PM:  IE_OrdVerifyMandatoryFields
//Noah Dykoski   May 4, 2000 / 12:57 AM
C_BOOLEAN:C305($0)  //True if all listed field are part of the import file
C_POINTER:C301($1; $FieldArrayPtr)
$FieldArrayPtr:=$1
C_POINTER:C301($2; $MandatoryArrayPtr)
$MandatoryArrayPtr:=$2

$0:=True:C214
For ($i; 1; Size of array:C274($MandatoryArrayPtr->))
	$fia:=Find in array:C230($FieldArrayPtr->; $MandatoryArrayPtr->{$i})
	If ($fia=-1)
		$i:=999999999  //terminate
		$0:=False:C215
	End if 
End for 