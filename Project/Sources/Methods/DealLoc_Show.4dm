//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2021-12-10T06:00:00Z)
// Method: DealLoc_Show
// Description 
// Parameters
// ----------------------------------------------------


QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="DealerLocator")
READ WRITE:C146([TallyResult:73])
ProcessTableOpen(->[TallyResult:73])
READ ONLY:C145([TallyResult:73])