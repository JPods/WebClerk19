//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
C_TEXT:C284($5)
C_LONGINT:C283($2; $3)
C_DATE:C307($4)
C_REAL:C285($6; $7)
INSERT IN ARRAY:C227(a25Str1; 1; 1)
INSERT IN ARRAY:C227(aLongInt1; 1; 1)
INSERT IN ARRAY:C227(aLongInt2; 1; 1)
INSERT IN ARRAY:C227(aTmp20Str1; 1; 1)  //days old
INSERT IN ARRAY:C227(aTmp20Str2; 1; 1)  //days old
INSERT IN ARRAY:C227(aDate1; 1; 1)
INSERT IN ARRAY:C227(a3Str1; 1; 1)
INSERT IN ARRAY:C227(aReal1; 1; 1)
INSERT IN ARRAY:C227(aReal2; 1; 1)
INSERT IN ARRAY:C227(aReal3; 1; 1)  //current
INSERT IN ARRAY:C227(aReal4; 1; 1)  //past period 1
INSERT IN ARRAY:C227(aReal5; 1; 1)  //past period 2
INSERT IN ARRAY:C227(aReal6; 1; 1)  //past period 3
a25Str1{1}:=$1  //Customer PO Num/Check
aLongInt1{1}:=$2  //Order Key/
aLongInt2{1}:=$3  //InvoiceKey/
aDate1{1}:=$4  //DateShip/Date Pay
a3Str1{1}:=$5  //"Inv"
aReal1{1}:=$6  //Total/PayAmount
aReal2{1}:=$7  //Balance/Amount Avail
aTmp20Str2{1}:=$8  //Terms