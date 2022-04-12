//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-05-08T00:00:00, 14:43:15
// ----------------------------------------------------
// Method: WC_jitNum2Name
// Description
// Modified: 05/08/17
// 
// 
//
// Parameters
// ----------------------------------------------------

//  pass in text in $1
// return text in $0
// flip to numbers pass parameter $2 = "numbered", else it will flip numbers to fieldnames


// 
C_TEXT:C284($1; $0)
C_LONGINT:C283($doNum2Name; $countTables)
C_TEXT:C284($thePage)
C_TEXT:C284($formatTag; $tableStr; $fieldStr)
C_TEXT:C284($2; $srchStr)

C_LONGINT:C283($lenJitTagLess1)
$startStr:=<>jitTag
$startStr:=Substring:C12($startStr; 2)  // clip the search string so rjit_ and _jit_ are both managed
$lenJitTagLess1:=<>lenJitTag-1
$countTables:=Get last table number:C254
Case of 
	: (Count parameters:C259=0)
		$thePage:=Get text from pasteboard:C524
		$doNum2Name:=2  // put out the page with names
	: (Count parameters:C259=1)
		$thePage:=$1
		$doNum2Name:=2  // put out the page with names
	Else 
		If (Count parameters:C259=2)
			$doNum2Name:=Num:C11($2="Numbered")  //   
		Else 
			$doNum2Name:=2  //  if equal to one it outputs names
			// else it will output tableNumbers and FieldNumbers
		End if 
		$thePage:=$1
End case 

If (Position:C15("jit_"; $thePage)=0)  // needs to process both rjit_ and _jit_
	$0:=$1
Else 
	$buildPage:=""
	//
	$p:=Position:C15($startStr; $thePage)
	While ($p>0)
		$buildPage:=$buildPage+Substring:C12($thePage; 1; $p+3)  //put the HTML infor up to the file/fld into $buildPage
		$thePage:=Substring:C12($thePage; $p+$lenJitTagLess1)  //clip off thru the $startStr string
		
		// $p:=Position(<>midTag;$thePage)  //find the position of the file/field seperator
		//  $tableStr:=Substring($thePage;1;$p-1)  //read in the file number, does support >1 char nums
		// $thePage:=Substring($thePage;$p+<>lenMidTag)  //clip the "_" mid character
		$p:=Position:C15(<>endTag; $thePage)  //find the position of the file/field seperator
		$workingText:=Substring:C12($thePage; 1; $p-1)
		$thePage:=Substring:C12($thePage; $p)  //clip the "jj" end characters
		//
		
		
		TagToComponents($workingText)
		// vWebTagTable
		// vWebTagTableNum
		// vWebTagField
		// viWebTagFieldNum
		// vWebTagFormat
		
		C_TEXT:C284($textTag)
		If ((viWebTagFieldNum<1) | (vWebTagTableNum<=0) | (vWebTagTableNum>$countTables))
			$buildPage:=$buildPage+$workingText
		Else 
			If ($doNum2Name=1)  //2 numbered
				$textTag:=String:C10(vWebTagTableNum)+<>midTag+String:C10(viWebTagFieldNum)+(("_"+vWebTagFormat)*(Num:C11(vWebTagFormat#"")))
			Else 
				// ### jwm ### 20180828_1004
				//  gkgkgk
				If (viWebTagFieldNum>0)
					C_TEXT:C284($fieldName)
					$fieldName:=Field name:C257(ptWebTag)
					$textTag:=vWebTagTable+<>midTag+$fieldName+(("_"+vWebTagFormat)*(Num:C11(vWebTagFormat#"")))
				Else 
					$textTag:=vWebTagTable+<>midTag+vWebTagField+(("_"+vWebTagFormat)*(Num:C11(vWebTagFormat#"")))
				End if 
			End if 
			$buildPage:=$buildPage+$textTag
		End if 
		
		$p:=Position:C15($startStr; $thePage)
	End while 
	$buildPage:=$buildPage+$thePage
	$thePage:=$buildPage
	
	$0:=$buildPage
	
	If (False:C215)
		SET TEXT TO PASTEBOARD:C523($buildPage)
	End if 
End if 