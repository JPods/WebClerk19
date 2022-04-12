// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-14T00:00:00, 20:03:18
// ----------------------------------------------------
// Method: [Control].DocumentManagement.Variable3540
// Description
// Modified: 11/14/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


CONFIRM:C162("Set folder as prefix to documents in folder?")
If (OK=1)
	KeyModifierCurrent
	If (OptKey=1)
		UtilFilePrefix
	Else 
		If (Length:C16(iLoText1)>=0)  // Modified by: williamjames (111216 checked for <= length protection)
			If (iLoText1[[Length:C16(iLoText1)]]#Folder separator:K24:12)
				iLoText1:=iLoText1+Folder separator:K24:12
			End if 
			UtilFilePrefix(iLoText1)
		End if 
	End if 
End if 