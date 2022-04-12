//%attributes = {"publishedWeb":true}
//Procedure: TN_PrintOne
C_PICTURE:C286($tempPict)
C_BOOLEAN:C305($doPict)
C_LONGINT:C283($thePrint; $p)
TRACE:C157
//$thePrint:=  //**WR New offscreen area 
//**WR PICTURE TO AREA ($thePrint;[TechNote]Body_)
Case of 
	: ([TechNote:58]Purpose:16="jitManual")
		GET PICTURE RESOURCE:C502(22118; $tempPict)
		$doPict:=True:C214
	: ([TechNote:58]Purpose:16="221@")
		$p:=Position:C15(";"; [TechNote:58]Purpose:16)
		If ($p>0)
			$p:=Num:C11(Substring:C12([TechNote:58]Purpose:16; 1; $p-1))
			If (($p>22448) & ($p<22600))
				GET PICTURE RESOURCE:C502($p; $tempPict)
				$doPict:=True:C214
			End if 
		End if 
End case 
//**WR SET SELECTION ($thePrint;0;0)
If ($doPict)
	//$err:=  //**WR Insert picture area ($thePrint;$tempPict;0)
End if 
////**WR Execute COMMAND ($thePrint;110)
////**WR Execute COMMAND ($thePrint;111)
//**WR SET DOC PROPERTY ($thePrint;//**WR paper height;11)
//**WR SET DOC PROPERTY ($thePrint;//**WR paper width;8.5)
//**WR EXECUTE COMMAND ($thePrint;//**WR cmd compute references)
//**WR EXECUTE COMMAND ($thePrint;//**WR cmd page setup)
//**WR EXECUTE COMMAND ($thePrint;//**WR cmd print preview)


//**WR PRINT ($thePrint;0;1)

//**WR DELETE OFFSCREEN AREA ($thePrint)