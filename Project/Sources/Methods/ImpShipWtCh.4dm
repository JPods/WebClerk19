//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/07/11, 13:58:32
// ----------------------------------------------------
// Method: ImpShipWtCh
// Description
// 
//
// Parameters
// ----------------------------------------------------

// Modified by: William James (2013-10-01T00:00:00)


C_TEXT:C284($wtCost; $Date)
C_TEXT:C284($Title)
C_TEXT:C284($workStr)
C_LONGINT:C283($i; $lenStr; $endFld; $theFile; $numField; $theSub; $incSub)
C_REAL:C285($theZone)
//
If ([Carrier:11]idNum:44=0)
	
	ALERT:C41("Cancel. [Carrier]UniqueID was zero.")
Else 
	
	QUERY:C277([CarrierWeight:144]; [CarrierWeight:144]idNumCarrier:13=[Carrier:11]idNum:44)
	
	
	KeyModifierCurrent
	myDocName:=""
	$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Open the Weight File"; vDocType; Storage:C1525.folder.jitExportsF)
	//
	If (Ok=1)
		DELETE SELECTION:C66([CarrierWeight:144])
		$theZone:=-3
		TRACE:C157
		[Carrier:11]zone2:12:=$theZone
		[Carrier:11]zone3:13:=$theZone
		[Carrier:11]zone4:14:=$theZone
		[Carrier:11]zone5:15:=$theZone
		[Carrier:11]zone6:16:=$theZone
		[Carrier:11]zone7:17:=$theZone
		[Carrier:11]zone8:18:=$theZone
		[Carrier:11]zone9:29:=$theZone
		[Carrier:11]zone10:30:=$theZone
		[Carrier:11]zone11:31:=$theZone
		RECEIVE PACKET:C104(myDoc; $Title; "\r")  //Weight Chart
		$Title:=Replace string:C233($Title; Char:C90(10); "")  //remove Line feed
		$Title:=Replace string:C233($Title; Char:C90(9); "")  //remove tabs ### jwm ### 20120109_1647
		RECEIVE PACKET:C104(myDoc; $Title; "\r")  //CarrierID
		$Title:=Replace string:C233($Title; Char:C90(10); "")  //remove Line feed
		$Title:=Replace string:C233($Title; Char:C90(9); "")  //remove tabs ### jwm ### 20120109_1647
		C_TEXT:C284($theField; $theValue)
		If (OptKey=0)
			TRACE:C157
			$theFile:=Table:C252(->[Carrier:11])
			RECEIVE PACKET:C104(myDoc; $Title; "\r")  //DateEntered
			$Title:=Replace string:C233($Title; Char:C90(10); "")  //remove line feed
			$Title:=Replace string:C233($Title; Char:C90(9); "")  //remove tabs
			RECEIVE PACKET:C104(myDoc; $Date; "\r")  //Number of records in carriers weight chart
			RECEIVE PACKET:C104(myDoc; $Date; "\r")  //field count    
			$endFld:=Num:C11($Date)
			If (OK=1)
				For ($i; 1; $endFld)
					RECEIVE PACKET:C104(myDoc; $theField; "\t")
					$theField:=Replace string:C233($theField; Char:C90(10); "")
					$numField:=Num:C11($theField)
					RECEIVE PACKET:C104(myDoc; $theValue; "\r")
					$theValue:=Replace string:C233($theValue; Char:C90(10); "")  //remove line feed
					$theValue:=Replace string:C233($theValue; Char:C90(9); "")  //remove tabs ### jwm ### 20120109_1647
					If (OK=1)
						$theType:=Type:C295(Field:C253($theFile; $numField)->)
						Case of 
							: (($theType=0) | ($theType=2))  //string or text
								Field:C253($theFile; $numField)->:=$theValue
							: (($theType=1) | ($theType=8) | ($theType=9))  //integer or long integer
								Field:C253($theFile; $numField)->:=Num:C11($theValue)
							: ($theType=4)  //date
								Field:C253($theFile; $numField)->:=Date:C102($theValue)
							: ($theType=11)  //time
								Field:C253($theFile; $numField)->:=Time:C179($theValue)
							: ($theType=6)  //boolean
								Field:C253($theFile; $numField)->:=($theValue="1")
						End case 
					End if 
				End for 
			End if 
			//
			RECEIVE PACKET:C104(myDoc; $workStr; "\r")
			$workStr:=Replace string:C233($workStr; Char:C90(10); "")
			//
			TRACE:C157
			$i:=0
			$endFld:=1
			While ($endFld>0)
				$endFld:=Position:C15("\t"; $workStr)  //get the next string  
				$theZone:=Num:C11(Substring:C12($workStr; 1; ($endFld-1)))
				$workStr:=Substring:C12($workStr; ($endFld+1))
				$i:=$i+1
				Case of 
					: ($i=1)  //skip the blank space
					: ($i=2)
						[Carrier:11]zone2:12:=$theZone
					: ($i=3)
						[Carrier:11]zone3:13:=$theZone
					: ($i=4)
						[Carrier:11]zone4:14:=$theZone
					: ($i=5)
						[Carrier:11]zone5:15:=$theZone
					: ($i=6)
						[Carrier:11]zone6:16:=$theZone
					: ($i=7)
						[Carrier:11]zone7:17:=$theZone
					: ($i=8)
						[Carrier:11]zone8:18:=$theZone
					: ($i=9)
						[Carrier:11]zone9:29:=$theZone
					: ($i=10)
						[Carrier:11]zone10:30:=$theZone
					: ($endFld=0)  //($i=11)
						[Carrier:11]zone11:31:=Num:C11($workStr)  //### JWM ### 20110107 changed $theZone to $workStr (remainder of string)
				End case 
			End while 
			//
			//ThermoInitExit ("Importing shipping costs";200;True)
			$viProgressID:=Progress New
			
			Repeat 
				$incSub:=$incSub+1
				//Thermo_Update ($incSub)
				ProgressUpdate($viProgressID; $incSub; -1; "Importing shipping costs")
				RECEIVE PACKET:C104(myDoc; $workStr; "\r")
				$workStr:=Replace string:C233($workStr; Char:C90(10); "")
				If (OK=1)
					$lenStr:=Length:C16($workStr)
					If ($lenStr>10)
						CREATE RECORD:C68([CarrierWeight:144])
						
						[CarrierWeight:144]carrierid:14:=[Carrier:11]carrierid:10
						[CarrierWeight:144]idNumCarrier:13:=[Carrier:11]idNum:44
					End if 
					$endFld:=$lenStr
					$i:=0
					While ($endFld>0)
						$i:=$i+1
						$endFld:=Position:C15("\t"; $workStr)  //get the next string  
						$theZone:=Num:C11(Substring:C12($workStr; 1; ($endFld-1)))
						Case of 
							: ($i=1)
								[CarrierWeight:144]weight:1:=$theZone
							: ($i=2)
								[CarrierWeight:144]cost2:2:=$theZone
							: ($i=3)
								[CarrierWeight:144]cost3:3:=$theZone
							: ($i=4)
								[CarrierWeight:144]cost4:4:=$theZone
							: ($i=5)
								[CarrierWeight:144]cost5:5:=$theZone
							: ($i=6)
								[CarrierWeight:144]cost6:6:=$theZone
							: ($i=7)
								[CarrierWeight:144]cost7:7:=$theZone
							: ($i=8)
								[CarrierWeight:144]cost8:8:=$theZone
							: ($i=9)
								[CarrierWeight:144]cost9:9:=$theZone
							: ($i=10)
								[CarrierWeight:144]cost10:10:=$theZone
							: ($endFld=0)  //($i=11)
								[CarrierWeight:144]cost11:11:=Num:C11($workStr)
						End case 
						$workStr:=Substring:C12($workStr; ($endFld+1))
						$lenStr:=Length:C16($workStr)
					End while 
				End if 
			Until (OK=0)
			//Thermo_Close 
			Progress QUIT($viProgressID)
		Else 
			RECEIVE PACKET:C104(myDoc; $Title; "\r")
			$Title:=Replace string:C233($Title; Char:C90(10); "")
			Repeat 
				RECEIVE PACKET:C104(myDoc; $workStr; "\r")
				$workStr:=Replace string:C233($workStr; Char:C90(10); "")
			Until ((Substring:C12($workStr; 1; 6)="Weight") | (OK=0))
			TRACE:C157
			$lenStr:=Length:C16($workStr)
			$i:=1
			While ($lenStr>1)
				$Date:=Substring:C12($workStr; 7; 3)
				$theZone:=Num:C11($date)
				Case of 
					: ($i=1)  //strip weight
					: ($i=2)
						[Carrier:11]zone2:12:=$theZone
					: ($i=3)
						[Carrier:11]zone3:13:=$theZone
					: ($i=4)
						[Carrier:11]zone4:14:=$theZone
					: ($i=5)
						[Carrier:11]zone5:15:=$theZone
					: ($i=6)
						[Carrier:11]zone6:16:=$theZone
					: ($i=7)
						[Carrier:11]zone7:17:=$theZone
					: ($i=8)
						[Carrier:11]zone8:18:=$theZone
					: ($i=9)
						[Carrier:11]zone9:29:=$theZone
					: ($i=10)
						[Carrier:11]zone10:30:=$theZone
					: ($i=11)
						[Carrier:11]zone11:31:=$theZone
				End case 
				$workStr:=Substring:C12($workStr; 10; $lenStr)
				$lenStr:=Length:C16($workStr)
				$i:=$i+1
			End while 
			RECEIVE PACKET:C104(myDoc; $Date; "\r")
			$Date:=Replace string:C233($Date; Char:C90(10); "")
			Repeat 
				RECEIVE PACKET:C104(myDoc; $workStr; "\r")
				$workStr:=Replace string:C233($workStr; Char:C90(10); "")
				If (OK=1)
					$lenStr:=Length:C16($workStr)
					If ($lenStr>10)
						CREATE RECORD:C68([CarrierWeight:144])
						
						[CarrierWeight:144]carrierid:14:=[Carrier:11]carrierid:10
						[CarrierWeight:144]idNumCarrier:13:=[Carrier:11]idNum:44
					End if 
					$i:=1
					While ($lenStr>1)
						Case of 
							: ($i=1)
								[CarrierWeight:144]weight:1:=Num:C11(Substring:C12($workStr; 1; 9))
							: ($i=2)
								[CarrierWeight:144]cost2:2:=Num:C11(Substring:C12($workStr; 1; 9))
							: ($i=3)
								[CarrierWeight:144]cost3:3:=Num:C11(Substring:C12($workStr; 1; 9))
							: ($i=4)
								[CarrierWeight:144]cost4:4:=Num:C11(Substring:C12($workStr; 1; 9))
							: ($i=5)
								[CarrierWeight:144]cost5:5:=Num:C11(Substring:C12($workStr; 1; 9))
							: ($i=6)
								[CarrierWeight:144]cost6:6:=Num:C11(Substring:C12($workStr; 1; 9))
							: ($i=7)
								[CarrierWeight:144]cost7:7:=Num:C11(Substring:C12($workStr; 1; 9))
							: ($i=8)
								[CarrierWeight:144]cost8:8:=Num:C11(Substring:C12($workStr; 1; 9))
							: ($i=9)
								[CarrierWeight:144]cost9:9:=Num:C11(Substring:C12($workStr; 1; 9))
							: ($i=10)
								[CarrierWeight:144]cost10:10:=Num:C11(Substring:C12($workStr; 1; 9))
							: ($i=11)
								[CarrierWeight:144]cost11:11:=Num:C11(Substring:C12($workStr; 1; 9))
						End case 
						SAVE RECORD:C53([CarrierWeight:144])
						$workStr:=Substring:C12($workStr; 10; $lenStr)
						$lenStr:=Length:C16($workStr)
						$i:=$i+1
					End while 
				End if 
			Until (OK=0)
		End if 
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 