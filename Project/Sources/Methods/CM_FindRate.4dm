//%attributes = {"publishedWeb":true}
C_REAL:C285($0)
C_LONGINT:C283($w)
C_POINTER:C301($1; $2; $3)  //[Order]SalesCommission;aComNameID;aEmpRate
$0:=0
If ($1->#"")  //[Order]Rep;aReps;aRepRate  
	$w:=Find in array:C230($2->; $1->)
	If ($w>0)
		$0:=$3->{$w}
	Else 
		If ($2=(-><>aReps))
			C_OBJECT:C1216($obRep)
			$obRep:=ds:C1482.Rep.query("repID = :1"; $1->).first()
			If ($obRep=Null:C1517)
				$0:=0
			Else 
				$0:=$obRep.comRate
			End if 
		Else 
			C_OBJECT:C1216($obEmployee)
			$obEmployee:=ds:C1482.Employee.query("nameID = :1"; $1->).first()
			If ($obEmployee=Null:C1517)
				$0:=0
			Else 
				$0:=$obEmployee.comRate
			End if 
		End if 
	End if 
End if 