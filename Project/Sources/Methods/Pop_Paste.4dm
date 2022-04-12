//%attributes = {"publishedWeb":true}
//Procedure: Pop_Paste
C_LONGINT:C283($1)
//
//
TRACE:C157
C_LONGINT:C283(eMakeList)
If (Count parameters:C259=0)
	$loadChoices:=1
Else 
	$loadChoices:=$1
End if 
C_TEXT:C284($lineEnd)
C_LONGINT:C283($lineEndLen; $i; $k)
If ($loadChoices=0)
	vText1:=""
	If (Is macOS:C1572)
		$lineEnd:="\r"
	Else 
		$lineEnd:="\r"+Char:C90(10)
	End if 
	$k:=Size of array:C274(a1Text)
	For ($i; 1; $k)
		vText1:=vText1+a1Text{$i}+"_Alt"+aText2{$i}+$lineEnd
	End for 
	SET TEXT TO PASTEBOARD:C523(vText1)
Else 
	If ($loadChoices=1)
		vText1:=Get text from pasteboard:C524
	End if 
	If (vText1="")
		//BEEP
		//BEEP
	Else 
		If ((vHere>1) & ($loadChoices<5))  //5 added to avoid warnings
			CONFIRM:C162("Paste list from clipboard")
		Else 
			OK:=1
		End if 
		If (OK=1)
			//TRACE
			$p:=Position:C15("\r"; vText1)
			If (vText1[[$p+1]]=Char:C90(10))
				$lineEnd:="\r"+Char:C90(10)
				$lineEndLen:=2
			Else 
				$lineEnd:="\r"
				$lineEndLen:=1
			End if 
			C_TEXT:C284($theChoice; $theAlt)
			If (vText1#"")
				$p:=Position:C15($lineEnd; vText1)
				Repeat 
					$doRelatedRec:=True:C214
					Case of 
						: (($p>0) & (Length:C16(vText1)>1))
							$myWorkStr:=Substring:C12(vText1; 1; $p-1)
							vText1:=Substring:C12(vText1; $p+$lineEndLen)
						: (Length:C16(vText1)>1)
							$myWorkStr:=vText1
						Else 
							$doRelatedRec:=False:C215
							$myWorkStr:=""
							vText1:=Substring:C12(vText1; 2)
					End case 
					If ($doRelatedRec)
						CREATE RECORD:C68([PopupChoice:134])
						//notation for a passed parameter, refered by number
						[PopupChoice:134]arrayName:1:=[PopUp:23]arrayName:3
						
						$p:=Position:C15("_Alt"; $myWorkStr)
						If ($p>0)
							$theChoice:=Substring:C12($myWorkStr; 1; $p-1)
							$theAlt:=Substring:C12($myWorkStr; $p+4)
						Else 
							$theChoice:=$myWorkStr
							$theAlt:=""
						End if 
						[PopupChoice:134]choice:3:=$theChoice
						[PopupChoice:134]alternate:4:=$theAlt
						SAVE RECORD:C53([PopupChoice:134])
						
					End if 
					$p:=Position:C15($lineEnd; vText1)
				Until ($p=0)
				vText1:=""
				If ((eMakeList#0) & (ptCurTable=(->[PopUp:23])))
					
					PopupLoadArrays(->a1Text; a2Text)
					
					//  --  CHOPPED  AL_UpdateArrays(eMakeList; -2)
				End if 
			End if 
		End if 
	End if 
End if 