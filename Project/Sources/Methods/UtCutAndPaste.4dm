//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: UtCutAndPaste
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
CLOSE DOCUMENT:C267(myDoc)
//
myDoc:=Open document:C264(document)  //"")
If (OK=1)
	
	CLOSE DOCUMENT:C267(myDoc)
	
	$tempFold:=HFS_ParentName(document)
	$err:=HFS_CatToArray($tempFold; "aText10")
	$k:=Size of array:C274(aText10)
	ARRAY TEXT:C222(aText9; $k)
	
	C_LONGINT:C283($p; $pPound)
	For ($i; $k; 1; -1)
		$p:=Position:C15(".jpg"; aText10{$i})
		$pPound:=Position:C15("#"; aText10{$i})
		$sizeaText9:=Size of array:C274(aText9)+1
		Case of 
			: (($pPound>0) & ($pPound<$p))
				aText9{$i}:=Substring:C12(aText10{$i}; 1; $pPound-1)
			: ($p>0)
				aText9{$i}:=Substring:C12(aText10{$i}; 1; $p-1)
			Else 
				DELETE FROM ARRAY:C228(aText9; $i)
				DELETE FROM ARRAY:C228(aText10; $i)
		End case 
	End for 
	$k:=Size of array:C274(aText9)
	ARRAY LONGINT:C221($aFileOrder; $k)
	$theRayText:=""
	For ($i; 1; $k)
		$theRayText:=$theRayText+aText9{$i}+"\r"
		$aFileOrder{$i}:=$i
	End for 
	SORT ARRAY:C229(aText9; $aFileOrder)
	SET TEXT TO PASTEBOARD:C523($theRayText)
	TRACE:C157
	//    
	$specName:=""
	$specNameTest:=""
	$specCount:=1000
	ARRAY TEXT:C222(aText1; 0)
	RECEIVE PACKET:C104(myDoc; $myText; "\r")  //clip first row
	Repeat 
		RECEIVE PACKET:C104(myDoc; $myText; "\r")
		If (OK=1)
			$w:=Size of array:C274(aText1)+1
			INSERT IN ARRAY:C227(aText1; $w)
			aText1{$w}:=$myText
			TextToArray(aText1{$w}; ->aText5; "\t"; True:C214)
			If (Size of array:C274(aText5)>5)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=aText5{2})
				If (Records in selection:C76=0)
					CREATE RECORD:C68([Item:4])
					[Item:4]itemNum:1:=aText5{2}
					[Item:4]description:7:=aText5{1}
				End if 
				[Item:4]mfrItemNum:39:=aText5{3}
				[Item:4]mfrID:53:=aText5{4}
				[Item:4]priceA:2:=Num:C11(aText5{7})
				[Item:4]vendorID:45:=aText5{6}
				[Item:4]vendorItemNum:40:=aText5{5}
				//ARRAY LONGINT($found
				For ($incList; 1; $cntList)
					
					
					
					
				End for 
				//
				//
				//
				//$err:=HFSCatToArray ($tempFold;"aText1")//
			Else 
				OK:=0
			End if 
		End if 
	Until (OK=0)
End if 
