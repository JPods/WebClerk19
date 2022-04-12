//%attributes = {"publishedWeb":true}
[Lead:48]Profile1:14:=v1
[Lead:48]Profile2:15:=v2
[Lead:48]Profile3:16:=v3
[Lead:48]Profile4:17:=v4
[Lead:48]Profile5:18:=v5
If ([Lead:48]DateEntered:21=!00-00-00!)
	[Lead:48]DateEntered:21:=Current date:C33
End if 
SAVE RECORD:C53([Lead:48])
CANCEL:C270