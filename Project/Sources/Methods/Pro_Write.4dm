//%attributes = {"publishedWeb":true}
//Procedure: Pro_Write
C_POINTER:C301($1; $FilePtr)
$FilePtr:=$1
C_LONGINT:C283($2; $LongID)
$LongID:=$2
C_TEXT:C284($3; $AlphaID)
$AlphaID:=$3
C_TEXT:C284($4; $Name)
$Name:=$4
C_TEXT:C284($5; $Value)
$Value:=$5
C_TEXT:C284($6; $TextValue)
$TextValue:=$6
C_TEXT:C284($Source)
$Source:=$6
C_LONGINT:C283($7; $LineNum)
$LineNum:=$7
C_LONGINT:C283($8; $Copy)
$Copy:=$8

CREATE RECORD:C68([Profile:59])

[Profile:59]tableName:1:=Table name:C256($FilePtr)
[Profile:59]idNumForeign:2:=$LongID
[Profile:59]idForeign:3:=$AlphaID
[Profile:59]name:4:=$Name
[Profile:59]value:5:=$Value
[Profile:59]textValue:6:=$TextValue
[Profile:59]source:7:=$Source
[Profile:59]lineNum:8:=$LineNum
[Profile:59]copy:10:=$Copy
SAVE RECORD:C53([Profile:59])

//Profile Copy values
//C_Longint(<>ciPrCpyYes)//Always Copy
//C_Longint(<>ciPrCpyNo)//Never Copy
//C_Longint(<>ciPrCpyOnce)//Copy Once, Clone gets <>ciPrCpyNo
//C_Longint(<>ciPrCpyInvc)//Copy only if new record is a Invoice
//C_Longint(<>ciPrCpyOrd)//Copy only if new record is a Order
//C_Longint(<>ciPrCpyPpl)//Copy only if new record is a Propsal
//C_Longint(<>ciPrCpyCust)//Copy only if new record is a Customer