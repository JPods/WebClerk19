//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/01/09, 23:30:24
// ----------------------------------------------------
// Method: TagsToDataBlock
// Description
// 
//
// Parameters
// ----------------------------------------------------
//($1;->ts;$tableStr;$field):Size
C_TEXT:C284($field; $textLoop; $textStartingclip; $tableName; $actionText)
C_POINTER:C301($ptTable)
C_TEXT:C284($textLoop; $builtText; breakText)
C_LONGINT:C283($p; $pend; $incRecords; $countRecords; $incTags; $start; $countTags; $blobSize; $tableNum)
C_TEXT:C284($0; $textFinal)
C_TEXT:C284($1; $textWorking)  // incoming block of text to parse and fill with data
C_TEXT:C284($fieldValue)  // May be used as array name in the event of a -6 loop tag
C_LONGINT:C283($incRecords; $countRecords; $incTags; $start; $countTags)

$tableNum:=vWebTagTableNum
$fieldValue:=vWebTagFormat  // #### AZM #### 20171004_1605 $fieldValue is used possibly as the array name.
$textWorking:=$1

//TRACE
$endLoop:=False:C215

ARRAY TEXT:C222($aStack; 0)
ARRAY LONGINT:C221($aTableTagNum; 0)
ARRAY TEXT:C222($aFieldValue; 0)
ARRAY TEXT:C222($aFormatValue; 0)

C_REAL:C285(pvQtyLikely; pvQtyAvailable)
$headend:=0
$footstart:=0
$builtText:=""


// parse an array of table, field, and format tags
Repeat 
	$p:=Position:C15(<>jitTag; $textWorking)
	$textLoop:=""
	
	If ($p<1)
		$endLoop:=True:C214
	Else 
		$textLoop:=$textLoop+Substring:C12($textWorking; 1; $p-1)
		$textWorking:=Substring:C12($textWorking; $p+<>lenJitTag)  //clip _jit_
		// $p:=Position(<>midTag;$textWorking)  //find midstr
		// $name:=Substring($textWorking;1;$p-1)  //clip to the ending
		// $textWorking:=Substring($textWorking;$p+1)  // clip the name
		$pend:=Position:C15(<>endTag; $textWorking)  //find the position of the field end char <>endTag   
		If ($pend<0)  // could not find an end tag put the text back together and drop out
			// $textOut:=$textOut+$textWorking // this is done at the end
			$endLoop:=True:C214  // drop out
			If (<>viDebugMode>410)
				ConsoleLog("No 'jj' end to tag: "+$textWorking)
			End if 
		Else 
			// there is an end tag
			$actionText:=Substring:C12($textWorking; 1; $pend-1)  //clip to the end Tag 
			$textWorking:=Substring:C12($textWorking; $pend+2)  // clip the working text check for extra j
			
			TagToComponents($actionText)
			
			Case of 
				: ((vWebTagTable="end") | (vWebTagTable="_end"))
					$endLoop:=True:C214
					$p:=Position:C15(<>endTag; $textWorking)
					// $textWorking:=Substring($textWorking;$p+<>lenEndTag)
					$textLoop:=$textLoop
					$textLoop:=$textLoop+Substring:C12($textWorking; $p+<>lenEndTag)
					
					APPEND TO ARRAY:C911($aStack; $textLoop)
					
					$textLoop:=""
					$textWorking:=""  // added 151222 
				Else 
					$size:=Size of array:C274($aStack)+1
					ARRAY TEXT:C222($aStack; $size)
					$aStack{$size}:=$textLoop
					//
					$textLoop:=""
					APPEND TO ARRAY:C911($aTableTagNum; vWebTagTableNum)
					// If (viWebTagFieldNum>0)  // found a valid field, not a script, variable, object
					APPEND TO ARRAY:C911($aFieldValue; vWebTagField)
					// Else 
					// APPEND TO ARRAY($aFieldValue;vWebTagField)
					// End if 
					APPEND TO ARRAY:C911($aFormatValue; vWebTagFormat)
			End case 
		End if 
	End if 
Until ($endLoop)
//






// zero items in Shopping cart
ARRAY TEXT:C222(ASHOPPINGCARTITEM; 0)
ARRAY REAL:C219(ASHOPPINGCARTQTY; 0)
ARRAY LONGINT:C221(ASHOPPINGCARTTIMES; 0)

// put data into the framework

$size:=Size of array:C274($aStack)


Case of 
	: ($tableNum>0)
		// Check if items are already in the shopping cart.
		// WebClerkShoppingCartAlready($tableNum)
		// relate items by using -6 scripts
		$tableName:=Table name:C256($tableNum)
		$ptTable:=Table:C252($tableNum)
		$countRecords:=Records in selection:C76($ptTable->)
		
		If ($tableNum=Table:C252(->[WebTempRec:101]))  // see if we are writing the shoppingcart
			// should this also be check if we are in orders and orderlines?
			C_LONGINT:C283(pvTimesInCart)
			ShoppingCartToArrays
			pvQtyInCart:=0
			pvDuplicateStyle:=""
			pvTimesInCart:=0
			If (False:C215)  // old method at teh page level
				If ((voState.url="/Item_List@") | (voState.url="/Order_item@") | ($tableNum=4) | ($tableNum=Table:C252(->[OrderLine:49])))
					ShoppingCartReload
				End if 
			End if 
		End if 
		
		
		
		$cntSelectionRecords:=RECORDS IN NAMED SELECTION($ptTable; $tableName+String:C10([EventLog:75]idNum:5))
		// testing
		// ### jwm ### 20160617_0106 are we losing our selection here ?
		// ### jwm ### 20160622_0018 <>viMaxShow not set when not running WebClerk
		// what should <>viMaxShow be for Defined Reports and internal Scripts?
		// set to record count if zero No Limit
		// how do we get to the next block of records in the selection?
		
		If (<>viMaxShow=0)
			<>viMaxShow:=1000  // ### jwm ### 20160622_0944
		End if 
		If ($countRecords><>viMaxShow)  // ### jwm ### 20160622_000
			// assume sorted as desired
			C_LONGINT:C283($cntSelectionRecords)
			$cntSelectionRecords:=RECORDS IN NAMED SELECTION($ptTable; $tableName+String:C10([EventLog:75]idNum:5))
			REDUCE SELECTION:C351($ptTable->; <>viMaxShow)
			$countRecords:=Records in selection:C76($ptTable->)
		End if 
		
		
		// TRACE
		// fixTHIS qqqq
		FIRST RECORD:C50(Table:C252($tableNum)->)
		$doSpec:=False:C215
		
		C_LONGINT:C283(jitRecordNum)
		C_LONGINT:C283(pvLineStyle)
		jitRecordNum:=Record number:C243(Table:C252($tableNum)->)
		//TRACE
		C_TEXT:C284($tempItemNum)
		C_LONGINT:C283($foundInCart)
		$tempItemNum:=""
		For ($incRecords; 1; $countRecords)
			pvDuplicateStyle:=""
			pvDuplicateItemNum:=""
			pvQtyInCart:=0
			pvTimesInCart:=0
			If ([WebTempRec:101]itemNum:3#"")  // Ref:  ShoppingCartToArrays are we looping through the shopping cart
				$foundInCart:=Find in array:C230(aShoppingCartItem; [WebTempRec:101]itemNum:3)
				If ($foundInCart>0)
					pvQtyInCart:=aShoppingCartQty{$foundInCart}
					pvTimesInCart:=aShoppingCartTimes{$foundInCart}
					If (pvTimesInCart>1)
						pvDuplicateStyle:="Duplicate in cart"
						pvDuplicateItemNum:="duplicateItemNum"
					Else 
						pvDuplicateItemNum:=""
						pvDuplicateStyle:=""
					End if 
				End if 
			End if 
			If ($tableNum=4)
				If ([Item:4]specid:62#"")
					QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]specid:62)
				Else 
					QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]itemNum:1)
				End if 
				ItemKeyPathVariables  // need to fill in variables and pricing.
			Else 
				// RelateOnWeb  look at what should and should not be added from these. Clean up.
			End if 
			// 
			$countTags:=Size of array:C274($aTableTagNum)
			$start:=1
			For ($incTags; $start; $countTags)
				$textLoop:=$textLoop+$aStack{$incTags}
				
				vWebTagTableNum:=$aTableTagNum{$incTags}
				vWebTagField:=$aFieldValue{$incTags}
				viWebTagFieldNum:=Num:C11(vWebTagField)
				vWebTagFormat:=$aFormatValue{$incTags}
				$textLoop:=$textLoop+Tag2Value
			End for 
			//$textLoop:=Replace string($textLoop;"rjit";"_jit")//added to put refs into the output
			If (Size of array:C274($aStack)>$countTags)
				$textLoop:=$textLoop+$aStack{Size of array:C274($aStack)}
			End if 
			$textLoop:=Replace string:C233($textLoop; <>refTag; <>jitTag)  //added to put refs into the output
			
			If ($countRecords>1)
				NEXT RECORD:C51(Table:C252($tableNum)->)
			End if 
			//Until (($spinc=10)|($incRecords=$countRecords))
			
			// put the text into a container
			$textFinal:=$textFinal+$textLoop
			$textLoop:=""
			
		End for 
		
		
		
		
		
	: ($tableNum=-6)  // process an array element
		
		C_POINTER:C301($ptArray)
		$ptArray:=Get pointer:C304($fieldValue)
		$countRecords:=Size of array:C274($ptArray->)
		
		C_LONGINT:C283(jitRecordNum)
		C_LONGINT:C283(pvLineStyle)
		
		vLineStyleMod:=2  // ### jwm ### 20171004_1913
		
		For ($incRecords; 1; $countRecords)
			pvLineStyle:=$incRecords%vLineStyleMod
			$textLoop:=""
			$start:=1
			$countTags:=$size-1
			//  
			For ($incTags; $start; $countTags)
				$textLoop:=$textLoop+$aStack{$incTags}
				vWebTagTableNum:=$aTableTagNum{$incTags}
				vWebTagField:=$aFieldValue{$incTags}  // #### AZM #### 20171004_1614 This was calling old $size variable that doesn't exist.
				vWebTagFormat:=$aFormatValue{$incTags}  // #### AZM #### 20171004_1614 This was calling old $size variable that doesn't exist.
				$textLoop:=$textLoop+Tag2Value(vWebTagTableNum; vWebTagField; 1; vWebTagTableNum)
			End for 
			If (Size of array:C274($aStack)>=$incTags)
				$textLoop:=$textLoop+$aStack{$incTags}
			End if 
			$textLoop:=Replace string:C233($textLoop; <>refTag; <>jitTag)  //added to put refs into the output
			
			$textFinal:=$textFinal+$textLoop
			$textLoop:=""
		End for 
		
		
End case 
//
$0:=$textFinal

breakText:=""
breakTable:=0
breakField:=0