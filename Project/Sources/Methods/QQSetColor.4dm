//%attributes = {}
// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 04/16/10, 09:53:06
// ----------------------------------------------------
// Method: QQSetColor
// Description
// status messages commented out
// 01/09/2013 updated to use Execute On Server
// 02/28/2013 10:35 - create GenericChild1 Defaults if does not exist
// 06/20/2013 15:53 - added threshold for onServer, moved disable sort after decision to use server.
// Parameters
// ----------------------------------------------------
//### jwm ### 20130424_0340 changed default [GenericChild1]Bool01 use onServer to False
//### jwm ### 20130620_1610 moved disable sort after decision to use server
//### jwm ### 20130620_1605 new viThreshold
//### jwm ### 20130620_1610 viThreshold default 50 records
//### jwm ### 20130620_1612 OnServer = TRUE & Records > Threshold

//Script QQSetColor OnServer 20130109

//===================================================
//Client Side Process
//===================================================

//===================================================
//Setup & Initialize Variables, Arrays, User Input
//===================================================
If ($2->#Null:C1517)
	If ((allowAlerts_boo) & (Size of array:C274($2->)>0))
		
		//ARRAY LONGINT (alRecords;0)
		ARRAY TEXT:C222(atColorCode; 0)
		ARRAY TEXT:C222(atItemNum; 0)
		ARRAY LONGINT:C221(aiPrintNot; 0)
		
		C_LONGINT:C283(viReady; viCount; viDelay; viTimeOut)
		C_LONGINT:C283($1)  // the area list
		C_POINTER:C301($2)  // pointer to the Item Number array
		C_LONGINT:C283($i; $k)
		C_LONGINT:C283(<>useJims; viThreshold)
		C_TEXT:C284(vtStatus)
		C_BOOLEAN:C305(vbOnServer)
		
		viReady:=0
		viCount:=0
		QUERY:C277([zzzGenericChild1:90]; [zzzGenericChild1:90]name:3="QQSetColor"; *)
		QUERY:C277([zzzGenericChild1:90];  & ; [zzzGenericChild1:90]purpose:4="Default"; *)
		QUERY:C277([zzzGenericChild1:90])
		If (Records in selection:C76([zzzGenericChild1:90])>0)
			FIRST RECORD:C50([zzzGenericChild1:90])
			viDelay:=[zzzGenericChild1:90]lI01:6
			viTimeOut:=[zzzGenericChild1:90]lI02:7
			viThreshold:=[zzzGenericChild1:90]lI03:8
			vbOnServer:=[zzzGenericChild1:90]bool01:12
			If (Records in selection:C76([zzzGenericChild1:90])>1)
				REDUCE SELECTION:C351([zzzGenericChild1:90]; Records in selection:C76([zzzGenericChild1:90])-1)
				DELETE SELECTION:C66([zzzGenericChild1:90])
			End if 
		Else 
			viDelay:=3  //ticks
			viTimeOut:=200  //3 ticks / 60 * 200 = 10 seconds
			vbOnServer:=True:C214
			//### jwm ### 20130228_1051 create GenericChild1 Defaults if does not exist
			CREATE RECORD:C68([zzzGenericChild1:90])
			
			[zzzGenericChild1:90]a01:40:="LI01 = viDelay"
			[zzzGenericChild1:90]a02:41:="LI02 = viCount"
			[zzzGenericChild1:90]a03:42:="LI03 = viThreshold"  //### jwm ### 20130620_1605
			[zzzGenericChild1:90]a04:43:="Bool1 = OnServer"
			[zzzGenericChild1:90]a05:38:="3 ticks = .05 seconds delay"
			[zzzGenericChild1:90]a06:39:="3 ticks / 60 * 200 = 10 seconds time out"
			[zzzGenericChild1:90]bool01:12:=False:C215  //### jwm ### 20130424_0340 changed default to False
			[zzzGenericChild1:90]d01:24:=Current date:C33
			[zzzGenericChild1:90]lI01:6:=3
			[zzzGenericChild1:90]lI02:7:=120
			[zzzGenericChild1:90]lI03:8:=50  //### jwm ### 20130620_1610
			[zzzGenericChild1:90]name:3:="QQSetColor"
			[zzzGenericChild1:90]purpose:4:="Default"
			[zzzGenericChild1:90]h01:30:=Current time:C178
			SAVE RECORD:C53([zzzGenericChild1:90])
		End if 
		UNLOAD RECORD:C212([zzzGenericChild1:90])
		
		If ((vbOnServer) & (Size of array:C274($2->)>viThreshold))  //### jwm ### 20130620_1612 OnServer = TRUE & Records > Threshold
			
			//### jwm ### 20130620_1610
			//temporarily disable sorting
			// -- AL_SetSortOpts($1; 0; 0; 0; ""; 1; 1)
			//areaRef-AreaList
			//automaticSort-0 do not auto sort
			//userSort-0 disable sort buttons
			//allowSortEditor-0 disable
			//sortEditorPrompt-Optional
			//showSortOrder-1 show sort order in editor
			//showSortDirIndicator-1  show sort direction indicator will be displayed(default)
			
			COPY ARRAY:C226($2->; atItemNum)
			
			If (Count parameters:C259>=3)
				COPY ARRAY:C226($3->; aiPrintNot)
			Else 
				ARRAY LONGINT:C221(aiPrintNot; Size of array:C274(atItemNum))
			End if 
			
			//===================================================
			//Launch Server Side Process, Status Window
			//===================================================
			
			vlProcessID:=Execute on server:C373("QQSetColor_OnServer"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-OnServer"; *)
			vlTestID:=Abs:C99(vlProcessID)
			
			//Open window(100;200;500;300;-1984;"Status")
			//ERASE WINDOW
			//GOTO XY(3;3)
			
			//===================================================
			//Wait for Server Process to be Ready
			//===================================================
			vtStatus:="Wait for Server Process to be Ready"
			While ((viReady=0) & (viCount<viTimeOut))  //timeout = 1/2 hour
				DELAY PROCESS:C323(Current process:C322; viDelay)
				viCount:=viCount+1
				GET PROCESS VARIABLE:C371(-vlTestID; viReady; viReady; vtStatus; vtStatus)
				//If (vtStatus#"")
				//ERASE WINDOW
				//GOTO XY(3;3)
				//MESSAGE(vtStatus)
				//End if 
			End while 
			
			//===================================================
			//server ready, load client variables to server
			//===================================================
			
			//Example for record passing
			//SELECTION TO ARRAY([Customer];alRecords)
			//VARIABLE TO VARIABLE (-vlTestID;alRecords;alRecords)
			
			//pass array of item numbers to server process
			VARIABLE TO VARIABLE:C635(-vlTestID; atItemNum; atItemNum; viDelay; viDelay; viTimeOut; viTimeOut)
			
			//===================================================
			//set ready = 2 Run Server Process
			//===================================================
			viReady:=2
			SET PROCESS VARIABLE:C370(-vlTestID; viReady; viReady)
			DELAY PROCESS:C323(Current process:C322; viDelay)
			
			//===================================================
			//Wait for Server Process to Complete, Display Status
			//===================================================
			vtStatus:="Wait for Server Process to Complete, Display Status"
			While ((viReady<3) & (viCount<viTimeOut))  //timeout = 1/2 hour
				DELAY PROCESS:C323(Current process:C322; viDelay)
				viCount:=viCount+1
				GET PROCESS VARIABLE:C371(-vlTestID; viReady; viReady; vtStatus; vtStatus)
				//If (vtStatus#"")
				//ERASE WINDOW
				//GOTO XY(3;3)
				//MESSAGE(vtStatus)
				//End if 
			End while 
			
			//===================================================
			//Retrieve Results from Server Process
			//===================================================
			//retrieve color codes loaded in text array
			GET PROCESS VARIABLE:C371(-vlTestID; atColorCode; atColorCode)
			
			//Example for record passing
			//Get PROCESS VARIABLE(-vlTestID;alRecords;alRecords)
			//CREATE SET FROM ARRAY ([Customer]; alRecords; "myRecords")
			//Use Set("myRecords")
			
			//===================================================
			//Set Ready = 4 Data Retrieval Complete
			//===================================================
			viReady:=4
			//vtStatus:="retrieving array"
			SET PROCESS VARIABLE:C370(-vlTestID; viReady; viReady)
			
			//Get last Status 
			//GET PROCESS VARIABLE(-vlTestID;viReady;viReady;vtStatus;vtStatus)
			//If (vtStatus#"")
			//ERASE WINDOW
			//GOTO XY(3;3)
			//MESSAGE(vtStatus)
			//DELAY PROCESS(Current process;6)  //1/10 second to allow status update
			//End if 
			
			RESOLVE POINTER:C394($2; $vtVarName; $viTableNum; $viFieldNum)
			
			$k:=Size of array:C274($2->)
			For ($i; 1; $k)
				//###_jwm_### 20101116 have not decided on whether or not to use bold for Out of stock
				//###_jwm_### 20101115 changed red from #990000 to #CC0000 (brighter red)
				Case of 
					: (atColorCode{$i}="1")  // #1 Retired, Qty less than or = zero
						// -- AL_SetRowRGBColor($1; $i; 0x00CC; 0x0000; 0x0000; 0x00FF; 0x00FF; 0x0099)  // red on yellow  
						//// -- AL_SetRowColor ($1;$i;"red";0;"yellow";0)
						//// -- AL_SetRowStyle ($1;$i;1;"")  //bold
					: (atColorCode{$i}="2")  // #2 Retired, Qty greater than zero
						// -- AL_SetRowRGBColor($1; $i; 0x0000; 0x0000; 0x0000; 0x00FF; 0x00FF; 0x0099)  // black on yellow
						//// -- AL_SetRowColor ($1;$i;"black";0;"yellow";0)
						//// -- AL_SetRowStyle ($1;$i;0;"")  //plain
					: (atColorCode{$i}="3")  // #3 Backordered, Qty less than or = zero
						// -- AL_SetRowRGBColor($1; $i; 0x00CC; 0x0000; 0x0000; 0x00DD; 0x00DD; 0x00DD)  // red on light gray
						//// -- AL_SetRowColor ($1;$i;"red";0;"light gray";0)
						//// -- AL_SetRowStyle ($1;$i;1;"")  //bold
					: (atColorCode{$i}="4")  // #4 Backordered, Qty greater than zero
						// -- AL_SetRowRGBColor($1; $i; 0x0000; 0x0000; 0x0000; 0x00DD; 0x00DD; 0x00DD)  // black on light gray
						//// -- AL_SetRowColor ($1;$i;"black";0;"light gray";0)
						//// -- AL_SetRowStyle ($1;$i;0;"")  //plain
					: (atColorCode{$i}="5")  // #5 Qty less than or = zero
						// -- AL_SetRowRGBColor($1; $i; 0x00CC; 0x0000; 0x0000; 0x00FF; 0x00FF; 0x00FF)  //red on white
						//// -- AL_SetRowColor ($1;$i;"red";0;"white";0)
						//// -- AL_SetRowStyle ($1;$i;1;"")  //bold
						
						// ### jwm ### 20141216_1441 Line Complete font = gray
						// how do we universally test for complete ???
						// Alternate method ???
						// // -- AL_SetRowTextProperty ($1;$i;;ALP_Row_TextColor;"Gray")
						// procedure would need to check "complete" field
						
					: (atColorCode{$i}="6")  // #6 Backordered, Line Complete
						//: (([Item]BackOrder=True) & (aOQtyBL{$i}=0))
						//// -- AL_SetRowColor (eOrdList;$i;"gray";0;"white";0)
						// -- AL_SetRowRGBColor($1; $i; 0x0066; 0x0066; 0x0066; 0x00DD; 0x00DD; 0x00DD)  //gray on light gray
						
					: (atColorCode{$i}="7")  // #7 Retired, Line Complete
						// : (([Item]Retired=True) & (aOQtyBL{$i}=0))
						//// -- AL_SetRowColor (eOrdList;$i;"gray";0;"white";0)
						// -- AL_SetRowRGBColor($1; $i; 0x0066; 0x0066; 0x0066; 0x00FF; 0x00FF; 0x0099)  //gray on yellow
						
					: (atColorCode{$i}="8")  // #8 Credit, Line Complete
						// : ((aOQtyBL{$i}=0) & (aOQtyOrder{$i}<0))
						//// -- AL_SetRowColor (eOrdList;$i;"gray";0;"white";0)
						// -- AL_SetRowRGBColor($1; $i; 0x0066; 0x0066; 0x0066; 0x00FF; 0x00BB; 0x00BB)  //gray on red
						
					: (atColorCode{$i}="9")  // #9 Line Complete
						// : ((aOQtyBL{$i}=0) & (aOQtyOrder{1}>=0))
						//// -- AL_SetRowColor (eOrdList;$i;"gray";0;"white";0)
						// -- AL_SetRowRGBColor($1; $i; 0x0066; 0x0066; 0x0066; 0x00FF; 0x00FF; 0x00FF)  //gray on white
						
					: ($vtVarName="aOItemNum")  // if array name is eOrdlist and printNot is true
						
						If (aoPrintThis{$i}=1)
							// -- AL_SetRowRGBColor($1; $i; 0x00FF; 0x00FF; 0x00FF; 0x0099; 0x0099; 0x0099)  //white on gray
						End if 
						
					Else 
						// -- AL_SetRowColor($1; $i; "black"; 0; "white"; 0)  //default color code
						//// -- AL_SetRowStyle ($1;$i;0;"")  //black on white
				End case 
				
				// // -- AL_SetRowTextProperty ($1;$i;ALP_Row_TextColor;"0xFF666666")
				
			End for 
			
			//  --  CHOPPED  AL_UpdateArrays($1; -2)
			//slight pause after updating list before enabling sorting.
			DELAY PROCESS:C323(Current process:C322; viDelay)
			//enable sorting
			// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1; 1)
			//areaRef-AreaList
			//automaticSort-0 do not auto sort
			//userSort-1 enable sort buttons
			//allowSortEditor-1 enable
			//sortEditorPrompt-Optional
			//showSortOrder-1 show sort order list will be empty whenever the Sort Editor is displayed
			//showSortDirIndicator-1  show sort direction indicator will be displayed
			
			
			//ERASE WINDOW
			//GOTO XY(3;3)
			//MESSAGE("Complete")
			//CLOSE WINDOW
			
			//===================================================
			/////////////////////////////////////////////////////
			//=================================================== 
			
			//###_jwm_### 20100414 begin
		Else   //Old procedure
			
			If (allowAlerts_boo)
				C_LONGINT:C283($1)  // the area list
				C_POINTER:C301($2)  // pointer to the Item Number array
				C_LONGINT:C283($i; $k)
				C_LONGINT:C283(<>useJims)
				If (<>useJims=0)
					<>useJims:=1
				End if 
				If (<>useJims=1)
					
					RESOLVE POINTER:C394($2; $vtVarName; $viTableNum; $viFieldNum)
					$k:=Size of array:C274($2->)
					For ($i; 1; $k)
						QUERY:C277([Item:4]; [Item:4]itemNum:1=$2->{$i})
						//###_jwm_### 20101116 have not decided on whethter or not to use bold for Out of stock
						//###_jwm_### 20101115 changed red from #990000 to #CC0000 (brighter red)
						Case of 
							: (([Item:4]retired:64=True:C214) & ([Item:4]qtyOnHand:14<=0))  //Retired, zero qty or less on-hand
								//// -- AL_SetRowColor ($1;$i;"red";0;"yellow";0)
								// -- AL_SetRowRGBColor($1; $i; 0x00CC; 0x0000; 0x0000; 0x00FF; 0x00FF; 0x0099)  //red on yellow  
								//// -- AL_SetRowStyle ($1;$i;1;"")  //bold
							: (([Item:4]retired:64=True:C214) & ([Item:4]qtyOnHand:14>0))  //Retired, greater than zero qty or less on-hand
								//// -- AL_SetRowColor ($1;$i;"black";0;"yellow";0)
								// -- AL_SetRowRGBColor($1; $i; 0x0000; 0x0000; 0x0000; 0x00FF; 0x00FF; 0x0099)  //black on yellow
								//// -- AL_SetRowStyle ($1;$i;0;"")  //plain
							: (([Item:4]backOrder:24) & ([Item:4]qtyOnHand:14<=0))  //(aLsDocType{$i}="*") //Backordered, zero qty or less on-hand
								//// -- AL_SetRowColor ($1;$i;"red";0;"light gray";0)
								// -- AL_SetRowRGBColor($1; $i; 0x00CC; 0x0000; 0x0000; 0x00DD; 0x00DD; 0x00DD)  //red on light gray
								//// -- AL_SetRowStyle ($1;$i;1;"")  //bold
							: (([Item:4]backOrder:24) & ([Item:4]qtyOnHand:14>0))  //(aLsDocType{$i}="*") //Backordered, , greater than zero qty or less on-hand
								//// -- AL_SetRowColor ($1;$i;"black";0;"light gray";0)
								// -- AL_SetRowRGBColor($1; $i; 0x0000; 0x0000; 0x0000; 0x00DD; 0x00DD; 0x00DD)  //black on light gray
								//// -- AL_SetRowStyle ($1;$i;0;"")  //plain
							: ([Item:4]qtyOnHand:14<=0)  //(aLsQtyOH{$i}<0)  //Active, zero qty or less on-hand
								//// -- AL_SetRowColor ($1;$i;"red";0;"white";0)
								// -- AL_SetRowRGBColor($1; $i; 0x00CC; 0x0000; 0x0000; 0x00FF; 0x00FF; 0x00FF)  //red on white
								//// -- AL_SetRowStyle ($1;$i;1;"")  //bold
							: ($vtVarName="aOItemNum")
								If (aoPrintThis{$i}=1)  // if array name is eOrdlist and printNot is true
									// -- AL_SetRowRGBColor($1; $i; 0x00FF; 0x00FF; 0x00FF; 0x0099; 0x0099; 0x0099)  //white on gray
								End if 
							Else 
								// -- AL_SetRowColor($1; $i; "black"; 0; "white"; 0)  //Active, greater than zero qty or less on-hand
								//// -- AL_SetRowStyle ($1;$i;0;"")  //black on white
						End case 
						// "0xFF666666"
						// // -- AL_SetRowTextProperty ($1;$i;ALP_Row_TextColor;"0xFF666666")
						
					End for 
				Else 
					$k:=Size of array:C274($2->)
					//<>aALRowRGBColor{1}:=0x00FF
					For ($i; 1; $k)
						QUERY:C277([Item:4]; [Item:4]itemNum:1=$2->{$i})
						Case of 
							: (([Item:4]retired:64=True:C214) & ([Item:4]qtyOnHand:14<=0))  //Retired, zero qty or less on-hand
								//// -- AL_SetRowColor ($1;$i;"red";0;"yellow";0)
								// -- AL_SetRowRGBColor($1; $i; <>aALRowRGBColor{1}; <>aALRowRGBColor{2}; <>aALRowRGBColor{3}; <>aALRowRGBColor{4}; <>aALRowRGBColor{5}; <>aALRowRGBColor{6})
							: (([Item:4]retired:64=True:C214) & ([Item:4]qtyOnHand:14>0))  //Retired, greater than zero qty or less on-hand
								//// -- AL_SetRowColor ($1;$i;"black";0;"yellow";0)
								// -- AL_SetRowRGBColor($1; $i; <>aALRowRGBColor{7}; <>aALRowRGBColor{8}; <>aALRowRGBColor{9}; <>aALRowRGBColor{10}; <>aALRowRGBColor{11}; <>aALRowRGBColor{12})
							: (([Item:4]backOrder:24) & ([Item:4]qtyOnHand:14<=0))  //Backordered, zero qty or less on-hand
								//// -- AL_SetRowColor ($1;$i;"red";0;"light gray";0)
								// -- AL_SetRowRGBColor($1; $i; <>aALRowRGBColor{13}; <>aALRowRGBColor{14}; <>aALRowRGBColor{15}; <>aALRowRGBColor{16}; <>aALRowRGBColor{17}; <>aALRowRGBColor{18})
							: (([Item:4]backOrder:24) & ([Item:4]qtyOnHand:14>0))  //Backordered, greater than zero qty or less on-hand
								//// -- AL_SetRowColor ($1;$i;"black";0;"light gray";0)
								// -- AL_SetRowRGBColor($1; $i; <>aALRowRGBColor{19}; <>aALRowRGBColor{20}; <>aALRowRGBColor{21}; <>aALRowRGBColor{22}; <>aALRowRGBColor{23}; <>aALRowRGBColor{24})
							: ([Item:4]qtyOnHand:14<=0)  //Active, zero qty or less on-hand
								//// -- AL_SetRowColor ($1;$i;"red";0;"white";0)
								// -- AL_SetRowRGBColor($1; $i; <>aALRowRGBColor{25}; <>aALRowRGBColor{26}; <>aALRowRGBColor{27}; <>aALRowRGBColor{28}; <>aALRowRGBColor{29}; <>aALRowRGBColor{30})
							Else   //Active, greater than zero qty or less on-hand
								//// -- AL_SetRowColor ($1;$i;"black";0;"white";0)  //Active, greater than zero qty or less on-hand
								// -- AL_SetRowRGBColor($1; $i; <>aALRowRGBColor{31}; <>aALRowRGBColor{32}; <>aALRowRGBColor{33}; <>aALRowRGBColor{34}; <>aALRowRGBColor{35}; <>aALRowRGBColor{36})
						End case 
					End for 
				End if 
				//  --  CHOPPED  AL_UpdateArrays($1; -2)
				UNLOAD RECORD:C212([Item:4])
			End if 
		End if 
	End if 
End if 

