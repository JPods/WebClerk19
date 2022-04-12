//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2; $4)
C_TEXT:C284($3)
C_REAL:C285($5)
CREATE RECORD:C68([TallyChange:65])

[TallyChange:65]fileNum:1:=$1  //File([AdSource])
[TallyChange:65]fieldNum:2:=$2  //Field([AdSource]Value1stInv)
[TallyChange:65]change:5:=$5  //[Invoice]Amount
[TallyChange:65]alphaKey:3:=$3  //[Invoice]AdSource
[TallyChange:65]dtCreated:7:=DateTime_Enter
SAVE RECORD:C53([TallyChange:65])
UNLOAD RECORD:C212([TallyChange:65])