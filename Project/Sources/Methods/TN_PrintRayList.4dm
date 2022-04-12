//%attributes = {"publishedWeb":true}
//Procedure: TN_PrintRayList
C_LONGINT:C283($1)
C_BOOLEAN:C305($doRepeat; $doPict)
$doRepeat:=($1=1)
If (Size of array:C274(aTNRecSel)>0)
	C_LONGINT:C283($i; $k; $thePrint)
	$k:=Size of array:C274(aTNRecSel)
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
	For ($i; 1; $k)
		GOTO RECORD:C242([TechNote:58]; aTNRec{aTNRecSel{$i}})
		// $thePrint:=//**WR O Picture to offscreen are ([TechNote]Body_)
		//**WR PICTURE TO AREA ($thePrint;[TechNote]Body_)
		If ($doPict)
			//**WR SET SELECTION ($thePrint;0;0)
			//$err:=  //**WR Insert picture area ($thePrint;$tempPict;0)
		End if 
		Case of 
			: ($doRepeat)
				//**WR EXECUTE COMMAND ($thePrint;110)
				//**WR EXECUTE COMMAND ($thePrint;111)
			: ($i=1)
				//**WR EXECUTE COMMAND ($thePrint;111)
			Else 
				//**WR PRINT ($thePrint;0)
		End case 
		//**WR DELETE OFFSCREEN AREA ($thePrint)
	End for 
Else 
	jAlertMessage(9209)
End if   //