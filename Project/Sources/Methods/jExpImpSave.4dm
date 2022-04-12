//%attributes = {"publishedWeb":true}
//(P)   jExpImpSave
C_TEXT:C284($1; $2)
//
C_LONGINT:C283($i; $k)
C_TEXT:C284($myName)
C_LONGINT:C283($myOK)
C_TEXT:C284($impPatt; $impOpts)
C_TEXT:C284($cr; $tab)
$cr:=Char:C90(13)
$tab:=Char:C90(9)
KeyModifierCurrent
If (CmdKey=1)
	CONFIRM:C162("Delete Import Pattern")
	If (OK=1)
		GOTO RECORD:C242([TallyMaster:60]; theFldNum{aFieldLns{1}})
		DELETE RECORD:C58([TallyMaster:60])
	End if 
Else 
	If (Size of array:C274(aMatchField)>0)
		$k:=Size of array:C274(aMatchField)
		$myName:=Request:C163("Enter Unique Name")
		If ((OK=1) & ($myName#""))
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]tableNum:1=curTableNum; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="ImportExport"; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=$myName)
			Case of 
				: (Records in selection:C76([TallyMaster:60])>1)
					ALERT:C41("Multiple records of type and name.")
				: (Records in selection:C76([TallyMaster:60])=1)
					CONFIRM:C162("Update import/export pattern: "+$myName)
					$myOK:=OK
				Else 
					$myOK:=1
					CREATE RECORD:C68([TallyMaster:60])
					
			End case 
			If ($myOK=1)
				[TallyMaster:60]tableNum:1:=curTableNum
				[TallyMaster:60]purpose:3:="ImportExport"
				[TallyMaster:60]name:8:=$myName
				$impOpts:=String:C10(Character code:C91("\t"))+$cr
				If (Length:C16("\r")=1)
					$impOpts:=$impOpts+String:C10(Character code:C91("\r"))+$cr
				Else 
					$impOpts:=$impOpts+"-1"+$cr
				End if 
				$impPatt:=$impOpts+vFldSepBeg+$cr+vFldSepEnd+$cr
				$impPatt:=$impPatt+$1+$tab+String:C10(curTableNum)+$tab+String:C10($k)+$tab
				For ($i; 1; $k)
					$impPatt:=$impPatt+String:C10(aMatchNum{$i})+$tab
				End for 
				[TallyMaster:60]script:9:=$impPatt
				$impPatt:=$impOpts
				$impPatt:=$impPatt+$1+$cr+<>aTableNames{<>aTableNames}+", "+String:C10($k)+$cr
				For ($i; 1; $k)
					$impPatt:=$impPatt+aMatchField{$i}+", "
				End for 
				[TallyMaster:60]build:6:=$impPatt
				C_OBJECT:C1216($objTemplate)
				C_OBJECT:C1216($objLocal)
				C_OBJECT:C1216($objForeign)
				C_OBJECT:C1216($objHead)
				$objHead:=JSON Parse:C1218("{}")
				OB SET:C1220($objHead; "Purpose"; "ImportExportPattern")
				OB SET:C1220($objHead; "Date"; Current date:C33)
				OB SET:C1220($objHead; "Who"; Current user:C182)
				OB SET:C1220($objHead; "TableName"; <>aTableNames{<>aTableNames})
				OB SET:C1220($objHead; "Version"; Storage:C1525.version.title)
				OB SET:C1220($objHead; "TMUniqueID"; String:C10([TallyMaster:60]idNum:4))
				OB SET:C1220($objHead; "UUID"; [TallyMaster:60]id:38)
				OB SET:C1220($objHead; "QueryBy"; vSearchBy)
				OB SET:C1220($objHead; "Script"; vtallyMastersName)
				
				C_OBJECT:C1216($objLocal)
				$objLocal:=JSON Parse:C1218("{}")
				For ($i; 1; $k)
					OB SET:C1220($objLocal; String:C10($i); aMatchField{$i})
				End for 
				
				C_OBJECT:C1216($objForeign)
				$objForeign:=JSON Parse:C1218("{}")
				$k:=Size of array:C274(aImpFields)
				For ($i; 1; $k)
					OB SET:C1220($objForeign; String:C10($i); aImpFields{$i})
				End for 
				
				C_OBJECT:C1216($objTemplate)
				$objTemplate:=JSON Parse:C1218("{}")
				OB SET:C1220($objTemplate; "head"; $objHead)
				OB SET:C1220($objTemplate; "local"; $objLocal)
				OB SET:C1220($objTemplate; "foreign"; $objForeign)
				[TallyMaster:60]template:29:=JSON Stringify:C1217($objTemplate)
				
				If (False:C215)  // manual
					$impPatt:="{"+Txt_Quoted("Inbound")+":{"+Txt_Quoted("TableName")+":"+Txt_Quoted(<>aTableNames{<>aTableNames})+","
					For ($i; 1; $k)
						$impPatt:=$impPatt+Txt_Quoted(String:C10($i))+":"+Txt_Quoted(aMatchField{$i})
						If ($i<$k)
							$impPatt:=$impPatt+","
						End if 
					End for 
					$impPatt:=$impPatt+"}"
					$k:=Size of array:C274(aImpFields)
					If ($k=0)
						$impPatt:=$impPatt+"}"  // close the json
					Else 
						// add the foreign pair
						$impPatt:=$impPatt+","+Txt_Quoted("foreign")+":{"+Txt_Quoted("File")+":"+Txt_Quoted(vDiaCom)+","
						For ($i; 1; $k)
							$impPatt:=$impPatt+Txt_Quoted(String:C10($i))+":"+Txt_Quoted(aImpFields{$i})
							If ($i<$k)
								$impPatt:=$impPatt+","
							End if 
						End for 
						$impPatt:=$impPatt+"}}"
					End if 
					[TallyMaster:60]template:29:=$impPatt
				End if 
				
				
				
				SAVE RECORD:C53([TallyMaster:60])
			End if 
		End if 
		REDUCE SELECTION:C351([TallyMaster:60]; 0)
	Else 
		ALERT:C41("The Matching Fields must be defined.")
	End if 
End if 