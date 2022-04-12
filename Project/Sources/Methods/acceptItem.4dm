//%attributes = {"publishedWeb":true}
//If ((<>tcMONEYCHAR#strCurrency)&(vRLo1#0)&(<>tcMONEYCHAR#""))
//strCurrency:=<>tcMONEYCHAR
//[Item]PriceA:=Round([Item]PriceA/vRLo1;viExConPrec)
//[Item]PriceB:=Round([Item]PriceA/vRLo1;viExConPrec)
//[Item]PriceC:=Round([Item]PriceA/vRLo1;viExConPrec)
//[Item]PriceD:=Round([Item]PriceA/vRLo1;viExConPrec)
//[Item]CostLastInShip:=Round([Item]PriceA/vRLo1;viExConPrec)
//End if 

// ### bj ### 20201013_1822
If ([Item:4]costMSC:110=0)  // fix legacy
	[Item:4]costMSC:110:=[Item:4]costLastInShip:47
End if 
If ([Item:4]specification:42)
	SAVE RECORD:C53([ItemSpec:31])
End if 
