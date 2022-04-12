//%attributes = {}



// 4D_25Invoice - 2022-01-15
  //Filters property names containing annoying chars

$name:=$1

  //While a Property name can theoritically contain every possible characters, some of them may be a cause of problems...

$badChars:=".[]{}/,:"+Char:C90(160)/*&NBSP*/+Char:C90(Double quote:K15:41)+Char:C90(92)/*Backslash*/  //This list can be adapted to your own needs

$result:=""

For ($i;1;Length:C16($name))
	If (Position:C15($name[[$i]];$badChars)<1)
		$result:=$result+$name[[$i]]
	End if 
End for 

$0:=$result