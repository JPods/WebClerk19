//%attributes = {"publishedWeb":true}
//Procedure: TN_Print
C_PICTURE:C286($tempPict)
C_LONGINT:C283($err)
KeyModifierCurrent
TRACE:C157
If ((CmdKey=1) & (OptKey=1))
	//$tempPict:=  //**WR O Save to picture (wrWind)
	
Else 
	If ([TechNote:58]purpose:16="jitManual")
		GET PICTURE RESOURCE:C502(22118; $tempPict)
		//**WR SET SELECTION (eTechNote;0;0)
		//$err:=  //**WR Insert picture area (eTechNote;$tempPict;0)
	Else 
		$myDocName:=Storage:C1525.folder.jitLtrF+HFS_ShortName([TechNote:58]purpose:16)
		$fileExist:=HFS_Exists($myDocName)
		If ($fileExist=1)
			//$tempPict:=  //**WR Area to picture (wrWind)
			//**WR SET SELECTION (eTechNote;0;0)
			//$err:=  //**WR Insert picture area (eTechNote;$tempPict;0)
		End if 
	End if 
End if 
