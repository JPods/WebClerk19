If (False:C215)
	//Method:
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
//array TEXT(aTmp20Str1;5)
//aTmp20Str1{1}:="Action"
//aTmp20Str1{2}:="Find Item"
//aTmp20Str1{3}:="Find Order"
//aTmp20Str1{4}:="Find Package"
//aTmp20Str1{5}:="Find Invoice"
$tempStr:=vsBarCdFld
If ((vsBarCdFld#"") & (aTmp20Str1>1))
	Case of 
		: (aTmp20Str1=2)  //find item
			//already OK
			
		: (aTmp20Str1=3)  //find order
			vsBarCdFld:="{"+vsBarCdFld
			
		: (aTmp20Str1=4)  //find package
			vsBarCdFld:="("+vsBarCdFld
			
		: (aTmp20Str1=5)  //find invoice
			vsBarCdFld:="}"+vsBarCdFld
			
		: (aTmp20Str1=6)  //find script
			vsBarCdFld:=")"+vsBarCdFld
			
	End case 
	
	PKBarCodeReceive
	vsBarCdFld:=$tempStr
	
End if 
aTmp20Str1:=1