//%attributes = {"publishedWeb":true}
//Procedure: SH_FillRays
C_LONGINT:C283($i; $2; $3)  //
Case of 
	: (($1=0) | ($1>0))  //unusual usage
		ARRAY LONGINT:C221(aTmpLong1; $1)  //doc id
		ARRAY LONGINT:C221(aTmpLong2; $1)  //doc id
		ARRAY TEXT:C222(aText1; $1)  //1st letter of account code
		ARRAY TEXT:C222(aCustomers; $1)
		ARRAY TEXT:C222(aCustAcct; $1)
		ARRAY TEXT:C222(aCustRep; $1)
		ARRAY TEXT:C222(aCustSales; $1)
		ARRAY TEXT:C222(aQueryFieldNames; $1)  //[Customer]City
		ARRAY TEXT:C222(aText2; $1)  //Country
		ARRAY TEXT:C222(aPartNum; $1)
		ARRAY TEXT:C222(aPartDesc; $1)
		ARRAY TEXT:C222(aText3; $1)  //Model
		ARRAY TEXT:C222(aText4; $1)  // Group
		ARRAY REAL:C219(aQtyNact; $1)  //Qty
		ARRAY REAL:C219(aSaleNact; $1)  //Sales
		ARRAY TEXT:C222(aTmp20Str1; $1)  //FOB site may be needed
		ARRAY TEXT:C222(aTmp20Str2; $1)  //FOB site may be needed
		ARRAY TEXT:C222(aTmp20Str3; $1)  //FOB site may be needed
		ARRAY REAL:C219(aInvNact; $1)  //Net Sales
		ARRAY REAL:C219(aScpNPlan; $1)  //FOB diff
		ARRAY REAL:C219(aScpNact; $1)  //Hidden Frght  
		//   
	: ($1=-3)
		INSERT IN ARRAY:C227(aTmpLong1; $2; $3)  //doc id
		INSERT IN ARRAY:C227(aTmpLong2; $2; $3)  //doc id
		INSERT IN ARRAY:C227(aText1; $2; $3)  //1st letter of account code
		INSERT IN ARRAY:C227(aCustomers; $2; $3)
		INSERT IN ARRAY:C227(aCustAcct; $2; $3)
		INSERT IN ARRAY:C227(aCustRep; $2; $3)
		INSERT IN ARRAY:C227(aCustSales; $2; $3)
		INSERT IN ARRAY:C227(aQueryFieldNames; $2; $3)  // city
		INSERT IN ARRAY:C227(aText2; $2; $3)  //Country
		INSERT IN ARRAY:C227(aPartNum; $2; $3)
		INSERT IN ARRAY:C227(aPartDesc; $2; $3)
		INSERT IN ARRAY:C227(aText3; $2; $3)  //Model
		INSERT IN ARRAY:C227(aText4; $2; $3)  // Group
		INSERT IN ARRAY:C227(aQtyNact; $2; $3)  //Qty
		INSERT IN ARRAY:C227(aSaleNact; $2; $3)  //Sales
		INSERT IN ARRAY:C227(aTmp20Str1; $2; $3)  //FOB site may be needed
		INSERT IN ARRAY:C227(aTmp20Str2; $2; $3)  //FOB site may be needed
		INSERT IN ARRAY:C227(aTmp20Str3; $2; $3)  //FOB site may be needed
		INSERT IN ARRAY:C227(aInvNact; $2; $3)  //Net Sales
		INSERT IN ARRAY:C227(aScpNPlan; $2; $3)  //FOB diff
		INSERT IN ARRAY:C227(aScpNact; $2; $3)  //Hidden Frght
	: ($1=-7)
		If (Size of array:C274(aText3)>0)
			Case of 
				: ($2=1)  //sort for Model report          
					COPY ARRAY:C226(aText1; aText5)
					COPY ARRAY:C226(aText3; aText6)
					
					MULTI SORT ARRAY:C718(aText1; >; aText3; >; aCustRep; aCustSales; aCustomers; aTmpLong1; aCustAcct; aCustSales; aText2; aPartNum; aText4; aQtyNact; aSaleNact; aInvNact; aScpNPlan; aScpNact; aTmp20Str1; aTmp20Str2; aTmp20Str3; aPartDesc)
					$i:=0
					ARRAY TEXT:C222(aText5; 0)
					ARRAY TEXT:C222(aText6; 0)
				: ($2=2)  //sort for Sales Name or Rep Name Report
					If (Size of array:C274(aText3)>0)
						OK:=0
						If ((vlDtEnd-vlDtStart)=86399)
							C_TEXT:C284($rptName)
							$rptName:="dailyRepID"
						Else 
							$rptName:=Request:C163("Enter the type of Report")
						End if 
						If ((Is macOS:C1572) & (Ok=1))
							COPY ARRAY:C226(aText1; aText5)
							COPY ARRAY:C226(aCustRep; aTmp25Str1)
							MULTI SORT ARRAY:C718(aText1; >; aCustRep; >; aText3; aCustSales; aCustomers; aTmpLong1; aCustAcct; aCustSales; aText2; aPartNum; aText4; aQtyNact; aSaleNact; aInvNact; aScpNPlan; aScpNact; aTmp20Str1; aTmp20Str2; aTmp20Str3; aPartDesc)
							ARRAY TEXT:C222(aText5; 0)
							ARRAY TEXT:C222(aTmp25Str1; 0)
							
						End if 
					End if 
			End case 
		End if 
End case 