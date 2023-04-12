//%attributes = {"publishedWeb":true}
//Procedure: CallRpt_ByDate
jBetweenDates("Period for listing Call Reports.")
If (OK=1)
	//  C_LONGINT($callBegin;$callEnd)  
	//$callBegin:=DateTime_DTTo (vdDateBeg)
	//$callEnd:=DateTime_DTTo (vdDateEnd;23:59:59)
	QUERY:C277([Call:34]; [Call:34]dateDocument:17>=vdDateBeg; *)
	QUERY:C277([Call:34];  & [Call:34]dateDocument:17<=vdDateEnd)
	ProcessTableOpen(->[Call:34])
End if 