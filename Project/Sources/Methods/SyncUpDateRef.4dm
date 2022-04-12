//%attributes = {"publishedWeb":true}
C_TEXT:C284($2)
C_LONGINT:C283($1; $0; $i; $k)
//SORT ARRAY(aSyFile;aSyField;aSyType;aSyMatWas;aSyMatIs)
//check if this is necessary
$doLoop:=True:C214
$0:=-1
$i:=1
$k:=Size of array:C274(aSyFile)
If ($k>0)
	While (($i<$k) & ($1>aSyFile{$i}))
		$i:=$i+1
	End while 
	While (($i<=$k) & ($1=aSyFile{$i}) & ($doLoop))
		If (aSyMatWas{$i}=$2)
			$0:=$i
			$doLoop:=False:C215
		Else 
			If ($i<$k)
				$i:=$i+1
			Else 
				$doLoop:=False:C215
			End if 
		End if 
	End while 
End if 