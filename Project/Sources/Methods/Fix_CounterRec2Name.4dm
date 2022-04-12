//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-11-05T00:00:00, 22:30:25
// ----------------------------------------------------
// Method: Fix_CounterRec2Name
// Description
// Modified: 11/05/15
// 
// 
//
// Parameters
// ----------------------------------------------------


// Assure database have Counters
C_LONGINT:C283($tableIncrement; $tableCount; $recordNumber; $startingCounterRecs; $outOfRange)
C_BOOLEAN:C305($doQuit)
C_POINTER:C301($ptTable)
$outOfRange:=-1122
$tableCount:=Get last table number:C254
READ WRITE:C146([QQQCounter:41])
QUERY:C277([QQQCounter:41]; [QQQCounter:41]TableName:2#"")
//  If (Records in selection([Counter])<$tableCount)

READ WRITE:C146([QQQCounter:41])
ALL RECORDS:C47([QQQCounter:41])
$startingCounterRecs:=Records in selection:C76([QQQCounter:41])
FIRST RECORD:C50([QQQCounter:41])
$tableCount:=Get last table number:C254
$doQuit:=False:C215
$tableIncrement:=0
Repeat   // run through existing Counters
	$recordNumber:=Record number:C243([QQQCounter:41])
	If (($tableIncrement>=$tableCount) & ($recordNumber<0))
		$doQuit:=True:C214
	Else 
		
		Case of 
			: ($recordNumber=0)  // Zeroth Record
				[QQQCounter:41]TableName:2:="Tables"
				[QQQCounter:41]TableNum:4:=1000
				If ([QQQCounter:41]Counter:1=0)
					[QQQCounter:41]Counter:1:=10
				End if 
				[QQQCounter:41]idUnique:6:=[QQQCounter:41]TableNum:4  // must assign a UniqueNumber
			: (($recordNumber>0) & ($recordNumber<=$tableCount))  // Counter were previousely managed by Record Number
				[QQQCounter:41]TableNum:4:=$recordNumber
				$ptTable:=Table:C252([QQQCounter:41]TableNum:4)
				[QQQCounter:41]TableName:2:=Table name:C256([QQQCounter:41]TableNum:4)
				[QQQCounter:41]idUnique:6:=[QQQCounter:41]TableNum:4
				If ([QQQCounter:41]Counter:1=0)
					[QQQCounter:41]Counter:1:=10
				End if 
				// gmgmgm
				// ### bj ### 20180911_2045
				// keep things really simple now that duplicate Uniques can be stepped over. 
				// keep the existing counter number and build CounterPendings
				
				
			Else 
				[QQQCounter:41]TableName:2:="Out-of-Range"  // More records
				[QQQCounter:41]TableNum:4:=$tableIncrement
		End case 
		SAVE RECORD:C53([QQQCounter:41])
		NEXT RECORD:C51([QQQCounter:41])
		$tableIncrement:=$tableIncrement+1  // must be at the end
	End if 
Until ($doQuit)


If (False:C215)
	// double check there were no missing counters
	For ($tableIncrement; 1; $tableCount)
		QUERY:C277([QQQCounter:41]; [QQQCounter:41]TableNum:4=$tableIncrement)
		[QQQCounter:41]TableName:2:=Table name:C256($tableIncrement)
		If (Records in selection:C76([QQQCounter:41])=0)
			If ([QQQCounter:41]TableName:2#(Char:C90(At sign:K15:46)+Char:C90(At sign:K15:46)))
				CREATE RECORD:C68([QQQCounter:41])
				[QQQCounter:41]Counter:1:=10
				[QQQCounter:41]TableName:2:=Table name:C256($tableIncrement)
				[QQQCounter:41]TableNum:4:=$tableIncrement
				[QQQCounter:41]idUnique:6:=[QQQCounter:41]TableNum:4  // must assign a UniqueNumber
				SAVE RECORD:C53([QQQCounter:41])
				$ptTable:=Table:C252([QQQCounter:41]TableNum:4)
				CounterNew($ptTable)
			End if 
		End if 
	End for 
End if 
C_LONGINT:C283($cntTables)
$cntTables:=Get last table number:C254
ALL RECORDS:C47([QQQCounter:41])
ARRAY LONGINT:C221($aCounters; 0)
SELECTION TO ARRAY:C260([QQQCounter:41]; $aCounters)
$tableCount:=Size of array:C274($aCounters)
For ($tableIncrement; 1; $tableCount)
	READ WRITE:C146([QQQCounter:41])
	GOTO RECORD:C242([QQQCounter:41]; $aCounters{$tableIncrement})
	// ### bj ### 20190924_2044
	If ([QQQCounter:41]TableNum:4<=$cntTables)
		$ptTable:=Table:C252([QQQCounter:41]TableNum:4)
		CounterNew($ptTable)
	End if 
End for 

REDUCE SELECTION:C351([QQQCounter:41]; 0)





// UniqueRunForce 