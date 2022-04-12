//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/11/18, 10:46:45
// ----------------------------------------------------
// Method: DemoLoadFolderMovies
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(vText8; vText9)
C_LONGINT:C283(vi1; vi2)

vText8:=Select folder:C670("")
If (OK=1)
	vText9:=""
	ARRAY TEXT:C222(aText1; 0)
	DOCUMENT LIST:C474(vText8; aText1)
	SORT ARRAY:C229(aText1)
	vi2:=Size of array:C274(aText1)
	For (vi1; 1; vi2)
		If (Position:C15(".mp4"; aText1{vi1})>0)
			vText9:=vText9+"\r"+"<li><a href=\"movies/"+aText1{vi1}+"\" target=\"Main_Frame\">"+aText1{vi1}+"</a></li>"
		End if 
	End for 
	ConsoleMessage(vText9)
	SET TEXT TO PASTEBOARD:C523(vText9)
	
End if 