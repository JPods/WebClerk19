C_LONGINT:C283(bdCash)
TRACE:C157
//GOTO RECORD([Invoice];aInvRecs{aInvSelRec{1}})
QUERY:C277([DCash:62]; [DCash:62]customerIDApply:1=[Customer:2]customerID:1; *)
QUERY:C277([DCash:62];  | [DCash:62]customerIDReceive:7=[Customer:2]customerID:1)
ProcessTableOpen(Table:C252(->[DCash:62])*-1)