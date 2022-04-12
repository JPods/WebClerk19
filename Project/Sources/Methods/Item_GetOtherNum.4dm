//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
//
C_POINTER:C301($ptTable)
C_TEXT:C284($theAcct)
C_LONGINT:C283($byArray)

$byArray:=1
$theAcct:=""
C_LONGINT:C283($i; $k)
If (Count parameters:C259=0)
	$ptTable:=(->[DefaultQQQ:15])
	If (Count parameters:C259>0)
		$ptTable:=$1
		If (Count parameters:C259>1)
			$theAcct:=$2
			If (Count parameters:C259>2)
				$byArray:=$3
			End if 
		End if 
	End if 
End if 
Case of 
	: (($ptTable=(->[DefaultQQQ:15])) | ($theAcct=""))
		//    no action
	: ($1=(->[Order:3]))
		If ($byArray=1)
			$k:=Size of array:C274(aOAltItem)
			For ($i; 1; $k)
				QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumMaster:1=aOItemNum{$i}; *)
				QUERY:C277([ItemXRef:22];  & [ItemXRef:22]SourceID:4=$theAcct)
				If (Records in selection:C76([ItemXRef:22])>0)
					FIRST RECORD:C50([ItemXRef:22])
					aOAltItem{$i}:=[ItemXRef:22]ItemNumXRef:2
				Else 
					QUERY:C277([Item:4]; [Item:4]itemNum:1=aOItemNum{$i})
					If (Records in selection:C76([Item:4])=1)
						aOAltItem{$i}:=[Item:4]mfrItemNum:39
					End if 
				End if 
			End for 
		End if 
	: ($1=(->[Invoice:26]))
		If ($byArray=1)
			$k:=Size of array:C274(aiAltItem)
			For ($i; 1; $k)
				QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumMaster:1=aiItemNum{$i}; *)
				QUERY:C277([ItemXRef:22];  & [ItemXRef:22]SourceID:4=$theAcct)
				If (Records in selection:C76([ItemXRef:22])>0)
					FIRST RECORD:C50([ItemXRef:22])
					aiAltItem{$i}:=[ItemXRef:22]ItemNumXRef:2
				Else 
					QUERY:C277([Item:4]; [Item:4]itemNum:1=aiItemNum{$i})
					If (Records in selection:C76([Item:4])=1)
						aiAltItem{$i}:=[Item:4]mfrItemNum:39
					End if 
				End if 
			End for 
		End if 
	: ($1=(->[PO:39]))
		If ($byArray=1)
			$k:=Size of array:C274(aPOVndrAlph)
			For ($i; 1; $k)
				QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumMaster:1=aPoItemNum{$i}; *)
				QUERY:C277([ItemXRef:22];  & [ItemXRef:22]SourceID:4=$theAcct)
				If (Records in selection:C76([ItemXRef:22])>0)
					FIRST RECORD:C50([ItemXRef:22])
					aPOVndrAlph{$i}:=[ItemXRef:22]ItemNumXRef:2
				Else 
					QUERY:C277([Item:4]; [Item:4]itemNum:1=aPoItemNum{$i})
					If (Records in selection:C76([Item:4])=1)
						aPOVndrAlph{$i}:=[Item:4]mfrItemNum:39
					End if 
				End if 
			End for 
		End if 
	: ($1=(->[Proposal:42]))
		
		If ($byArray=1)
			$k:=Size of array:C274(aPAltItem)
			For ($i; 1; $k)
				QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumMaster:1=aPItemNum{$i}; *)
				QUERY:C277([ItemXRef:22];  & [ItemXRef:22]SourceID:4=$theAcct)
				If (Records in selection:C76([ItemXRef:22])>0)
					FIRST RECORD:C50([ItemXRef:22])
					aPAltItem{$i}:=[ItemXRef:22]ItemNumXRef:2
				Else 
					QUERY:C277([Item:4]; [Item:4]itemNum:1=aPItemNum{$i})
					If (Records in selection:C76([Item:4])=1)
						aPAltItem{$i}:=[Item:4]mfrItemNum:39
					End if 
				End if 
			End for 
		End if 
End case 