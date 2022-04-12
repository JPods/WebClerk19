//%attributes = {}

// ----------------------------------------------------
// User name (OS): J.Medlen
// Date and time: 2016-10-10T00:00:00, 16:26:30
// ----------------------------------------------------
// Method: ForecastTrendReport5Yr
// Description
// Modified: 10/10/16
// 
// 
//
// Parameters
// ----------------------------------------------------

//Script ForecastTrendReport5Yr OnServer 20120914

// OnServer Example

//Execute_TallyMaster("ForecastTrendReport5Yr";"OnServer";3)

//===================================================
//Client Side Process
//===================================================

//===================================================
//Setup & Initialize Variables, Arrays, User Input
//===================================================
ARRAY LONGINT:C221(alRecords; 0)
ARRAY TEXT:C222(aText1; 0)
C_LONGINT:C283(viReady; vi2)
C_TEXT:C284(vtStatus; vtTitle)
viReady:=0
vi2:=0
vtStatus:=""
vtTitle:=""

viYear:=Year of:C25(Current date:C33)
viLastYear:=viYear-1
viMonth:=Month of:C24(Current date:C33)
Case of 
	: (viMonth=1)
		viLastMonth:=12
		viLastMonth1:=11
		viLastMonth2:=10
		viYear:=viLastYear
		viYear1:=viLastYear
		viYear2:=viLastYear
		
	: (viMonth=2)
		viLastMonth:=1
		viLastMonth1:=12
		viLastMonth2:=11
		viYear:=viYear
		viYear1:=viLastYear
		viYear2:=viLastYear
		
	: (viMonth=3)
		viLastMonth:=2
		viLastMonth1:=1
		viLastMonth2:=12
		viYear:=viYear
		viYear1:=viYear
		viYear2:=viLastYear
	Else 
		viLastMonth:=viMonth-1
		viLastMonth1:=viMonth-2
		viLastMonth2:=viMonth-3
		viYear:=viYear
		viYear1:=viYear
		viYear2:=viYear
End case 


//Request, Confirm, User Input


//===================================================
//Launch Server Side Process, Status Window
//===================================================

vlProcessID:=Execute on server:C373("ExecuteText"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-OnServer"; 0; [TallyMaster:60]build:6; *)
vlTestID:=Abs:C99(vlProcessID)

vlWindowID:=Open window:C153(100; 200; 500; 300; -1984; "Status")
ERASE WINDOW:C160
GOTO XY:C161(3; 3)

//===================================================
//Wait for Server Process to be Ready
//===================================================

While ((viReady=0) & (vi2<18000))  //timeout = 1/2 hour
	DELAY PROCESS:C323(Current process:C322; 6)
	vi2:=vi2+1
	GET PROCESS VARIABLE:C371(-vlTestID; viReady; viReady; vtStatus; vtStatus; vtTitle; vtTitle)
	If (vtTitle#"")
		SET WINDOW TITLE:C213(vtTitle; vlWindowID)
	End if 
	If (vtStatus#"")
		ERASE WINDOW:C160
		GOTO XY:C161(3; 3)
		MESSAGE:C88(vtStatus)
	End if 
End while 

//===================================================
//server ready, load client variables to server
//===================================================

//No variables passed for this script
//SELECTION TO ARRAY([Customer];alRecords)
//VARIABLE TO VARIABLE (-vlTestID;alRecords;alRecords)

//===================================================
//set ready = 2 Run Server Process
//===================================================
viReady:=2
SET PROCESS VARIABLE:C370(-vlTestID; viReady; viReady)

//===================================================
//Wait for Server Process to Complete, Display Status
//===================================================

While ((viReady<3) & (vi2<18000))  //timeout = 1/2 hour
	DELAY PROCESS:C323(Current process:C322; 6)
	vi2:=vi2+1
	GET PROCESS VARIABLE:C371(-vlTestID; viReady; viReady; vtStatus; vtStatus; vtTitle; vtTitle)
	If (vtTitle#"")
		SET WINDOW TITLE:C213(vtTitle; vlWindowID)
	End if 
	If (vtStatus#"")
		ERASE WINDOW:C160
		GOTO XY:C161(3; 3)
		MESSAGE:C88(vtStatus)
	End if 
End while 

//===================================================
//Retrieve Results from Server Process
//===================================================

GET PROCESS VARIABLE:C371(-vlTestID; aText1; aText1)

//Not passing a SET of Records
//Get PROCESS VARIABLE(-vlTestID;alRecords;alRecords)
//CREATE SET FROM ARRAY ([LoadTag]; alRecords; "myRecords")
//Use Set("myRecords")

//===================================================
//Set Ready = 4 Data Retrieval Complete
//===================================================
viReady:=4
SET PROCESS VARIABLE:C370(-vlTestID; viReady; viReady)

//Get last Status 
//GET PROCESS VARIABLE(-vlTestID;viReady;viReady;vtStatus;vtStatus;vtTitle;vtTitle)
vtTitle:="Forecast Trend Report"
vtStatus:="Choose Location for Forecast Trend Report"

If (vtTitle#"")
	SET WINDOW TITLE:C213(vtTitle; vlWindowID)
End if 
If (vtStatus#"")
	ERASE WINDOW:C160
	GOTO XY:C161(3; 3)
	MESSAGE:C88(vtStatus)
End if 


//Alert("Size of Array(aText1) = "+String(Size of Array(aText1)))

If (viLastMonth=12)
	viYearLong:=Year of:C25(Current date:C33)
	viYearLong:=viYearLong-1
	vtYearLong:=String:C10(viYearLong)
Else 
	vtYearLong:=String:C10(Year of:C25(Current date:C33))
End if 

//reformat vtLastMonth
vtLastMonth:=String:C10(viLastMonth)
Len:=Length:C16(vtLastMonth)
If (len=1)
	vtMonthLong:="0"+vtLastMonth
Else 
	vtMonthLong:=vtLastMonth
End if 

vtFile:="Trend Report "+vtYearLong+vtMonthLong
vtFolder:=Select folder:C670("Select a folder to Save product files")
vText1:=vtFolder+vtFile
myDoc:=Create document:C266(vText1)

vText1:=Document
//Alert(vText1)

vi2:=Size of array:C274(aText1)

For (vi1; 1; vi2)
	vrPercent:=Round:C94(vi1/vi2*100; 0)
	ERASE WINDOW:C160
	GOTO XY:C161(3; 3)
	MESSAGE:C88("Writing Forecast Trend Report: "+String:C10(vi1)+" of "+String:C10(vi2)+" "+String:C10(vrPercent)+"%")
	SEND PACKET:C103(myDoc; aText1{vi1})
End for 

CLOSE DOCUMENT:C267(myDoc)

ERASE WINDOW:C160
GOTO XY:C161(3; 3)
MESSAGE:C88("Complete")
CLOSE WINDOW:C154

OPEN URL:C673(vText1)

//===================================================
/////////////////////////////////////////////////////
//===================================================

//===================================================
//Server Side Process
//===================================================
ARRAY LONGINT:C221(alRecords; 0)
ARRAY TEXT:C222(aText1; 0)
C_LONGINT:C283(viReady; vi2)
C_TEXT:C284(vtStatus; vtTitle)
viReady:=1
vi2:=0
vtStatus:="Server Ready"
vtTitle:="Status"
//wait for variables
While ((viReady<2) & (vi2<18000))  //timeout = 1/2 hour
	DELAY PROCESS:C323(Current process:C322; 6)
	vi2:=vi2+1
End while 

If (viReady>1)
	vtStatus:="Variables Loaded"
Else 
	vtStatus:="Loading Variables Timed Out"
End if 
//===================================================
//Body of work
// -===================================================

//script Forecast Trend Report 20100706

//9 = tab 
//34 = double quote
vT:=Char:C90(9)
vDQT:=Char:C90(34)+Char:C90(9)
vDQ:=Char:C90(34)  //DoubleQuote
vCRLF:=Char:C90(13)+Char:C90(10)
vCR:=Char:C90(13)

viYear:=Year of:C25(Current date:C33)
viLastYear:=viYear-5
viMonth:=Month of:C24(Current date:C33)
Case of 
	: (viMonth=1)
		viLastMonth:=12
		viLastMonth1:=11
		viLastMonth2:=10
		viYear:=viLastYear
		viYear1:=viLastYear
		viYear2:=viLastYear
		
	: (viMonth=2)
		viLastMonth:=1
		viLastMonth1:=12
		viLastMonth2:=11
		viYear:=viYear
		viYear1:=viLastYear
		viYear2:=viLastYear
		
	: (viMonth=3)
		viLastMonth:=2
		viLastMonth1:=1
		viLastMonth2:=12
		viYear:=viYear
		viYear1:=viYear
		viYear2:=viLastYear
	Else 
		viLastMonth:=viMonth-1
		viLastMonth1:=viMonth-2
		viLastMonth2:=viMonth-3
		viYear:=viYear
		viYear1:=viYear
		viYear2:=viYear
End case 

viDay:=1

vtYear:=String:C10(viYear)
vtYear:=Substring:C12(vtYear; 3; 2)
vtYear1:=String:C10(viYear1)
vtYear1:=Substring:C12(vtYear1; 3; 2)
vtYear2:=String:C10(viYear2)
vtYear2:=Substring:C12(vtYear2; 3; 2)
vtLastYear:=String:C10(viLastYear)
vtLastYear:=Substring:C12(vtLastYear; 3; 2)
vtMonth:=String:C10(viMonth)
vtLastMonth:=String:C10(viLastMonth)
vtLastMonth1:=String:C10(viLastMonth1)
vtLastMonth2:=String:C10(viLastMonth2)
vtDay:="1"

vtStartDate:=vtMonth+"/"+vtDay+"/"+vtLastYear
vtEndDate:=vtLastMonth+"/"+vtDay+"/"+vtYear
vtLastMonth:=vtLastMonth+"/"+vtDay+"/"+vtYear
vtLastMonth1:=vtLastMonth1+"/"+vtDay+"/"+vtYear1
vtLastMonth2:=vtLastMonth2+"/"+vtDay+"/"+vtYear2

vtMessage:="Start Date = "+vtStartDate+vCR
vtMessage:=vtMessage+"End Date = "+vtEndDate+vCR
vtMessage:=vtMessage+"Last Month = "+vtLastMonth+vCR
vtMessage:=vtMessage+"Last Month -1 = "+vtLastMonth1+vCR
vtMessage:=vtMessage+"Last Month -2 = "+vtLastMonth2+vCR

vtStatus:=vtMessage

vdLastMonth:=Date:C102(vtLastMonth)
vdLastMonth1:=Date:C102(vtLastMonth1)
vdLastMonth2:=Date:C102(vtLastMonth2)

QUERY:C277([Proposal:42]; [Proposal:42]probability:43#0; *)
QUERY:C277([Proposal:42])
RELATE MANY SELECTION:C340([ProposalLine:43]proposalNum:1)
CREATE EMPTY SET:C140([Item:4]; "MySelection")

vtTitle:="Forecast Items from Proposals"

vi2:=Records in selection:C76([ProposalLine:43])
FIRST RECORD:C50([ProposalLine:43])
For (vi1; 1; vi2)
	
	QUERY:C277([Item:4]; [Item:4]itemNum:1=[ProposalLine:43]itemNum:2)
	ADD TO SET:C119([Item:4]; "MySelection")
	
	vtStatus:=[Item:4]itemNum:1
	
	NEXT RECORD:C51([ProposalLine:43])
End for 

QUERY:C277([Order:3]; [Order:3]complete:83<2; *)
QUERY:C277([Order:3])
RELATE MANY SELECTION:C340([OrderLine:49]orderNum:1)

Srch_SetBefore("Search Selection")
QUERY SELECTION:C341([OrderLine:49]; [OrderLine:49]qtyBackLogged:8>0; *)
QUERY SELECTION:C341([OrderLine:49])
Srch_SetEnd("Search Selection")

vtTitle:="Forecast Items from Orders"

vi2:=Records in selection:C76([OrderLine:49])
FIRST RECORD:C50([OrderLine:49])
For (vi1; 1; vi2)
	
	QUERY:C277([Item:4]; [Item:4]itemNum:1=[OrderLine:49]itemNum:4)
	ADD TO SET:C119([Item:4]; "MySelection")
	
	vtStatus:=[Item:4]itemNum:1
	
	NEXT RECORD:C51([OrderLine:49])
End for 

USE SET:C118("MySelection")
ORDER BY:C49([Item:4]; [Item:4]itemNum:1; >)

//script
CREATE EMPTY SET:C140([Usage:5]; "MyUsage")
RELATE MANY SELECTION:C340([Usage:5]itemNum:1)

vtTitle:="Usage For Forecast Items"

vi2:=Records in selection:C76([Item:4])

ARRAY TEXT:C222(atItemNum; vi2)
ARRAY TEXT:C222(atMfrItemNum; vi2)
ARRAY TEXT:C222(atQtyOnHand; vi2)
ARRAY TEXT:C222(atTotal; vi2)
ARRAY TEXT:C222(atAvg; vi2)
ARRAY TEXT:C222(atAvgx3; vi2)
ARRAY TEXT:C222(atCount; vi2)
ARRAY TEXT:C222(atPrpQty; vi2)
ARRAY TEXT:C222(atAvgLast3; vi2)
ARRAY TEXT:C222(atLast; vi2)

FIRST RECORD:C50([Item:4])
For (vi1; 1; vi2)
	
	vrTotal:=0
	vrLast:=0
	vrLast3:=0
	
	atItemNum{vi1}:=[Item:4]itemNum:1
	atMfrItemNum{vi1}:=[Item:4]mfrItemNum:39
	atQtyOnHand{vi1}:=String:C10([Item:4]qtyOnHand:14)
	
	QUERY:C277([Usage:5]; [Usage:5]itemNum:1=[Item:4]itemNum:1; *)
	QUERY:C277([Usage:5];  & [Usage:5]periodDate:2>=vtStartDate; *)
	QUERY:C277([Usage:5];  & [Usage:5]periodDate:2<=vtEndDate; *)
	QUERY:C277([Usage:5])
	
	vi4:=Records in selection:C76([Usage:5])
	atCount{vi1}:=String:C10(vi4)
	
	FIRST RECORD:C50([Usage:5])
	For (vi3; 1; vi4)
		//ADD TO SET([Usage];"MyUsage")
		
		vtStatus:=[Usage:5]itemNum:1+" - "+String:C10([Usage:5]periodDate:2)
		
		vrTotal:=vrTotal+[Usage:5]salesQtyActual:4
		
		Case of 
			: ([Usage:5]periodDate:2=vdLastMonth)
				vrLast:=[Usage:5]salesQtyActual:4
				vrLast3:=vrLast3+[Usage:5]salesQtyActual:4
				
			: ([Usage:5]periodDate:2=vdLastMonth1)
				vrLast3:=vrLast3+[Usage:5]salesQtyActual:4
				
			: ([Usage:5]periodDate:2=vdLastMonth2)
				vrLast3:=vrLast3+[Usage:5]salesQtyActual:4
		End case 
		
		NEXT RECORD:C51([Usage:5])
	End for 
	
	vrAvg:=vrTotal/60  //60 months 5 years
	vrAvgx3:=vrTotal/20  //20 quarters in 5 years
	
	If (vrLast3=0)
		vrAvgLast3:=0
	Else 
		vrAvgLast3:=vrLast3/3
	End if 
	
	vrAvg:=Round:C94(vrAvg; 0)
	vrAvgx3:=Round:C94(vrAvgx3; 0)
	vrAvgLast3:=Round:C94(vrAvgLast3; 0)
	
	atTotal{vi1}:=String:C10(vrTotal)
	atAvg{vi1}:=String:C10(vrAvg)
	atAvgx3{vi1}:=String:C10(vrAvgx3)
	atAvgLast3{vi1}:=String:C10(vrAvgLast3)
	atLast{vi1}:=String:C10(vrLast)
	
	QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=9999; *)
	QUERY:C277([ProposalLine:43];  & [ProposalLine:43]itemNum:2=[Item:4]itemNum:1; *)
	QUERY:C277([ProposalLine:43])
	
	atPrpQty{vi1}:=String:C10([ProposalLine:43]qty:3)
	
	NEXT RECORD:C51([Item:4])
End for 

//vHeader:="ItemNum"+vT+"Grand Total"+vT+"Average"+vT+"Average * 3"+vT+"AvgLast3"+vT+"LastMonth"+vT+"Count"+vT+"ProposalQty"+vT+"NewProposalQty"+vCRLF
vHeader:="ItemNum"+vT+"MfrItemNum"+vT+"Grand Total"+vT+"Average"+vT+"AvgLast3"+vT+"LastMonth"+vT+"Count"+vT+"QtyOnHand"+vT+"ProposalQty"+vT+"NewProposalQty"+vCRLF

//Send Packet(myDoc;vHeader)
vText:=vHeader
APPEND TO ARRAY:C911(aText1; vText)

For (vi1; 1; vi2)
	vText:=""
	vText:=vText+""
	vText:=vText+vDQ+atItemNum{vi1}+vDQT
	vText:=vText+vDQ+atMfrItemNum{vi1}+vDQT
	vText:=vText+vDQ+atTotal{vi1}+vDQT
	vText:=vText+vDQ+atAvg{vi1}+vDQT
	vText:=vText+vDQ+atAvgLast3{vi1}+vDQT
	vText:=vText+vDQ+atLast{vi1}+vDQT
	vText:=vText+vDQ+atCount{vi1}+vDQT
	vText:=vText+vDQ+atQtyOnHand{vi1}+vDQT
	vText:=vText+vDQ+atPrpQty{vi1}+vDQT
	vText:=vText+vDQ+" "+vDQ+vCRLF
	APPEND TO ARRAY:C911(aText1; vText)
End for 

//===================================================
//End body of work
//===================================================

viReady:=3
vtStatus:="waiting for client to retrieve data"

//wait for client to retrieve data
While ((viReady<4) & (vi2<18000))  //timeout = 1/2 hour
	DELAY PROCESS:C323(Current process:C322; 6)
	vi2:=vi2+1
End while 

//Courtesy Message
vtStatus:="Closing Server Process"
DELAY PROCESS:C323(Current process:C322; 60)

