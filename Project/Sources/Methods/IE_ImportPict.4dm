//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:36:38
// ----------------------------------------------------
// Method: IE_ImportPict
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Import"))
	
	ARRAY TEXT:C222(aText1; 0)
	C_LONGINT:C283($err; $i; $k; $len; $incItm; $cntItm)
	C_PICTURE:C286($thePict)
	C_TEXT:C284($origName; $tempFold)
	KeyModifierCurrent
	$len:=Num:C11(Request:C163("Enter Length to test unfound items to"; "4"))
	If ((OK=1) & ($len>0))
		$tempFold:=""
		$tempFold:=Get_FolderName("Select picture folder.")
		If ($tempFold#"")
			$err:=HFS_CatToArray($tempFold; "aText1")
			$k:=Size of array:C274(aText1)
			If (CmdKey=1)
				If (OptKey=1)
					QUERY:C277([ItemSpec:31])
				End if 
				$fileCnt:=Records in selection:C76([ItemSpec:31])
				FIRST RECORD:C50([ItemSpec:31])
				$i:=1
				While ((Record number:C243([ItemSpec:31])>-1) & ($i<=$k))
					$err:=HFS_Rename($tempFold+aText1{$i}; [ItemSpec:31]itemNum:1)
					NEXT RECORD:C51([ItemSpec:31])
					$i:=$i+1
				End while 
				$err:=HFS_CatToArray($tempFold; "aText1")  //$origName
			End if 
			For ($i; 1; $k)
				If (aText1{$i}[[Length:C16(aText1{$i})]]#Folder separator:K24:12)
					$origName:=aText1{$i}
					$p:=Position:C15("."; aText1{$i})
					If ($p>0)
						aText1{$i}:=Substring:C12(aText1{$i}; 1; $p-1)
					End if 
					$doSpec:=False:C215
					QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=aText1{$i})
					If (Records in selection:C76([ItemSpec:31])=1)
						$doSpec:=True:C214
					Else 
						QUERY:C277([Item:4]; [Item:4]itemNum:1=aText1{$i}+"@")
						If (Records in selection:C76([Item:4])=0)
							$theItemSpec:=Substring:C12(aText1{$i}; 1; $len)
							QUERY:C277([Item:4]; [Item:4]itemNum:1=$theItemSpec+"@")
						Else 
							$theItemSpec:=aText1{$i}
						End if 
						If (Records in selection:C76([Item:4])>0)
							$cntItm:=Records in selection:C76([Item:4])
							FIRST RECORD:C50([Item:4])
							For ($incItm; 1; $cntItm)
								If ([Item:4]specid:62="")
									[Item:4]specid:62:=aText1{$i}
									[Item:4]specification:42:=True:C214
									SAVE RECORD:C53([Item:4])
								End if 
								NEXT RECORD:C51([Item:4])
							End for 
							QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=$theItemSpec)
							If (Records in selection:C76([ItemSpec:31])=0)
								CREATE RECORD:C68([ItemSpec:31])
								
							End if 
							[ItemSpec:31]itemNum:1:=$theItemSpec
							$doSpec:=True:C214
						End if 
					End if 
					If ($doSpec)
						IE_GetPict($tempFold+$origName)
						SAVE RECORD:C53([ItemSpec:31])
					Else 
						BEEP:C151
					End if 
				End if 
			End for 
		End if 
	End if 
	UNLOAD RECORD:C212([Item:4])
	UNLOAD RECORD:C212([ItemSpec:31])
End if 