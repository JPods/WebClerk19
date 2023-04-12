//%attributes = {"publishedWeb":true}
//C_LONGINT($1; $2; $4)
//C_TEXT($3)
//C_REAL($5)
//CREATE RECORD([TallyChange])
//PPP 19-FORCED

//[TallyChange]idAlpha:=$1  //File([AdSource])
//[TallyChange]fieldNum:=$2  //Field([AdSource]Value1stInv)
//[TallyChange]obEntity:=$5  //[Invoice]Amount
//[TallyChange]idKey:=$3  //[Invoice]AdSource
//[TallyChange]dtCreated:=DateTime_DTTo
//SAVE RECORD([TallyChange])
//UNLOAD RECORD([TallyChange])