//%attributes = {"publishedWeb":true}
//(P)jExpImpLoad 

C_LONGINT:C283($c; $k; $knt; $o; $w; $x; $y; $i)
C_BOOLEAN:C305($z; $ImpPat)
C_TEXT:C284($Names; $1; $2)
C_POINTER:C301(ptFile)
C_TEXT:C284($theDocument; $3)

C_TEXT:C284($impPatt)
C_LONGINT:C283($myOK; $p; $value)
C_TEXT:C284($cr; $tab)
$cr:=Char:C90(13)
$tab:=Char:C90(9)
KeyModifierCurrent
If (OptKey=1)
	If (Count parameters:C259=3)
		$theDocument:=$3
	Else 
		$theDocument:=""
	End if 
	If ($1="Import Pattern")
		$ImpPat:=True:C214
	End if 
	sumDoc:=Open document:C264($theDocument; $2)
	If (OK=1)
		<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
		RECEIVE PACKET:C104(sumDoc; $impPatt; <>vEoF)  //discard
		CLOSE DOCUMENT:C267(sumDoc)
		$myOK:=1
	End if 
Else 
	Case of 
		: (Records in selection:C76([TallyMaster:60])>1)
			ALERT:C41("Multiple records of type and name.")
		: (Records in selection:C76([TallyMaster:60])=1)
			$impPatt:=[TallyMaster:60]script:9
			
			$myOK:=OK
		Else 
			$myOK:=0
			ALERT:C41("No record of type and name.")
	End case 
End if 
If ($myOK=1)
	$p:=Position:C15("Pattern"; $impPatt)
	If ($p>0)
		$impOpts:=Substring:C12($impPatt; 1; $p-1)
		$impPatt:=Substring:C12($impPatt; $p+1)  //strip impOpts
		If (($impOpts="imp@") | ($impOpts="exp@"))
			vFldSepBeg:=""
			vFldSepEnd:=""
		Else 
			$p:=Position:C15($cr; $impOpts)
			$value:=Num:C11(Substring:C12($impOpts; 1; $p-1))
			
			$impOpts:=Substring:C12($impOpts; $p+1)  //strip field delim
			$p:=Position:C15($cr; $impOpts)
			$value:=Num:C11(Substring:C12($impOpts; 1; $p-1))
			$impOpts:=Substring:C12($impOpts; $p+1)  //strip field delim
			$p:=Position:C15($cr; $impOpts)
			vFldSepBeg:=Substring:C12($impOpts; 1; $p-1)
			$impOpts:=Substring:C12($impOpts; $p+1)  //strip field delim
			$p:=Position:C15($cr; $impOpts)
			vFldSepEnd:=Substring:C12($impOpts; 1; $p-1)  //ignore the rest
			//
			$p:=Position:C15($tab; $impPatt)
			$impPatt:=Substring:C12($impPatt; $p+1)  //strip 'pattern'
			$p:=Position:C15($tab; $impPatt)
			curTableNum:=Num:C11(Substring:C12($impPatt; 1; $p-1))
			<>aTableNames:=Find in array:C230(<>aTableNums; curTableNum)
			curTableNumAlt:=curTableNum
			StructureFields(curTableNum)
			ptFile:=Table:C252(curTableNum)
			viRecordsInTable:=Records in table:C83(ptFile->)
			viRecordsInSelection:=Records in selection:C76(ptFile->)
			DEFAULT TABLE:C46(ptFile->)
			//
			
			If ([TallyMaster:60]template:29#"")
				
				MatchObjectLoad
				
				
				
			Else 
				$impPatt:=Substring:C12($impPatt; $p+1)
				$p:=Position:C15($tab; $impPatt)
				$knt:=Num:C11(Substring:C12($impPatt; 1; $p-1))  //number of elements
				$impPatt:=Substring:C12($impPatt; $p+1)
				ARRAY TEXT:C222(aMatchField; 0)
				ARRAY TEXT:C222(aMatchType; 0)
				ARRAY LONGINT:C221(aMatchNum; 0)
				Repeat 
					$p:=Position:C15($tab; $impPatt)
					If ($p>0)
						$fldNum:=Num:C11(Substring:C12($impPatt; 1; $p-1))  //number of elements
						$impPatt:=Substring:C12($impPatt; $p+1)
						$k:=Size of array:C274(aMatchNum)+1
						INSERT IN ARRAY:C227(aMatchField; $k; 1)
						INSERT IN ARRAY:C227(aMatchType; $k; 1)
						INSERT IN ARRAY:C227(aMatchNum; $k; 1)
						$c:=Find in array:C230(theFldNum; $fldNum)
						If ($c>0)
							aMatchField{$k}:=theFields{$c}
							aMatchType{$k}:=theTypes{$c}
							aMatchNum{$k}:=$c
						Else 
							aMatchField{$k}:="NOT IMPORTED"
							aMatchType{$k}:="z"
							aMatchNum{$k}:=-2
						End if 
					End if 
				Until ($p=0)
				ARRAY LONGINT:C221(aCntMatFlds; $k)
				For ($o; 1; $k)
					aCntMatFlds{$o}:=$o
				End for 
				$w:=Find in array:C230(theUniques; "u")
				If ($w>0)
					GET FIELD PROPERTIES:C258(curTableNum; $w; $x; $y; $z)  // get the field attributes
					vSearchBy:=Field name:C257(curTableNum; $w)
				Else 
					vSearchBy:=""
				End if 
			End if 
		End if 
	End if 
End if 
UNLOAD RECORD:C212([TallyMaster:60])