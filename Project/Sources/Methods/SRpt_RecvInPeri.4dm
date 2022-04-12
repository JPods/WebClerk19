//%attributes = {"publishedWeb":true}
//Procedure: SRpt_RecvInPeri
//returns to variables vR 1,2,3,4; the value and number of invoices and payments i
C_DATE:C307($dateBeg; $dateEnd)
$dateBeg:=Date:C102(vText1)
$dateEnd:=Date:C102(vText2)
QUERY:C277([Invoice:26]; [Invoice:26]customerid:3=[Customer:2]customerID:1; *)
QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld->>=$dateBeg; *)
QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld-><=$dateEnd)
vR1:=Sum:C1([Invoice:26]amount:14)
vR2:=Records in selection:C76([Invoice:26])
QUERY:C277([Payment:28]; [Payment:28]customerid:4=[Customer:2]customerID:1; *)
QUERY:C277([Payment:28];  & [Payment:28]dateReceived:10>=$dateBeg; *)
QUERY:C277([Payment:28];  & [Payment:28]dateReceived:10<=$dateEnd)
vR3:=Sum:C1([Payment:28]amount:1)
vR4:=Records in selection:C76([Payment:28])