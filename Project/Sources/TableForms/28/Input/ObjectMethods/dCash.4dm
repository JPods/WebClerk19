// gkgkgk  both
QUERY:C277([DCash:62]; [DCash:62]docApply:3=[Payment:28]idNum:8; *)
QUERY:C277([DCash:62];  & [DCash:62]tableApply:2=Table:C252(->[Payment:28]))
CREATE SET:C116([DCash:62]; "Current")

QUERY:C277([DCash:62]; [DCash:62]docReceive:4=[Payment:28]idNum:8; *)
QUERY:C277([DCash:62];  & [DCash:62]tableReceive:8=Table:C252(->[Payment:28]))
ADD TO SET:C119([DCash:62]; "Current")
USE SET:C118("Current")
CLEAR SET:C117("Current")

DB_ShowCurrentSelection(->[DCash:62]; ""; 2)  // no script, unload record
