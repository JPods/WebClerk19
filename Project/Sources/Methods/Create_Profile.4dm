//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 10/25/16, 14:05:23
// ----------------------------------------------------
// Method: Add_Profile
// Description
// 
//
// Parameters: tableNum;ID as String,name,value,{seq}
// ----------------------------------------------------

// Add_Profile(tablenum;"ID";"name";"value"{;seq;text})

C_TEXT:C284($name; $value; $alpha; $text)
C_LONGINT:C283($tableNum; $id; $seq)

$tableNum:=$1
$id:=Num:C11($2)
$alpha:=$2
$name:=$3
$value:=$4

If (COUNT PARAMTERS>=5)
	$seq:=$5
End if 

If (COUNT PARAMTERS>=6)
	$text:=$6
End if 

CREATE RECORD:C68([Profile:59])

[Profile:59]tableNum:1:=$tableNum
[Profile:59]DocNumID:2:=$id
[Profile:59]DocAlphaID:3:=$alpha
[Profile:59]Name:4:=$name
[Profile:59]Value:5:=$value
[Profile:59]Seq:11:=$seq
// [Profile]TextValue
SAVE RECORD:C53([Profile:59])
$0:=[Profile:59]idUnique:9
UNLOAD RECORD:C212([Profile:59])

