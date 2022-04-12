//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/20/19, 09:14:29
// ----------------------------------------------------
// Method: RecordsInByFolder
// Description
// 
//
// Parameters
// ----------------------------------------------------


// get the path to the folder
vtext11:=Select folder:C670("Select folder")
C_LONGINT:C283(vi11)
// not required except if the path is passed in as a parameter, left for example
vi11:=Test path name:C476(vtext11)
If (vi11=0)  //a folder was found
	ARRAY TEXT:C222(aText1; 0)
	ARRAY TEXT:C222(aText2; 0)
	DOCUMENT LIST:C474(vtext11; aText1)  // get list of documents
	// FOLDER LIST(vtext11;aText2)  // get list of subfolders
	// set the folder path so files can be added to it
	If (vtext11[[Length:C16(vtext11)]]#Folder separator:K24:12)
		vtext11:=vtext11+Folder separator:K24:12
	End if 
	C_LONGINT:C283(vi1; vi2)
	vi2:=Size of array:C274(aText1)
	For (vi1; 1; vi2)
		curTableNum:=Num:C11(Substring:C12(aText1{vi1}; 1; 3))
		If (curTableNum>1)
			READ WRITE:C146(Table:C252(curTableNum)->)
			vText12:=vtext11+aText1{vi1}
			Records_In(Table:C252(curTableNum); ->vText12)
		End if 
	End for 
End if 