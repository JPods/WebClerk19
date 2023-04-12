//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-17T00:00:00, 13:20:54
// ----------------------------------------------------
// Method: TagsToText
// Description
// Modified: 12/17/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160927_1753 commented out Console_Log used for debugging

C_TEXT:C284($0; $1; $textWorking; $textOut; $fieldOrObject; $textBlock; $actionText)
C_LONGINT:C283(breakTable; breakField; vWebTagTableNum)
C_LONGINT:C283($lenBlob; $offset)
C_LONGINT:C283($pend; $p; $pmid)
C_BOOLEAN:C305($endLoop)
//
$setToClip:=True:C214

$textWorking:=$1
$textOut:=""
$endLoop:=False:C215

C_LONGINT:C283($pSecure; $viSecureRequired)

//Console_Log ($textWorking)

Repeat 
	$p:=Position:C15(<>jitTag; $textWorking)  //find the next tag beginning
	If ($p<1)  //if we do not find a tag, add text to blob and clear text
		$endLoop:=True:C214
	Else 
		// there is a start tag
		$textOut:=$textOut+Substring:C12($textWorking; 1; $p-1)  //clip text up to the file/fld into $textOut
		$textWorking:=Substring:C12($textWorking; $p+<>lenJitTag)  //clip off thru the <>jitTag string
		//
		If ($textWorking="secureBegin_@")  // if there is a secure block
			// remove either the check if there is authority or the block, the loop back to 
			//  look for the next tag
			$textWorking:=Substring:C12($textWorking; 13)
			$pSecure:=Position:C15("jj"; $textWorking)
			$viSecureRequired:=Num:C11(Substring:C12($textWorking; 1; $pSecure-1))
			If (($viSecureRequired<=viSecureLvl) | ($viSecureRequired<=vWccSecurity))
				$textWorking:=Substring:C12($textWorking; $pSecure+2)
				$pSecure:=Position:C15("_jit_secureEndjj"; $textWorking)
				$textWorking:=Replace string:C233($textWorking; "_jit_secureEndjj"; ""; 1)
				$textWorking:=$textWorking+"<!-- security clip "+String:C10($viSecureRequired)+" -->"
			Else 
				$pSecure:=Position:C15("_jit_secureEnd_jj"; $textWorking)
				$textWorking:=Substring:C12($textWorking; $pSecure+17)
			End if 
		Else 
			//
			If (False:C215)  // hold until 160101?
				// was this required?
				$textOut:=$textOut+Replace string:C233($textOut; <>refTag; <>jitTag)  //added to put refs into the output  
			End if 
			$pend:=Position:C15(<>endTag; $textWorking)  //find the position of the field end char <>endTag   
			If ($pend<0)  // could not find an end tag put the text back together and drop out
				// $textOut:=$textOut+$textWorking // this is done at the end
				$endLoop:=True:C214  // drop out
			Else 
				// there is an end tag
				$actionText:=Substring:C12($textWorking; 1; $pend-1)  //clip to the end Tag 
				
				TagToComponents($actionText)
				// moved to after parsing for checking
				$textWorking:=Substring:C12($textWorking; $pend+<>lenEndTag)  //clip working from pending
				
				Case of 
					: (vWebTagTable="headbreak")  //lists
						breakTable:=vWebTagTableNum
						$mySort:="_jitSort_"+String:C10(breakTable)+"_"+vWebTagTable+"jj"
						//breakField:=Http_DoSort($mySort)
						//$p:=Position("_jit_headend";$textWorking)
						//$breakText:=Substring($textWorking;1;$p-1)
						//$textWorking:=Substring($textWorking;$p+1)
						//$p:=Position(<>endTag;$textWorking)
						//$textWorking:=Substring($textWorking;$p+<>lenEndTag)
					: (vWebTagTable="begin")  //_jit_begin_54_1jj
						$pEnd:=Position:C15("_jit_end_jj"; $textWorking)
						$actionText:=Substring:C12($textWorking; 1; $pEnd+11)
						C_LONGINT:C283(foundTableNum)
						$foundTableNum:=Find in array:C230(<>aTableNames; vWebTagField)  //this is the second element in the tag  Table Name or Number
						If ($foundTableNum>0)
							vWebTagTableNum:=<>aTableNums{$foundTableNum}  // get the matching table number
						Else 
							vWebTagTableNum:=Num:C11(vWebTagField)  // 
							//Console_Log ($actionText)
						End if 
						$textWorking:=Substring:C12($textWorking; $pEnd+11)
						
						//Console_Log ($textWorking)
						
						$textBlock:=TagsToDataBlock($actionText)  //;vWebTagField)  //;$doRecord;$tableNumBreak;$breakField;$breakText)
						//Console_Log ($textBlock)
						$textOut:=$textOut+$textBlock
						$textBlock:=""
						//Console_Log ($textOut)
						
					Else 
						C_TEXT:C284($convText)
						// If (Size of array(aShoppingCartItem)>0)
						
						// End if
						//If (viWebTagFieldNum<1)
						If (viWebTagFieldNum>0)  // found a valid field value, 
							$textOut:=$textOut+Tag2Value(vWebTagTableNum; String:C10(viWebTagFieldNum); 1)  // fieldname should have already been set to string of fieldNum
						Else 
							$textOut:=$textOut+Tag2Value(vWebTagTableNum; vWebTagField; 1)  // fieldname should have already been set to string of fieldNum
						End if 
						//else 
						//$textOut:=$textOut+Tag2Value (vWebTagTableNum;viWebTagFieldNum;1)  //found a table and field in TagToComponents  
						//end if 
						//Console_Log ($textOut)
						$convText:=""
				End case 
			End if 
		End if 
	End if 
Until ($endLoop)
$textOut:=$textOut+$textWorking
$0:=Replace string:C233($textOut; <>refTag; <>jitTag)  //added to put refs into the output