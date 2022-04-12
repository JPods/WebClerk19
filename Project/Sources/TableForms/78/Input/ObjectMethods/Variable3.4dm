C_TIME:C306($vtDoc)

$path:=<>JITF+"jitCert"+<>VFOLDERDELIMITER


$vtDoc:=Open document:C264(""; "*"; 3)
If (OK=1)
	[WebClerk:78]PathToKey:22:=document
	CLOSE DOCUMENT:C267($vtDoc)
End if 
