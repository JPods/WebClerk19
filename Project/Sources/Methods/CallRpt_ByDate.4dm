//%attributes = {"publishedWeb":true}
//Procedure: CallRpt_ByDate
jBetweenDates("Period for listing Call Reports.")
If (OK=1)
	//  C_LONGINT($callBegin;$callEnd)  
	//$callBegin:=DateTime_Enter (vdDateBeg)
	//$callEnd:=DateTime_Enter (vdDateEnd;23:59:59)
	QUERY:C277([CallReport:34]; [CallReport:34]dateDocument:17>=vdDateBeg; *)
	QUERY:C277([CallReport:34];  & [CallReport:34]dateDocument:17<=vdDateEnd)
	ProcessTableOpen(->[CallReport:34])
End if 