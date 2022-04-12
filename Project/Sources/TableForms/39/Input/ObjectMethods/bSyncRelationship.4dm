
// ### bj ### 20200330_1212
QUERY:C277([SyncRelation:103]; [SyncRelation:103]Partner2AccountID:47=[PO:39]vendorId:1; *)
QUERY:C277([SyncRelation:103];  | ; [SyncRelation:103]Partner1AccountID:36=[PO:39]vendorId:1)
If (Records in selection:C76([SyncRelation:103])=0)
	ALERT:C41("There is no defined SyncRelation record.")
Else 
	ProcessTableOpen(Table:C252(->[SyncRelation:103]); ""; "PO "+String:C10([PO:39]poNum:5))
End if 
