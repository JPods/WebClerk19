//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k; $thisType)
C_POINTER:C301($ptField; $1)
$thisType:=0
$1->:=0
$k:=Size of array:C274($1->)
For ($i; 1; $k)
	If (($1->{$i}#"") & ((aSyncChoose{$i}="^") | (aSyncChoose{$i}="<")))
		$ptField:=Field:C253(Table:C252(aSyncFilePt{aSyncCnt}); $i)
		$thisType:=Type:C295($ptField->)
		Case of 
			: (($thisType=0) | ($thisType=2))
				$ptField->:=$1->{$i}
			: (($thisType=1) | ($thisType=8) | ($thisType=9))
				$ptField->:=Num:C11($1->{$i})
			: ($thisType=4)
				$ptField->:=Date:C102($1->{$i})
			: ($thisType=11)
				$ptField->:=Time:C179($1->{$i})
		End case 
	End if 
End for 