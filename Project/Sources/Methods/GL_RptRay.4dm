//%attributes = {"publishedWeb":true}
//Procedure: GL_RptRay
C_LONGINT:C283($1; $4; $k)
C_TEXT:C284($2; $3; $5)
C_REAL:C285($6; $7)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(<>aRptCustKey; 0)
		ARRAY TEXT:C222(<>aRptCust; 0)
		ARRAY LONGINT:C221(<>aRptInvNum; 0)
		ARRAY TEXT:C222(<>aRptAcct; 0)
		ARRAY REAL:C219(<>aRptDebit; 0)
		ARRAY REAL:C219(<>aRptCredit; 0)
	: ($1=-3)
		$k:=Size of array:C274(<>aRptInvNum)+1
		INSERT IN ARRAY:C227(<>aRptCustKey; $k; 1)
		INSERT IN ARRAY:C227(<>aRptCust; $k; 1)
		INSERT IN ARRAY:C227(<>aRptInvNum; $k; 1)
		INSERT IN ARRAY:C227(<>aRptAcct; $k; 1)
		INSERT IN ARRAY:C227(<>aRptDebit; $k; 1)
		INSERT IN ARRAY:C227(<>aRptCredit; $k; 1)
		<>aRptCustKey{$k}:=$2
		<>aRptCust{$k}:=$3
		<>aRptInvNum{$k}:=$4
		<>aRptAcct{$k}:=$5
		<>aRptDebit{$k}:=$6
		<>aRptCredit{$k}:=$7
End case 