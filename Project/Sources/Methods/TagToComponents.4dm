//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-13T00:00:00, 19:30:45
// ----------------------------------------------------
// Method: TagToComponents
// Description
// Modified: 08/13/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)
C_TEXT:C284(vWebTagTable; vWebTagField; vWebTagFormat; $actionText; vWebTagNum; vWebTagNames)
C_LONGINT:C283($pend; $p; $pmid; vWebTagTableNum; vWebTagTableNum; $countTables)
$countTables:=Get last table number:C254
vWebTagTable:=""
vWebTagField:=""
vWebTagFormat:=""
viWebTagFieldNum:=-100  // set this to test in 
vWebTagTableNum:=-100  // set to an unused negative number
//  ptWebTag:=(->)

$actionText:=$1

If ($actionText="_jit_@")
	$actionText:=Substring:C12($actionText; 6)
	$length:=Length:C16($actionText)
	If (Substring:C12($actionText; $length-1)="jj")  // #### AZM #### 20171016_1525 THIS WAS RETURNING THE LAST THREE CHARACTERS, SO NEVER RETURNING TRUE
		$actionText:=Substring:C12($actionText; 1; $length-2)
	End if 
End if 
If ($actionText="")
	
Else 
	If ($actionText[[1]]="[")
		$actionText:=Replace string:C233(Substring:C12($actionText; 2); "]"; "_")  // get 4D format into web format
	End if 
	// separate the table/number
	$pmid:=Position:C15(<>midTag; $actionText)  //find the position of the file/field seperator
	vWebTagTable:=Substring:C12($actionText; 1; $pmid-1)  //read in the file number 
	
	$actionText:=Substring:C12($actionText; $pmid+1)  //clip off thru the <>midTag string
	// separate the formating
	If ((vWebTagTable="-6") | (vWebTagTable="Script") | (vWebTagTable="-3") | (vWebTagTable="Object"))
		$pmid:=-1  // do not clip if this is a script
	Else 
		$pmid:=Position:C15(<>midTag; $actionText)  //find the position of the file/field seperator
	End if 
	If ($pmid>0)
		vWebTagField:=Substring:C12($actionText; 1; $pmid-1)  //read in the file number 
		vWebTagFormat:=Substring:C12($actionText; $pmid+1)  //clip off thru the <>midTag string
	Else 
		vWebTagField:=$actionText
		vWebTagFormat:=""  // for easier reading
	End if 
	
	If (vWebTagField="pvItemPathImage")
		// debugging
		// ### bj ### 20191210_1346
	End if 
	
	
	C_LONGINT:C283($foundTableNum; $foundField; $testFieldNum; $testTableNum)
	C_TEXT:C284($fieldName; $tableName)
	C_POINTER:C301(ptWebTag)
	C_POINTER:C301($ptArray)
	$foundTableNum:=0
	$foundTableNum:=Find in array:C230(<>aTableNames; vWebTagTable)
	If ($foundTableNum>0)
		vWebTagTableNum:=<>aTableNums{$foundTableNum}  // get the matching table number
	Else 
		vWebTagTableNum:=Num:C11(vWebTagTable)
		Case of 
			: (vWebTagTableNum>0)
				vWebTagTable:=Table name:C256(vWebTagTableNum)
				// drop to next section
			: ((vWebTagTable="script") | (vWebTagTable="-6"))
				vWebTagTableNum:=-6
				vWebTagFormat:="txt"
			: ((vWebTagTable="object") | (vWebTagTable="-3"))
				vWebTagTableNum:=-3
				vWebTagFormat:="txt"
			: ((vWebTagTable="array") | (vWebTagTable="-2"))
				vWebTagTableNum:=-2
				// vWebTagFormat:=vWebTagFormat
			: ((vWebTagTable="variable") | (vWebTagTable="0"))
				vWebTagTableNum:=0
				// vWebTagFormat:=vWebTagFormat
				// pass back out vWebTagTable as received to account for -actions, begin, etc
			Else 
				vWebTagTableNum:=-222
		End case 
		// vWebTagTableNum:=Num(vWebTagTable) individual 
	End if 
	If (vWebTagTableNum>0)  // we have a valid table number otherwise, leave vWebTagField as passed
		$ptArray:=Get pointer:C304("<>a"+vWebTagTable+"_FL")
		$foundField:=Find in array:C230($ptArray->; vWebTagField)  // will not find if a number
		If ($foundField>0)  // passing as a name   SEE line 105
			viWebTagFieldNum:=$foundField
			ptWebTag:=Field:C253(vWebTagTableNum; viWebTagFieldNum)
			vWebTagField:=String:C10(viWebTagFieldNum)
		Else 
			viWebTagFieldNum:=Num:C11(vWebTagField)
			
			// gkgkgk
			// ### jwm ### 20180825_1622  had to set this so if people put in too big a field number
			Case of 
				: (viWebTagFieldNum>0)
					If (viWebTagFieldNum>Size of array:C274($ptArray->))  // passing as a field number  SEE line 98
						ptWebTag:=Field:C253(vWebTagTableNum; 1)  // force assign to the first field in a table
					Else 
						vWebTagField:=String:C10(viWebTagFieldNum)  //  Field name(ptWebTag)  cannot be the name to build the the array
						ptWebTag:=Field:C253(vWebTagTableNum; viWebTagFieldNum)
						// gkgkgk
						//  // ### bj ### 20180825_1553
					End if 
				: ((vWebTagField="records") | (vWebTagField="0"))  // already = "0"
					viWebTagFieldNum:=0
					vWebTagField:="0"  // must be the string of then num for this to work in a text block
				: ((vWebTagField="tablename") | (vWebTagField="-1"))  // already = "-1"
					viWebTagFieldNum:=-1
					vWebTagField:="-1"  // must be the string of then num for this to work in a text block
				: ((vWebTagField="recordnum") | (vWebTagField="-2"))  // already = "-2"
					viWebTagFieldNum:=-2
					vWebTagField:="-2"  // must be the string of then num for this to work in a text block
				Else 
					viWebTagFieldNum:=-111
					vWebTagField:="error"
			End case 
		End if 
	End if 
End if 


If (<>viDebugMode>410)
	C_TEXT:C284($tagConvert)
	$tagConvert:=$actionText+": "+vWebTagTable+": "+vWebTagField+": "+vWebTagFormat
	ConsoleLog($tagConvert)
End if 
