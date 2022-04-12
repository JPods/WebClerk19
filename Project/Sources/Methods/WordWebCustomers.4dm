//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-16T00:00:00, 10:34:13
// ----------------------------------------------------
// Method: WordWebCustomers
// Description
// Modified: 12/16/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
// KeywordsCustomers Webscript 
// Name: KeywordsCustomers
// Purpose:Webscript
// DAte:20151104
// Notes:
// 11/04/2015 14:31 - removed filter for date retired

C_LONGINT:C283($1)
Case of 
	: ($1=(Table:C252(->[Customer:2])))
		ARRAY TEXT:C222(aText1; 0)
		vText:=variable1
		
		TextToArray(vText; ->aText1; " "; False:C215)
		
		vi2:=Size of array:C274(aText1)
		
		//ALERT(String(vi2))
		
		For (vi1; 1; vi2)
			
			vtValue:=aText1{vi1}
			vtContains:="@"+aText1{vi1}+"@"
			vtBegins:=aText1{vi1}+"@"
			QUERY:C277([Customer:2]; [Customer:2]company:2%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]customerID:1%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]address1:4%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]nameFirst:73%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]nameLast:23%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]address2:5%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]city:6%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]state:7%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]zip:8%vtBegins; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]country:9%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]phone:13%vtBegins; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]email:81%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]need:21%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]profile1:26%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]profile2:27%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]profile3:28%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]profile4:29%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]profile5:30%vtValue; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]typeSale:18%vtBegins; *)
			QUERY:C277([Customer:2];  | ; [Customer:2]salesNameID:59%vtValue; *)
			// QUERY([Customer]; & ;[Customer]DateRetired=!00/00/00!;*)
			QUERY:C277([Customer:2])
			
			vtSet:="Customer"+String:C10(vi1)
			CREATE SET:C116([Customer:2]; vtSet)
		End for 
		
		vtSet1:="Customers1"
		For (vi1; 2; vi2)
			vtSet2:="Customer"+String:C10(vi1)
			INTERSECTION:C121(vtSet1; vtSet2; vtSet1)
			CLEAR SET:C117(vtSet2)
		End for 
		
		USE SET:C118(vtSet1)
		CLEAR SET:C117(vtSet1)
		
	: ($1=(Table:C252(->[Contact:13])))
		// KeywordsContacts Webscript 20151104
		// Name: KeywordsCustomers
		// Purpose:Webscript
		// DAte:20151104
		// Notes:
		// 11/04/2015 14:31 - removed filter for date retired
		
		
		// variable1:=Request("Enter Keywords";"")
		
		ARRAY TEXT:C222(aText1; 0)
		vText:=variable1
		
		TextToArray(vText; ->aText1; " "; False:C215)
		
		vi2:=Size of array:C274(aText1)
		
		//ALERT(String(vi2))
		
		For (vi1; 1; vi2)
			
			vtKeyword:=aText1{vi1}
			vtContains:="@"+aText1{vi1}+"@"
			vtBegins:=aText1{vi1}+"@"
			QUERY:C277([Contact:13]; [Contact:13]company:23%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]customerID:1%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]address1:6%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]address2:7%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]city:8%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]state:9%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]zip:11%vtBegins; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]phone:30%vtBegins; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]email:35%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]nameFirst:2%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]nameLast:4%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]profile1:18%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]profile2:19%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]profile3:20%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]profile4:21%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]profile5:22%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]salesNameID:39%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]repID:45%vtKeyword; *)
			QUERY:C277([Contact:13];  | ; [Contact:13]keyText:14%vtKeyword; *)
			// QUERY([Contact]; & ;[Contact]DateRetired=!00/00/00!;*)
			QUERY:C277([Contact:13])
			
			vtSet:="Contact"+String:C10(vi1)
			CREATE SET:C116([Contact:13]; vtSet)
		End for 
		
		vtSet1:="Contacts1"
		For (vi1; 2; vi2)
			vtSet2:="Contact"+String:C10(vi1)
			INTERSECTION:C121(vtSet1; vtSet2; vtSet1)
			CLEAR SET:C117(vtSet2)
		End for 
		
		USE SET:C118(vtSet1)
		CLEAR SET:C117(vtSet1)
		
End case 