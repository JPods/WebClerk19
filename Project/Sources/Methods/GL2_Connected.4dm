//%attributes = {"publishedWeb":true}
// Modified by: Bill James (2022-01-13T06:00:00Z)
// Method: GL2_Connected
// Description 
// Parameters
// ----------------------------------------------------

// MustFixQQQZZZ: Bill James (2022-01-13T06:00:00Z)
// Test this


GL_PostConnected(->[SalesJournal:50])
GL_PostConnected(->[CashJournal:52])
If (Not:C34(GL_PJrInsightDf))  //Re-using the Insight toggle here, two toggles would be redundant
	GL_PostConnected(->[PurchaseJournal:51])
Else 
	GL2_ConnectedPJ
End if 


