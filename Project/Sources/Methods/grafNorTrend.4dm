//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $r; $1)
C_REAL:C285($e)
ARRAY REAL:C219(aSaleNplan; $1)
ARRAY REAL:C219(aSaleNact; $1)
ARRAY REAL:C219(aQtyNplan; $1)
ARRAY REAL:C219(aQtyNact; $1)
ARRAY REAL:C219(aInvNplan; $1)
ARRAY REAL:C219(aInvNact; $1)
ARRAY REAL:C219(aScpNplan; $1)
ARRAY REAL:C219(aScpNact; $1)
ARRAY REAL:C219(aCapN; $1)
For ($i; 1; Size of array:C274(aInvenAct))
	$r:=10
	aInvNplan{$i}:=vItemSpace*4
	If (aInvenPlan{$i}#0)
		$e:=vItemScale*((aInvenAct{$i}/aInvenPlan{$i})+(vItemSpace*4))
	Else 
		$e:=0
	End if 
	aInvNact{$i}:=$e*Num:C11($e<$r)
	
	aScpNplan{$i}:=vItemSpace*3
	If (aScrpPlan{$i}#0)
		$e:=vItemScale*((aScrpAct{$i}/aScrpPlan{$i})+(vItemSpace*3))
	Else 
		$e:=0
	End if 
	aScpNact{$i}:=$e*Num:C11($e<$r)
	
	aSaleNplan{$i}:=vItemSpace*2
	If (aSalesPlan{$i}#0)
		$e:=vItemScale*((aSalesAct{$i}/aSalesPlan{$i})+(vItemSpace*2))
	Else 
		$e:=0
	End if 
	aSaleNact{$i}:=$e*Num:C11($e<$r)
	
	aQtyNplan{$i}:=vItemSpace*1
	If (aQtyPlan{$i}#0)
		$e:=vItemScale*((aQtyAct{$i}/aQtyPlan{$i})+(vItemSpace*1))
	Else 
		$e:=0
	End if 
	aQtyNact{$i}:=$e*Num:C11($e<$r)
	
	
	If (aQtyPlan{$i}#0)
		$e:=vItemScale*((aCapacity{$i}/aQtyPlan{$i})+(vItemSpace*1))
	Else 
		$e:=0
	End if 
	aCapN{$i}:=$e*Num:C11($e<$r)
End for 