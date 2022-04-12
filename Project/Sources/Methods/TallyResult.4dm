//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
C_LONGINT:C283($2; $3)
CREATE RECORD:C68([TallyResult:73])

[TallyResult:73]Name:1:=$1
[TallyResult:73]tableNum:3:=$2
[TallyResult:73]fieldNum:4:=$3
[TallyResult:73]Purpose:2:=$4
[TallyResult:73]Real1:13:=$5
[TallyResult:73]Real2:14:=$6
SAVE RECORD:C53([TallyResult:73])
UNLOAD RECORD:C212([TallyResult:73])