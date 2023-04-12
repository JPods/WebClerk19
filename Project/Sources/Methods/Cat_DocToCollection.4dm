//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/23/21, 23:53:22
// ----------------------------------------------------
// Method: Cat_DocToCollection
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $vtFileName; $2; $vtPathToFolder; $vtPathToDoc)
C_OBJECT:C1216($3; $voOutPut; $voLine)
$voOutPut:=New object:C1471
C_LONGINT:C283($inc; $cnt)
$vtFileName:=$1
$3[$vtFileName]:=New object:C1471
//$0[$vtFileName]:=New object
$vtPathToFolder:=$2
$vtPathToDoc:=$vtPathToFolder+Folder separator:K24:12+$vtFileName

C_COLLECTION:C1488($vcLines)


$vtCatalog:=Document to text:C1236($vtPathToDoc)


C_COLLECTION:C1488($vcLines)
C_COLLECTION:C1488($vcOneLine)
C_COLLECTION:C1488($vcHeaders)
C_COLLECTION:C1488($vcOutPut)
$vcOutPut:=New collection:C1472
C_OBJECT:C1216($voOutPut)
C_OBJECT:C1216($voLine)
$voOutPut:=New object:C1471
C_TEXT:C284($vtLineData)
$vcLines:=New collection:C1472
$vcLines:=Split string:C1554($vtCatalog; "\r"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
$cnt:=$vcLines.length
C_TEXT:C284($vtCatalog; $vtCatagory)
ARRAY TEXT:C222($aPageValues; 0)
ARRAY TEXT:C222($aLines; 0)
ARRAY TEXT:C222($aValues; 0)
ARRAY TEXT:C222($aHeaders; 0)
C_TEXT:C284($vtHeaders; $vtHeadElement)
C_LONGINT:C283($viInc; $incValue; $cntValue; $cntHeader)
$viInc:=0
For each ($vtLineData; $vcLines)
	$viInc:=$viInc+1
	$voLine:=New object:C1471
	$vcOneLine:=New collection:C1472
	$vtLineData:=Replace string:C233($vtLineData; "\"\""; "&&inch")
	$vtLineData:=Replace string:C233($vtLineData; "\""; "")
	$vtLineData:=Replace string:C233($vtLineData; "&&inch"; "\"")
	If ($viInc<4)
		$vcOneLine:=Split string:C1554($vtLineData; "\t"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	Else 
		$vcOneLine:=Split string:C1554($vtLineData; "\t")
	End if 
	$vtLineData:=$vcOneLine.join(";")
	Case of 
		: ($vcOneLine.length=0)
			// skip
		: ($vcOneLine.length=1)
			$vtHeaders:=$vcOneLine.pop()
			APPEND TO ARRAY:C911($aPageValues; $vtHeaders)
			If (Size of array:C274($aPageValues)=1)
				$voLine.catalog:=$vtHeaders
				$vtCatalog:=$vtHeaders
			Else 
				If (Size of array:C274($aPageValues)=2)
					$voLine.catagory:=$vtHeaders
					$vtCatagory:=$vtHeaders
				Else 
					$voLine["page_"+String:C10($viInc)]:=$vtHeaders
				End if 
			End if 
			$voLine["page_"+String:C10($viInc)]:=$vtHeaders
			$vcOutPut.push($voLine)
		: ($vcOneLine[1]="@Inventory ID@")
			COLLECTION TO ARRAY:C1562($vcOneLine; $aHeaders)
			$cntHeader:=Size of array:C274($aHeaders)
			$vtHeaders:=$vcOneLine.join(";")
			$voLine.headers:=$vtHeaders
			$vcHeaders:=$vcOneLine.copy()
			$vcOutPut.push($voLine)
		Else 
			COLLECTION TO ARRAY:C1562($vcOneLine; $aValues)
			$cntValue:=Size of array:C274($aValues)
			If ($cntHeader#$cntValue)
				$voLine.statusConnect:=$vtLineData
			Else 
				For ($incValue; 1; $cntValue)
					$voLine[$aHeaders{$incValue}]:=$aValues{$incValue}
				End for 
				Cat_UpdateItem($voLine; $vtCatalog; $vtCatagory)
			End if 
			
			$vcOutPut.push($voLine)
	End case 
End for each 
$3[$vtFileName]:=$vcOutPut





