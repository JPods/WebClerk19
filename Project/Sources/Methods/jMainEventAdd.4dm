//%attributes = {"publishedWeb":true}
//(P) jMainEventAdd
StopAddLoop:=False:C215
If (vHere=0)
	CREATE EMPTY SET:C140(ptCurTable->; "Empty")
	USE SET:C118("Empty")
	CLEAR SET:C117("Empty")
End if 
Repeat 
	srVarLoad(0)
	ADD RECORD:C56(ptCurTable->)
	If (mySpecCan)
		TRACE:C157
		mySpecCan:=False:C215
		CANCEL:C270
		jNavResetSplash
	End if 
Until (StopAddLoop)