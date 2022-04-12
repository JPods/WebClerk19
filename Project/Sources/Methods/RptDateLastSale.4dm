//%attributes = {"publishedWeb":true}
jBetweenDates("Enter Period for Date of Last Sale.")
If (OK=1)
	QUERY:C277([Customer:2]; [Customer:2]lastSaleDate:49>=vdDateBeg; *)
	QUERY:C277([Customer:2];  & [Customer:2]lastSaleDate:49<=vdDateEnd)
	ORDER BY:C49([Customer:2]lastSaleDate:49; >; [Customer:2]repID:58; >)
	booSorted:=True:C214
	ProcessTableOpen(->[Customer:2])
End if 