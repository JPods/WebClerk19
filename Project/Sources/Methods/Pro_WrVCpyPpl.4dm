//%attributes = {"publishedWeb":true}
//Procedure: Pro_WrVCpyPpl
//write an current Proposal value profile that will always copy
C_TEXT:C284($1; $Name)
$Name:=$1
C_TEXT:C284($2; $Value)
$Value:=$2
C_TEXT:C284($3; $Source)
$Source:=$3

CREATE RECORD:C68([Profile:59])

[Profile:59]tableName:1:=Table name:C256(->[Proposal:42])
[Profile:59]idNumForeign:2:=[Proposal:42]idNum:5
[Profile:59]idForeign:3:=""
[Profile:59]name:4:=$Name
[Profile:59]value:5:=$Value
[Profile:59]textValue:6:=$Value
[Profile:59]source:7:=$Source
[Profile:59]lineNum:8:=0
[Profile:59]copy:10:=<>ciPrCpyYes
SAVE RECORD:C53([Profile:59])