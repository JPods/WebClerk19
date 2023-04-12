//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
C_LONGINT:C283($2; $3)
CREATE RECORD:C68([TallyResult:73])

[TallyResult:73]name:1:=$1
[TallyResult:73]tableNum:3:=$2
// Modified by: Bill James (2022-12-09T06:00:00Z)
// mush fix and adjust to data type and object
//[TallyResult]data:=$3
[TallyResult:73]purpose:2:=$4
[TallyResult:73]real1:13:=$5
[TallyResult:73]real2:14:=$6
SAVE RECORD:C53([TallyResult:73])
UNLOAD RECORD:C212([TallyResult:73])