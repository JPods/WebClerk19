TRACE:C157
If (<>CustAcct#srAcct)
	If (<>ptCurTable=(->[Customer:2]))
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=<>CustAcct)
		QUERY:C277([QA:70]; [QA:70]customerID:1=[Customer:2]customerID:1; *)
		QUERY:C277([QA:70];  & [QA:70]tableNum:11=2)
		v1:=[Customer:2]company:2
		v2:=[Customer:2]nameFirst:73
		v3:=[Customer:2]nameLast:23
		srAcct:=[Customer:2]customerID:1
		ptFile:=(->[Customer:2])
		
	End if 
	//  CHOPPED QA_FillAnswRay(Records in selection([QA]))
	//  --  CHOPPED  AL_UpdateArrays(eAList; -2)
	C_LONGINT:C283($i; $k; $w)
	For ($i; 1; $k)
		If (aQaGroup{$i}>vilo1)
			vilo1:=aQaGroup{$i}
		End if 
	End for 
	vilo1:=vilo1+1
End if 