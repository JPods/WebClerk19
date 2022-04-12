//%attributes = {"publishedWeb":true}
//
If (False:C215)
	//Method: ItemExpander
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
TRACE:C157
CLOSE DOCUMENT:C267(sumDoc)
CLOSE DOCUMENT:C267(myDoc)
myDoc:=Open document:C264("")
sumDoc:=Create document:C266("")
If (OK=1)
	$masterItemNum:="asfojwof4y8odhifgoiug"
	RECEIVE PACKET:C104(myDoc; $theLine; "\r")  //clear header
	$ciItemNumBase:=1
	$ciLable:=2
	$ciCatagory:=3
	$ciCode:=4
	$ciCounter:=5
	$ciSKUComponent:=6
	$ciSequence:=7
	RECEIVE PACKET:C104(myDoc; $theLine; "\r")  //first line
	$keepGoing:=(OK=1)
	If ($keepGoing)
		TextToArray($theLine; ->aText5; "\t"; True:C214)  //first line
		$rightSize:=(Size of array:C274(aText5)=7)
		If ($rightSize)
			Repeat 
				ARRAY TEXT:C222($aOptions; 0)
				//        
				ARRAY TEXT:C222($aCatagory; 0)
				ARRAY TEXT:C222($aSKUComponent; 0)
				ARRAY TEXT:C222($aLable; 0)
				ARRAY LONGINT:C221($aSequence; 0)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=aText5{$ciItemNumBase})
				If (Records in selection:C76([Item:4])#1)
					SEND PACKET:C103(sumDoc; aText5{$ciItemNumBase}+"\r")
					RECEIVE PACKET:C104(myDoc; $theLine; "\r")
					$keepGoing:=(OK=1)
					TextToArray($theLine; ->aText5; "\t"; True:C214)
					$rightSize:=(Size of array:C274(aText5)=7)
					$rightItem:=False:C215
				Else 
					$recNum:=Record number:C243([Item:4])
					$masterItemNum:=[Item:4]itemNum:1
					$masterDesc:=[Item:4]description:7
					$masterPrice:=[Item:4]priceA:2
					$seq:=0
					[Item:4]profile1:35:="Master"
					SAVE RECORD:C53([Item:4])
					$rightItem:=True:C214
					
					//$aCatagory{$ciItemNumBase}:=aText5{$ciCatagory}
					//$aLable{$ciItemNumBase}:=aText5{$ciLable}
					//$aSKUComponent{$ciItemNumBase}:=aText5{6}
					//        
					While (($keepGoing) & ($rightSize) & ($rightItem))
						$w:=Size of array:C274($aCatagory)+1
						INSERT IN ARRAY:C227($aCatagory; $w; 1)
						INSERT IN ARRAY:C227($aSKUComponent; $w; 1)
						INSERT IN ARRAY:C227($aLable; $w; 1)
						INSERT IN ARRAY:C227($aSequence; $w; 1)
						$aCatagory{$w}:=aText5{$ciCatagory}
						$aLable{$w}:=aText5{$ciLable}
						$aSKUComponent{$w}:=aText5{$ciSKUComponent}
						$aSequence{$w}:=Num:C11(aText5{$ciSequence})
						
						$cntOptions:=Find in array:C230($aOptions; aText5{$ciCatagory})
						If ($cntOptions<0)
							$cntOptions:=Size of array:C274($aOptions)+1
							INSERT IN ARRAY:C227($aOptions; $cntOptions; 1)
							$aOptions{$cntOptions}:=aText5{$ciCatagory}
						End if 
						
						RECEIVE PACKET:C104(myDoc; $theLine; "\r")
						$keepGoing:=(OK=1)
						TextToArray($theLine; ->aText5; "\t"; True:C214)
						$rightSize:=(Size of array:C274(aText5)=7)
						If ($rightSize)
							$rightItem:=($masterItemNum=aText5{$ciItemNumBase})
						End if 
					End while 
					//     
					SORT ARRAY:C229($aSequence; $aCatagory; $aLable; $aSKUComponent)
					$cntOptions:=Size of array:C274($aOptions)
					//
					ARRAY TEXT:C222($aCatagory1; 0)
					ARRAY TEXT:C222($aSKUComponent1; 0)
					ARRAY TEXT:C222($aLable1; 0)
					ARRAY TEXT:C222($aCatagory2; 0)
					ARRAY TEXT:C222($aSKUComponent2; 0)
					ARRAY TEXT:C222($aLable2; 0)
					ARRAY TEXT:C222($aCatagory3; 0)
					ARRAY TEXT:C222($aSKUComponent3; 0)
					ARRAY TEXT:C222($aLable3; 0)
					ARRAY TEXT:C222($aCatagory4; 0)
					ARRAY TEXT:C222($aSKUComponent4; 0)
					ARRAY TEXT:C222($aLable4; 0)
					$cntRay:=Size of array:C274($aSKUComponent)
					Case of 
						: ($cntOptions=1)
							For ($incItem; 1; $cntRay)
								ItemExpanderFill($masterItemNum; $aSKUComponent{$incItem}; $aLable{$incItem}; $aCatagory{$incItem}; $aCatagory{$incItem}+"//"+$aLable{$incItem})
							End for 
						: ($cntOptions=2)
							For ($incItem; 1; $cntRay)
								If ($aCatagory{$incItem}=$aOptions{1})
									$wSize:=Size of array:C274($aCatagory1)+1
									INSERT IN ARRAY:C227($aCatagory1; $wSize; 1)
									INSERT IN ARRAY:C227($aSKUComponent1; $wSize; 1)
									INSERT IN ARRAY:C227($aLable1; $wSize; 1)
									$aCatagory1{$wSize}:=$aCatagory{$incItem}
									$aSKUComponent1{$wSize}:=$aSKUComponent{$incItem}
									$aLable1{$wSize}:=$aLable{$incItem}
								Else 
									$wSize:=Size of array:C274($aCatagory2)+1
									INSERT IN ARRAY:C227($aCatagory2; $wSize; 1)
									INSERT IN ARRAY:C227($aSKUComponent2; $wSize; 1)
									INSERT IN ARRAY:C227($aLable2; $wSize; 1)
									$aCatagory2{$wSize}:=$aCatagory{$incItem}
									$aSKUComponent2{$wSize}:=$aSKUComponent{$incItem}
									$aLable2{$wSize}:=$aLable{$incItem}
								End if 
							End for 
							$cntRay1:=Size of array:C274($aCatagory1)
							$cntRay2:=Size of array:C274($aCatagory2)
							For ($incItem1; 1; $cntRay1)
								For ($incItem2; 1; $cntRay2)
									ItemExpanderFill($masterItemNum; $aSKUComponent1{$incItem1}+$aSKUComponent2{$incItem2}; $aLable1{$incItem1}+", "+$aLable2{$incItem2}; $aCatagory1{$incItem1}; $aCatagory1{$incItem1}+"//"+$aLable1{$incItem1}+", "+$aCatagory2{$incItem2}+"//"+$aLable2{$incItem2})
								End for 
							End for 
							
						: ($cntOptions=3)
							For ($incItem; 1; $cntRay)
								Case of 
									: ($aCatagory{$incItem}=$aOptions{1})
										$wSize:=Size of array:C274($aCatagory1)+1
										INSERT IN ARRAY:C227($aCatagory1; $wSize; 1)
										INSERT IN ARRAY:C227($aSKUComponent1; $wSize; 1)
										INSERT IN ARRAY:C227($aLable1; $wSize; 1)
										$aCatagory1{$wSize}:=$aCatagory{$incItem}
										$aSKUComponent1{$wSize}:=$aSKUComponent{$incItem}
										$aLable1{$wSize}:=$aLable{$incItem}
									: ($aCatagory{$incItem}=$aOptions{2})
										$wSize:=Size of array:C274($aCatagory2)+1
										INSERT IN ARRAY:C227($aCatagory2; $wSize; 1)
										INSERT IN ARRAY:C227($aSKUComponent2; $wSize; 1)
										INSERT IN ARRAY:C227($aLable2; $wSize; 1)
										$aCatagory2{$wSize}:=$aCatagory{$incItem}
										$aSKUComponent2{$wSize}:=$aSKUComponent{$incItem}
										$aLable2{$wSize}:=$aLable{$incItem}
									Else 
										$wSize:=Size of array:C274($aCatagory3)+1
										INSERT IN ARRAY:C227($aCatagory3; $wSize; 1)
										INSERT IN ARRAY:C227($aSKUComponent3; $wSize; 1)
										INSERT IN ARRAY:C227($aLable3; $wSize; 1)
										$aCatagory3{$wSize}:=$aCatagory{$incItem}
										$aSKUComponent3{$wSize}:=$aSKUComponent{$incItem}
										$aLable3{$wSize}:=$aLable{$incItem}
										
								End case 
							End for 
							$cntRay1:=Size of array:C274($aCatagory1)
							$cntRay2:=Size of array:C274($aCatagory2)
							$cntRay3:=Size of array:C274($aCatagory3)
							For ($incItem1; 1; $cntRay1)
								For ($incItem2; 1; $cntRay2)
									For ($incItem3; 1; $cntRay3)
										ItemExpanderFill($masterItemNum; $aSKUComponent1{$incItem1}+$aSKUComponent2{$incItem2}+$aSKUComponent3{$incItem3}; $aLable1{$incItem1}+", "+$aLable2{$incItem2}+", "+$aLable3{$incItem3}; $aCatagory1{$incItem1}; $aCatagory1{$incItem1}+"//"+$aLable1{$incItem1}+", "+$aCatagory2{$incItem2}+"//"+$aLable2{$incItem2}+", "+$aCatagory3{$incItem3}+"//"+$aLable3{$incItem3})
									End for 
								End for 
							End for 
						Else 
							SEND PACKET:C103(sumDoc; $masterItemNum+"\t"+String:C10($cntOptions)+"\r")
							
					End case 
				End if 
			Until ($keepGoing=False:C215)
		End if 
	End if 
	CLOSE DOCUMENT:C267(myDoc)
	CLOSE DOCUMENT:C267(sumDoc)
End if 
