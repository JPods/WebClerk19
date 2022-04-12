//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: ItemImportFieldNames
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
C_TEXT:C284($theLine)
CLOSE DOCUMENT:C267(myDoc)
CLOSE DOCUMENT:C267(sumDoc)
If (Count parameters:C259=1)
	$myDoc:=$1
Else 
	$myDoc:=""
End if 
myDoc:=Open document:C264($myDoc)
If (OK=1)
	$docShortName:=HFS_ShortName(document)
	$docParent:=HFS_ParentName(document)
	// sumDoc:=create document($docParent+"vendErr"+$docShortName)
	RECEIVE PACKET:C104(myDoc; $theLine; "\r")  //clear header
	TextToArray($theLine; ->aText5; "\t"; True:C214)
	C_LONGINT:C283($i; $k; $w; $keyField; $counter)
	$k:=Size of array:C274(aText5)
	$counter:=0
	ARRAY POINTER:C280($aPointFields; $k)
	ARRAY LONGINT:C221($aFieldNum; $k)
	For ($i; 1; $k)
		$w:=Find in array:C230(<>aItems_FL; aText5{$i})
		If ($w>0)
			$aPointFields{$i}:=Field:C253(4; $w)
			$aFieldNum{$i}:=$w
		Else 
			$aFieldNum{$i}:=-1
		End if 
	End for 
	$keyField:=Find in array:C230(aText5; "ItemNum")
	If ($keyField<1)
		ALERT:C41("No Key Field")
	Else 
		Repeat 
			$counter:=$counter+1
			RECEIVE PACKET:C104(myDoc; $theLine; "\r")
			If (OK=0)
				<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ? 
				RECEIVE PACKET:C104(myDoc; $theLine; <>vEoF)
			End if 
			If (OK=1)
				If ($theLine#"")
					TextToArray($theLine; ->aText5; "\t"; True:C214)
					If (aText5{1}="6@")
						QUERY:C277([Item:4]; [Item:4]itemNum:1=aText5{$keyField})
						If (Records in selection:C76([Item:4])=0)
							CREATE RECORD:C68([Item:4])
							[Item:4]itemNum:1:=aText5{$keyField}
						End if 
						For ($i; 1; $k)
							If ($aFieldNum{$i}>0)
								UtFillifNotEmpty($aPointFields{$i}; aText5{$i}; 0)
							End if 
						End for 
						SAVE RECORD:C53([Item:4])
					End if 
				End if 
			End if 
		Until (OK=0)
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 

