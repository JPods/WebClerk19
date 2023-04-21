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

[Profile:59]tableName:1:=Table name:C256(->[Invoice:26])
[Profile:59]idNumForeign:2:=[Invoice:26]idNum:2
[Profile:59]idForeign:3:=""
[Profile:59]name:4:=$Name
[Profile:59]value:5:=Substring:C12($TextValue; 1; 20)
[Profile:59]textValue:6:=$TextValue
[Profile:59]source:7:=$Source
[Profile:59]lineNum:8:=0
[Profile:59]copy:10:=<>ciPrCpyYes
SAVE RECORD:C53([Profile:59])