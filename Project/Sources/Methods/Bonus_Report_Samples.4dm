//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/11/16, 13:22:41
// ----------------------------------------------------
// Method: Bonus_Report_Samples
// Description
// 
//
// Parameters
// ----------------------------------------------------

// Script cleaned 20160809
//Script Bonus Report Samples 20160809

//====================
//FDI and Samples
//====================

C_LONGINT:C283(vi1; vi2; vi3)
C_REAL:C285(vrMultiplier; vrSamples; vrSamples2; vrSamples2Net; vrSamples3; vrSamples3Net; vrSamples4; vrSamples4Net; vrSamples5; vrSamples5Net; vrSamples6; vrSamples6Net; vrSamplesMisc; vrSamplesNet)
C_TEXT:C284(vtElapsed)
C_TIME:C306(vhElapsed; vhNow; vhStartTime)

QUERY SELECTION:C341([InvoiceLine:54]; [InvoiceLine:54]customerid:2="FD100048"; *)
QUERY SELECTION:C341([InvoiceLine:54];  | [InvoiceLine:54]customerid:2="8202"; *)
QUERY SELECTION:C341([InvoiceLine:54])


Open window:C153(100; 200; 500; 300; 5; "Processing Samples...")
ERASE WINDOW:C160
GOTO XY:C161(3; 3)

vi2:=Records in selection:C76([InvoiceLine:54])
FIRST RECORD:C50([InvoiceLine:54])
For (vi1; 1; vi2)
	
	vhNow:=Current time:C178
	vhElapsed:=vhNow-vhStartTime
	vtElapsed:=String:C10(vhElapsed)
	
	ERASE WINDOW:C160
	GOTO XY:C161(3; 3)
	MESSAGE:C88(" Record "+String:C10(vi1)+" of "+String:C10(vi2)+" -- Elapsed Time "+vtElapsed)
	
	QUERY:C277([Item:4]; [Item:4]itemNum:1=[InvoiceLine:54]itemNum:4)
	
	vi3:=Records in selection:C76([Item:4])
	
	If (vi3=1)  //Item Number Found
		FIRST RECORD:C50([Item:4])
		
		//Execute_TallyMaster ("Multiplier";"Bonus_Report";3)  //calculate multiplier
		Bonus_Report_Multiplier
		
		//Apply Multiplier
		
		Case of 
			: ([InvoiceLine:54]profile4:33="2-HA-LPC")
				
				vrSamples:=vrSamples+([InvoiceLine:54]extendedPrice:11*1)
				vrSamplesNet:=vrSamplesNet+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				vrSamples2:=vrSamples2+([InvoiceLine:54]extendedPrice:11*1)
				vrSamples2Net:=vrSamples2Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				
			: ([InvoiceLine:54]profile4:33="3-HA-HPC")
				
				vrSamples:=vrSamples+([InvoiceLine:54]extendedPrice:11*1)
				vrSamplesNet:=vrSamplesNet+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				vrSamples3:=vrSamples3+([InvoiceLine:54]extendedPrice:11*1)
				vrSamples3Net:=vrSamples3Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				
			: ([InvoiceLine:54]profile4:33="4-LA-HPC")
				
				vrSamples:=vrSamples+([InvoiceLine:54]extendedPrice:11*1)
				vrSamplesNet:=vrSamplesNet+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				vrSamples4:=vrSamples4+([InvoiceLine:54]extendedPrice:11*1)
				vrSamples4Net:=vrSamples4Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				
			: ([InvoiceLine:54]profile4:33="5-NA-HPC")
				
				vrSamples:=vrSamples+([InvoiceLine:54]extendedPrice:11*1)
				vrSamplesNet:=vrSamplesNet+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				vrSamples5:=vrSamples5+([InvoiceLine:54]extendedPrice:11*1)
				vrSamples5Net:=vrSamples5Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				
			: ([InvoiceLine:54]profile4:33="6-NA-NPC")
				
				vrSamples:=vrSamples+([InvoiceLine:54]extendedPrice:11*1)
				vrSamplesNet:=vrSamplesNet+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				vrSamples6:=vrSamples6+([InvoiceLine:54]extendedPrice:11*1)
				vrSamples6Net:=vrSamples6Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				
			Else 
				ADD TO SET:C119([Item:4]; "No_Profile4")
				vrSamples:=vrSamples+([InvoiceLine:54]extendedPrice:11*1)
				vrSamplesNet:=vrSamplesNet+([InvoiceLine:54]extendedPrice:11*0)  //vrMultiplier = 0
				vrSamplesMisc:=vrSamplesMisc+([InvoiceLine:54]extendedPrice:11)
				
		End case 
		
		
	End if   //Item Number Found
	
	NEXT RECORD:C51([InvoiceLine:54])
End for 

ERASE WINDOW:C160
CLOSE WINDOW:C154

//End FDI and Samples