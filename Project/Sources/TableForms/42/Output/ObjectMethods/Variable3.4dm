C_LONGINT:C283(bSum)
C_LONGINT:C283($i; $k)
C_REAL:C285($likely; $total)
$total:=0
$likely:=0
FIRST RECORD:C50([Proposal:42])
For ($i; 1; Records in selection:C76([Proposal:42]))
	$total:=$total+[Proposal:42]amount:26
	$likely:=$likely+([Proposal:42]probability:43*0.01*[Proposal:42]amount:26)
	NEXT RECORD:C51([Proposal:42])
End for 
vr1:=$total
vr2:=Round:C94($likely; 2)