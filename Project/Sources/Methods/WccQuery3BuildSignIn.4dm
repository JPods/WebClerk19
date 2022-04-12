//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/28/08, 15:41:12
// ----------------------------------------------------
// Method: WccQuery3BuildSignIn
// Description
// 
//
// Parameters
//sendURL:=WccQuery3BuildSignIn(->[Invoice];->[Customer];1)
// ----------------------------------------------------

C_TEXT:C284($0)
C_POINTER:C301($1; $2)
C_LONGINT:C283($3)
If (Count parameters:C259>1)
	$numTable:=Table:C252($1)
	$tableName:=Table name:C256($numTable)
	//
	C_LONGINT:C283($protectedFieldNum)
	$protectedFieldNum:=STR_GetUniqueFieldNum(Table name:C256($numTable))
	C_LONGINT:C283(iLoInteger3; iLoInteger4; iLoInteger5)
	IEA_SuperiorField($1; $2; ->iLoInteger3; ->iLoInteger4; ->iLoInteger5)
	If (iLoInteger3>0)
		If ($protectedFieldNum>0)
			$value2:=Tag2Value($numTable; String:C10($protectedFieldNum); 1)
			If (iLoInteger4<1)
				$0:="http://"+Storage:C1525.default.domain+"/SignIn.html?PendingSignIn&TableName="+$tableName+"&QueryField1="+Field name:C257($numTable; iLoInteger3)+"&QueryValue1=accountID&QueryOperator1=literal&QueryField2="+Field name:C257($numTable; $protectedFieldNum)+"&QueryValue2="+$value2+"&QueryOperator2=literal&jitPageOne="+$tableName+"One.html"
			Else 
				$value3:=Tag2Value($numTable; String:C10(iLoInteger4); 1)
				$0:="http://"+Storage:C1525.default.domain+"/SignIn.html?PendingSignIn&TableName="+$tableName+"&QueryField1="+Field name:C257($numTable; iLoInteger3)+"&QueryValue1=accountID&QueryOperator1=literal&QueryField2="+Field name:C257($numTable; $protectedFieldNum)+"&QueryValue2="+String:C10(Field:C253($numTable; $protectedFieldNum))+"&QueryOperator2=literal&QueryField3="+Field name:C257($numTable; iLoInteger4)+"&QueryValue3="+$value3+"&QueryOperator3=literal&jitPageOne="+$tableName+"One.html"
			End if 
		End if 
		If (Count parameters:C259=3)
			If ($3=1)
				SET TEXT TO PASTEBOARD:C523($0)
			End if 
		End if 
	Else 
		$0:=$tableName+" not supported."
	End if 
	If (Count parameters:C259=3)
		If ($3=1)
			SET TEXT TO PASTEBOARD:C523($0)
		End if 
	End if 
End if 