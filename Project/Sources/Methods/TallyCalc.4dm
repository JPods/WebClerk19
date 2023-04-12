//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/08/09, 11:09:13
// ----------------------------------------------------
// Method: TallyCalc
// Description
// 
//
// Parameters
// ----------------------------------------------------

//PPP 19-FORCED
//C_LONGINT($i; $k)
//$k:=Records in selection([TallyChange])
//FIRST RECORD([TallyChange])
//For ($i; 1; $k)
//If (Not(Locked([TallyChange])))
//Field([TallyChange]idAlpha; [TallyChange]fieldNum)->:=Field([TallyChange]idAlpha; [TallyChange]fieldNum)->+[TallyChange]obEntity
//[TallyChange]complete:=True
//SAVE RECORD([TallyChange])
//End if 
//NEXT RECORD([TallyChange])
//End for 
//UNLOAD RECORD([TallyChange])