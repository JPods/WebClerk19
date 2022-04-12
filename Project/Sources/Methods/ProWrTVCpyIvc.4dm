//%attributes = {"publishedWeb":true}
//Procedure: ProWrTVCpyIvc
//write an current Invoice Text value profile that will always copy
C_TEXT:C284($1; $Name)
$Name:=$1
C_TEXT:C284($2; $TextValue)
$TextValue:=$2
C_TEXT:C284($3; $Source)
$Source:=$3

CREATE RECORD:C68([Profile:59])

[Profile:59]tableNum:1:=Table:C252(->[Invoice:26])
[Profile:59]DocNumID:2:=[Invoice:26]invoiceNum:2
[Profile:59]DocAlphaID:3:=""
[Profile:59]Name:4:=$Name
[Profile:59]Value:5:=Substring:C12($TextValue; 1; 20)
[Profile:59]TextValue:6:=$TextValue
[Profile:59]Source:7:=$Source
[Profile:59]LineNum:8:=0
[Profile:59]Copy:10:=<>ciPrCpyYes
SAVE RECORD:C53([Profile:59])