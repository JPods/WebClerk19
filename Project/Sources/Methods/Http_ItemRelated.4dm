//%attributes = {"publishedWeb":true}
// Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-16T00:00:00, 00:59:49
// ----------------------------------------------------
// Method: Http_ItemRelated
// Description
// Modified: 12/16/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)
// what is this used for zzzzz  qqqqq
// There does not seem to be a result Query([TableName])
TRACE:C157
C_LONGINT:C283($1; $whatNumer)
C_TEXT:C284($2)
If ([Item:4]itemNum:1#"")
	
	Item_GetSpec(0)
	//
	C_TEXT:C284(vItemRelated)
	vItemRelated:=""
	C_LONGINT:C283($i; $k; $cntFiles; $cntFields; $err; $selectTable)
	
	Case of 
		: ($selectTable=Table:C252(->[TechNote:58]))
			TechNotesFor("")
			//End if 
			$doQuery:=False:C215
			//                    
		: ($selectTable=Table:C252(->[Forum:80]))
			QUERY:C277([Forum:80]; [Forum:80]Publish:7>0; *)
			QUERY:C277([Forum:80];  & [Forum:80]Publish:7<=viEndUserSecurityLevel; *)  //all can read
			QUERY:C277([Forum:80];  & [Forum:80]Subject:1=[Item:4]itemNum:1; *)
			
			//            
		: ($selectTable=Table:C252(->[TallySummary:77]))
			QUERY:C277([TallySummary:77]; [TallySummary:77]Publish:16>0; *)
			QUERY:C277([TallySummary:77];  & [TallySummary:77]Publish:16<=viEndUserSecurityLevel; *)
			If ($whatNumer>0)
				QUERY:C277([TallySummary:77];  & [TallySummary:77]ItemNum:15=[Item:4]itemNum:1; *)
			End if 
			//
		: ($selectTable=Table:C252(->[TallyResult:73]))
			QUERY:C277([TallyResult:73]; [TallyResult:73]Publish:36>0; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]Publish:36<=viEndUserSecurityLevel; *)
			If ($whatNumer>0)
				QUERY:C277([TallyResult:73];  & [TallyResult:73]ItemNum:34=[Item:4]itemNum:1; *)
			End if 
			//        
		: ($selectTable=Table:C252(->[WOTemplate:69]))
			QUERY:C277([WOTemplate:69]; [WOTemplate:69]Publish:12>0; *)
			QUERY:C277([WOTemplate:69];  & [WOTemplate:69]Publish:12<=viEndUserSecurityLevel; *)
			If ($whatNumer>0)
				QUERY:C277([WOTemplate:69];  & [WOTemplate:69]ItemNum:1=[Item:4]itemNum:1; *)
			End if 
			If (Records in selection:C76([WOTemplate:69])>0)
				ORDER BY:C49([WOTemplate:69]; [WOTemplate:69]Sequence:11)
			End if 
			//
		: ($selectTable=Table:C252(->[TallyMaster:60]))
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]Publish:25>0; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Publish:25<=viEndUserSecurityLevel; *)
			If ($whatNumer>0)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]AlphaKey:26=[Item:4]itemNum:1; *)
			End if 
			//
		: ($selectTable=Table:C252(->[ItemXRef:22]))
			QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumMaster:1=[Item:4]itemNum:1; *)
			If ([Item:4]specId:62#"")
				QUERY:C277([ItemXRef:22];  | [ItemXRef:22]ItemNumMaster:1=[Item:4]specId:62; *)
			End if 
			QUERY:C277([ItemXRef:22];  & [ItemXRef:22]XRefLinked:17=1; *)
			QUERY:C277([ItemXRef:22];  & [ItemXRef:22]Publish:19>0; *)
			QUERY:C277([ItemXRef:22];  & [ItemXRef:22]Publish:19<=viEndUserSecurityLevel)
			If (Records in selection:C76([ItemXRef:22])>1)
				ORDER BY:C49([ItemXRef:22]; [ItemXRef:22]Sequence:24)
			End if 
			$doQuery:=False:C215
		: ($selectTable=Table:C252(->[Map:84]))
			
			//  QUERY([Map];[Map]TableNum=Table(->[Item]);*)
			
			If (Records in selection:C76([Map:84])=1)
				vText4:=[Map:84]HTMLTag:2
				UNLOAD RECORD:C212([Map:84])
			End if 
	End case 
	////UNLOAD RECORD(Table($selectTable)->) //do in itemList procedure
	vText4:=TagsToText(vText4)
	vItemRelated:=vItemRelated+"<BR>"+vText4
	
End if 
