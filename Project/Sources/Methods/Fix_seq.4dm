//%attributes = {}
var obRec; obSel : Object
var viTaskID : Integer
var inc : Integer
obSel:=ds:C1482.QA.query("idNumTask > 0").orderBy("idNumTask")
viTaskID:=obSel.first().idNumTask
inc:=0
For each (obRec; obSel)
	If (viTaskID=obRec.idNumTask)
		inc:=inc+1
	Else 
		viTaskID:=obRec.idNumTask
		inc:=1
	End if 
	obRec.seq:=inc
	obRec.save()
End for each 