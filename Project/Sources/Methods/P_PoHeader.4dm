//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/16/12, 17:14:11
// ----------------------------------------------------
// Method: P_PoHeader
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283(vPageCurrent)
C_LONGINT:C283(vPagesTotal)
If (vPageCurrent>0)
	vPageCurrent:=vPageCurrent+1
Else 
	vPrintBodyCounter:=0
	vPageCurrent:=1
	P_InitPrintCnt
	//ALERT("OrderNum "+String([Order]OrderNum)+" RecNum: "+String(Record number([Order]))+" vLongCnt: "+String(vLongCnt)+" aPrntRecs: "+String(aPrntRecs{vLongCnt}))
	P_ClearVars  //### jwm ### 20120920_0914  added from CE2010zjn
	If (ptCurTable=(->[UserReport:46]))
		P_SetBodyCount
	End if 
	P_PoHeadVars
	// Modified by: William James (2013-07-29T00:00:00)
End if 

