C_LONGINT:C283(bExecute; $i)
C_TEXT:C284($format)
KeyModifierCurrent
$format:="###,###,###.00"
CONFIRM:C162("This will take time.")
If (OK=1)
	If (b1=1)
		Rpt_SaleFillRay(->a20Str1; ->vDate1; ->vDate2)
		Rpt_SaleFillRay(->a20Str2; ->vDate3; ->vDate4)
		a20Str3{1}:="Diff"
		a20Str4{1}:="% Change"
		For ($i; 2; Size of array:C274(a20Str1))
			a20Str3{$i}:=String:C10((Num:C11(a20Str2{$i})-Num:C11(a20Str1{$i}))*1; $format)
			If (Num:C11(a20Str2{$i})#0)
				a20Str4{$i}:=String:C10(Num:C11(a20Str3{$i})/Num:C11(a20Str2{$i})*100; $format)
			Else 
				a20Str4{$i}:=String:C10(0; $format)
			End if 
		End for 
		doSearch:=6
		//If (Optkey=1)
		//<>vlCalc:=Open external window(4;40;636;440;8;"";"_4D Calc")//to
		// know if the module is here 
		//SP UPDATE MODE (<>vlCalc;0)
		//SP ARRAY TO CELLS (<>vlCalc;1;SP Cell (1;1);aCustSales;Size of array
		//(aCustSales))
		//SP ARRAY TO CELLS (<>vlCalc;1;SP Cell (2;1);a20Str1;Size of array
		//(a20Str1))
		////area; row/col; startCell; Array; NumElems; Method
		////sp Cell(col; row)
		//SP ARRAY TO CELLS (<>vlCalc;1;SP Cell (3;1);a20Str2;Size of array
		//(a20Str2))
		//SP ARRAY TO CELLS (<>vlCalc;1;SP Cell (4;1);a20Str3;Size of array
		//(a20Str3))
		//SP ARRAY TO CELLS (<>vlCalc;1;SP Cell (5;1);a20Str4;Size of array
		//(a20Str4))
		//SP UPDATE MODE (<>vlCalc;1)
		//End if 
	Else 
		BEEP:C151
		BEEP:C151
	End if 
End if 