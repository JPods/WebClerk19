//%attributes = {"publishedWeb":true}
//Procedure: PackUnText  October 7, 1993
C_LONGINT:C283($i; $k; $p; $e; $f; $3; $asciiChar)
C_POINTER:C301($1; $2; $4; $5; ptField)
C_TEXT:C284(vText1; $vText2)

//  REPLACE WITH JSON

$f:=Get last field number:C255($2)
$vText1:=""
$i:=1
While ((Character code:C91($1->[[$i]])#0) & (Character code:C91($1->[[$i]])#$3))
	$vText2:=$vText2+$1->[[$i]]
	$i:=$i+1
End while 
If (Character code:C91($1->[[$i]])=$3)
	$i:=$i+1  //skip the delimiter character
	$k:=Num:C11(Substring:C12($1->; $i; 5))
	//Num($1$i+$1$i+1+$1$i+2+$1$i+3+$1$i+4)
	$i:=$i+5  //skip the number leave the CR to be skipped as other delimiters
	For ($e; 1; $k)
		CREATE RECORD:C68($2->)
		For ($p; 1; $f)
			$vText1:=""
			Repeat 
				$i:=$i+1  //already skipped the delimiter
				$asciiChar:=Character code:C91($1->[[$i]])
				If (($asciiChar>31) & ($asciiChar#$3))
					$vText1:=$vText1+$1->[[$i]]
				End if 
			Until ((Character code:C91($1->[[$i]])=0) | (Character code:C91($1->[[$i]])=$3))
			ptField:=Field:C253(Table:C252($2); $p)
			PackMakeTyped(ptField; $vText1)
		End for 
		If (Count parameters:C259=5)
			Case of 
				: (Table:C252($1)=48)
					// $5->:=CounterNew (Table(Table($5))->)
					// automatic
					$4->:=String:C10($5->)
				: ($2=(->[Payment:28]))
					
					Ledger_PaySave
				Else 
					$4->:=$5->
			End case 
		End if 
		SAVE RECORD:C53($2->)
	End for 
	FLUSH CACHE:C297
End if 
$1->:=$vText2