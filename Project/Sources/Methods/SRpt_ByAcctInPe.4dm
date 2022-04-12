//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2; $3; $4)
//finds related records within a date or value range
//SRpt_ByAcctInPe ([Invoice];[Invoice]AccountKey;[Customer]AccountCode
//;[Invoice]DateInvoiced)
C_DATE:C307($5; $6)
QUERY:C277($1->; $2->=$3->; *)
QUERY:C277($1->;  & $4->>=$5; *)
QUERY:C277($1->;  & $4-><=$6)