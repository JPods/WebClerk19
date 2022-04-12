//%attributes = {}
// ----------------------------------------------------
// User name (OS): Medlen
// Date and time: 2015-12-16T00:00:00, 11:30:54
// ----------------------------------------------------
// Method: WordOrders
// Description
// Modified: 12/16/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// Script KeywordsOrders WebScript 20151211

viContinue:=1
viAllOrders:=1

vtOrderNum:=Preg Replace("[^0-9]"; ""; variable4; Regex Multi Line+Regex Ignore Case)
//Alert("vtOrderNum "+vtOrderNum)
viOrderNum:=Num:C11(vtOrderNum)
If (viOrderNum>0)
	viContinue:=0
	QUERY:C277([Order:3]; [Order:3]orderNum:2=viOrderNum; *)
	QUERY:C277([Order:3])
End if 

//name="variable2" id="keywords
//name="variable2" id="dateBegin
//name="variable3" id="dateEnd"
//name="variable4" id="orderNum"

//If you pass an invalid date (such as "13/35/94" or "aa/12/94") in
//dateString, Date returns a null date (!00/00/00!). It is your
//responsibility to verify that dateString is a valid date.

If (viContinue=1)
	
	If ((variable2#"") & (variable3#""))
		vdBegin:=Date:C102(variable2)
		vdEnd:=Date:C102(variable3)
		If ((vdBegin#!00-00-00!) & (vdEnd#!00-00-00!))
			//Alert("vdBegin "+ string(vdBegin)+" vdEnd "+String(vdEnd))
			viAllOrders:=0
			QUERY:C277([Order:3]; [Order:3]dateOrdered:4>=vdBegin; *)
			QUERY:C277([Order:3]; [Order:3]dateOrdered:4<=vdEnd; *)
			QUERY:C277([Order:3])
			CREATE SET:C116([Order:3]; "DateRange")
			//Alert("Records In Selection([Order]) "+ String(Records In Selection([Order])))
		Else 
			vResponse:="Invalid Date"
			ALERT:C41(vResponse)
		End if 
	Else 
		ALL RECORDS:C47([Order:3])
	End if 
	
	
	If (srKeyword#"")
		
		ARRAY TEXT:C222(aText1; 0)
		vText:=srKeyword
		TextToArray(vText; ->aText1; " "; False:C215)
		vi2:=Size of array:C274(aText1)
		
		For (vi1; 1; vi2)
			
			If (viAllOrders=1)
				ALL RECORDS:C47([Order:3])
			Else 
				USE SET:C118("DateRange")
			End if 
			
			vtKeyword:=aText1{vi1}
			vtContains:="@"+aText1{vi1}+"@"
			
			QUERY SELECTION:C341([Order:3]; [Order:3]company:15%vtKeyword; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]address1:16%vtKeyword; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]address2:17%vtKeyword; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]city:18%vtKeyword; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]state:19%vtKeyword; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]zip:20=vtContains; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]phone:67=vtContains; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]email:82%vtKeyword; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]billToCompany:76%vtKeyword; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]billToAddress1:95%vtKeyword; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]billToAddress2:96%vtKeyword; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]billToCity:97%vtKeyword; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]billToState:98%vtKeyword; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]billToZip:99=vtContains; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]billToPhone:93=vtContains; *)
			QUERY SELECTION:C341([Order:3];  | ; [Order:3]billToEmail:101%vtKeyword; *)
			QUERY SELECTION:C341([Order:3])
			
			vtSet:="Order"+String:C10(vi1)
			CREATE SET:C116([Order:3]; vtSet)
		End for 
		
		vtSet1:="Orders1"
		For (vi1; 2; vi2)
			vtSet2:="Order"+String:C10(vi1)
			INTERSECTION:C121(vtSet1; vtSet2; vtSet1)
			CLEAR SET:C117(vtSet2)
		End for 
		
		USE SET:C118(vtSet1)
		CLEAR SET:C117(vtSet1)
	End if   // srKeyword#""
	
End if   // viContinue=1


//If (Records in selection([Order])>0)
//ProcessTableOpen (Table(->[Order]);"";"TEST")
//Else 
//Alert("No Orders Selected")
//End if 
//
