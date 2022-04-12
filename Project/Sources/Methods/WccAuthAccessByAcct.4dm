//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WccAuthAccessByAcct
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 
Case of 
	: (vWccTableNum=(Table:C252(->[Employee:19])))
		GOTO RECORD:C242([Employee:19]; vWccPrimeRec)
	: (vWccTableNum=(Table:C252(->[Rep:8])))
		GOTO RECORD:C242([Rep:8]; vWccPrimeRec)
End case 
C_POINTER:C301($1; $2)
Case of 
	: (vWccSecurity>4999)
	: (vWccTableNum=111)
		//allow universal query of customers
	: (vWccTableNum=8)
		QUERY:C277($1->;  & $2->=[Rep:8]repID:1; *)
	: (vWccTableNum=19)
		QUERY:C277($1->;  & $3->=[Employee:19]nameid:1; *)
	Else 
		QUERY:C277($1->;  & $3->="as534awe t&^wesd"; *)
End case   //
//