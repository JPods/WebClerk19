//%attributes = {"publishedWeb":true}

If (<>WriteHere)
	C_LONGINT:C283($1)
	C_POINTER:C301($2)
	C_TEXT:C284($3)
	C_LONGINT:C283($offArea; $error)
	C_PICTURE:C286($offPict)
	Case of 
		: (HFS_Exists(Storage:C1525.folder.jitLtrF+$3+String:C10(Table:C252($2)))=1)
			//$offArea:=  //**WR New offscreen area 
			//**WR OPEN DOCUMENT ($offArea;Storage.folder.jitLtrF+$3+String(Table($2)))
			//$offPict:=  //**WR Area to picture ($offArea)
			//**WR PICTURE TO AREA ($1;$offPict)
			//**WR DELETE OFFSCREEN AREA ($offArea)
		: (HFS_Exists(Storage:C1525.folder.jitLtrF+$3)=1)
			//$offArea:=  //**WR New offscreen area 
			//**WR OPEN DOCUMENT ($offArea;Storage.folder.jitLtrF+$3)
			//$offPict:=  //**WR Area to picture ($offArea)
			//**WR PICTURE TO AREA ($1;$offPict)
			//**WR DELETE OFFSCREEN AREA ($offArea)
	End case 
	
Else 
	jAlertMessage(19001)
End if 