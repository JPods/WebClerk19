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

[Profile:59]tableNum:1:=Table:C252(->[Proposal:42])
[Profile:59]DocNumID:2:=[Proposal:42]proposalNum:5
[Profile:59]DocAlphaID:3:=""
[Profile:59]Name:4:=$Name
[Profile:59]Value:5:=$Value
[Profile:59]TextValue:6:=$Value
[Profile:59]Source:7:=$Source
[Profile:59]LineNum:8:=0
[Profile:59]Copy:10:=<>ciPrCpyYes
SAVE RECORD:C53([Profile:59])