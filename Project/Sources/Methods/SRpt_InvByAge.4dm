//%attributes = {"publishedWeb":true}
//Procedure: SRpt_InvByAge
//returns to variables vR1, 2, 3 & 4 the unpaid value in period
C_DATE:C307($90Ago; $60Ago; $30Ago)
$90Ago:=Current date:C33-89
$60Ago:=Current date:C33-59
$30Ago:=Current date:C33-29
QUERY:C277([Invoice:26]; [Invoice:26]customerid:3=[Customer:2]customerID:1; *)
QUERY:C277([Invoice:26];  & [Invoice:26]datePaid:26=!00-00-00!; *)
QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld-><$90Ago)
vR1:=Sum:C1([Invoice:26]balanceDue:44)
QUERY:C277([Invoice:26]; [Invoice:26]customerid:3=[Customer:2]customerID:1; *)
QUERY:C277([Invoice:26];  & [Invoice:26]datePaid:26=!00-00-00!; *)
QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld->>=($90Ago); *)
QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld-><$60Ago)
vR2:=Sum:C1([Invoice:26]balanceDue:44)
QUERY:C277([Invoice:26]; [Invoice:26]customerid:3=[Customer:2]customerID:1; *)
QUERY:C277([Invoice:26];  & [Invoice:26]datePaid:26=!00-00-00!; *)
QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld->>=$60Ago; *)
QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld-><$30Ago)
vR3:=Sum:C1([Invoice:26]balanceDue:44)
QUERY:C277([Invoice:26]; [Invoice:26]customerid:3=[Customer:2]customerID:1; *)
QUERY:C277([Invoice:26];  & [Invoice:26]datePaid:26=!00-00-00!; *)
QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld->>=$30Ago; *)
QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld-><=Current date:C33)
vR4:=Sum:C1([Invoice:26]balanceDue:44)