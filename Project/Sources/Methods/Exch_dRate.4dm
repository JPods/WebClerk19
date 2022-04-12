//%attributes = {"publishedWeb":true}
//Procedure: Exch_dRate
C_POINTER:C301($1; $2)
Case of 
	: ($1->="")  //[Invoice]Currency
		$2->:=0  //[Invoice]ExchangeRate
		ALERT:C41("Set Currency")
	: (strCurrency#<>tcMONEYCHAR)
		ALERT:C41("Display in Base Currency before changing.")
End case 