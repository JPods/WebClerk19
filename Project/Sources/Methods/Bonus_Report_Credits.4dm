//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/11/16, 13:22:59
// ----------------------------------------------------
// Method: Bonus_Report_Credits
// Description
// 
//
// Parameters
// ----------------------------------------------------

// Script cleaned 20160809
//Script Bonus Report Credits 20160809.4d

C_LONGINT:C283(vi1; vi2; vi3)
C_REAL:C285(vrA; vrB; vrC; vrCredit; vrCreditMisc; vrCreditNet; vrCreditX1; vrCreditX10; vrCreditX10Net; vrCreditX1Net; vrCreditX2)
C_REAL:C285(vrCreditX2Net; vrCreditX3; vrCreditX3Net; vrCreditX4; vrCreditX4Net; vrCreditX6; vrCreditX6Net; vrD; vrE; vrF; vrMultiplier; vrPenalty; vrX)
C_TEXT:C284(vtBegin; vtElapsed; vtEnd)
C_TIME:C306(vhElapsed; vhNow; vhStartTime)

QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]extendedPrice:11<=0; *)
QUERY:C277([InvoiceLine:54];  & ; [InvoiceLine:54]dateShipped:25>=vtBegin; *)
QUERY:C277([InvoiceLine:54];  & ; [InvoiceLine:54]dateShipped:25<=vtEnd; *)
QUERY:C277([InvoiceLine:54];  & ; [InvoiceLine:54]qty:7<0; *)
QUERY:C277([InvoiceLine:54];  & ; [InvoiceLine:54]customerID:2#"fd100048@"; *)
QUERY:C277([InvoiceLine:54];  & ; [InvoiceLine:54]customerID:2#"8202@"; *)
QUERY:C277([InvoiceLine:54];  & ; [InvoiceLine:54]itemNum:4#"rebate@"; *)
QUERY:C277([InvoiceLine:54])


var $widow_i : Integer
$widow_i:=Open window:C153(100; 200; 500; 300; 5; "Processing Credits...")
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
		
		If ([InvoiceLine:54]profile4:33="")
			[InvoiceLine:54]profile4:33:=[Item:4]profile4:38
		End if 
		
		//Calculation is based on formula from Ken that calculates as 0-100 % not .01 - 1 
		//must be converted to a multiplier after kens calculation
		Case of 
			: ([InvoiceLine:54]profile4:33="2-HA-LPC")
				vrA:=-0.000011651877
				vrB:=0.002772825898
				vrC:=0.255467561726
				vrD:=11.41163819699
				vrE:=245.9880320871
				vrF:=2044.180657002
				vrX:=0
				
				Case of 
					: ([InvoiceLine:54]marginPerCent:55>71)
						vrMultiplier:=1.1
						
					: (([InvoiceLine:54]marginPerCent:55>=40) & ([InvoiceLine:54]marginPerCent:55<=71))
						vrX:=[InvoiceLine:54]marginPerCent:55
						vrMultiplier:=(vrA*(vrX^5))+(vrB*(vrX^4))-(vrC*(vrX^3))+(vrD*(vrX^2))-(vrE*vrX)+vrF  //Kens Formula
						vrMultiplier:=vrMultiplier*0.01  //conversion to multiplier
						
					: ([InvoiceLine:54]marginPerCent:55<40)
						vrMultiplier:=0
				End case 
				
			: ([InvoiceLine:54]profile4:33="3-HA-HPC")
				vrA:=-0.000011651877
				vrB:=0.002772825898
				vrC:=0.255467561726
				vrD:=11.41163819699
				vrE:=245.9880320871
				vrF:=2044.180657002
				vrX:=0
				
				Case of 
					: ([InvoiceLine:54]marginPerCent:55>60)
						vrMultiplier:=0.75
						
					: (([InvoiceLine:54]marginPerCent:55>=40) & ([InvoiceLine:54]marginPerCent:55<=60))
						vrX:=[InvoiceLine:54]marginPerCent:55
						vrMultiplier:=(vrA*(vrX^5))+(vrB*(vrX^4))-(vrC*(vrX^3))+(vrD*(vrX^2))-(vrE*vrX)+vrF  //Kens Formula
						vrMultiplier:=vrMultiplier*0.01  //conversion to multiplier
						
					: ([InvoiceLine:54]marginPerCent:55<40)
						vrMultiplier:=0
				End case 
				
			: ([InvoiceLine:54]profile4:33="4-LA-HPC")
				vrA:=-0.000011651877
				vrB:=0.002772825898
				vrC:=0.255467561726
				vrD:=11.41163819699
				vrE:=245.9880320871
				vrF:=2044.180657002
				vrX:=0
				
				Case of 
					: ([InvoiceLine:54]marginPerCent:55>54)
						vrMultiplier:=0.5
						
					: (([InvoiceLine:54]marginPerCent:55>=30) & ([InvoiceLine:54]marginPerCent:55<=54))
						vrX:=[InvoiceLine:54]marginPerCent:55
						vrMultiplier:=(vrA*(vrX^5))+(vrB*(vrX^4))-(vrC*(vrX^3))+(vrD*(vrX^2))-(vrE*vrX)+vrF  //Kens Formula
						vrMultiplier:=vrMultiplier*0.01  //conversion to multiplier
						
					: ([InvoiceLine:54]marginPerCent:55<30)
						vrMultiplier:=0
				End case 
				
			: ([InvoiceLine:54]profile4:33="5-NA-HPC")
				vrA:=-0.0122354079
				vrB:=1.0342330524
				vrC:=26.6377149682
				vrD:=216.9443414597
				vrX:=0
				
				Case of 
					: ([InvoiceLine:54]marginPerCent:55>36)
						vrMultiplier:=0.275
						
					: (([InvoiceLine:54]marginPerCent:55>=30) & ([InvoiceLine:54]marginPerCent:55<=54))
						vrX:=[InvoiceLine:54]marginPerCent:55
						vrMultiplier:=(vrA*(vrX^3))+(vrB*(vrX^2))-(vrC*vrX)+vrD  //Kens Formula  #####
						vrMultiplier:=vrMultiplier*0.01  //conversion to multiplier
						
					: ([InvoiceLine:54]marginPerCent:55<20)
						vrMultiplier:=0
				End case 
				
				
			: ([InvoiceLine:54]profile4:33="6-NA-NPC")
				
				vrMultiplier:=1  //straight 100% for credits and rebates
				
				
			Else 
				//Misc counts zero 
				vrMultiplier:=0
				
		End case 
		
		
		//Total values for Credits
		
		vrPenalty:=[InvoiceLine:54]profileReal1:61
		
		Case of 
			: ((vrPenalty>0) & (vrPenalty<=1))
				
				vrCredit:=vrCredit+([InvoiceLine:54]extendedPrice:11*1)
				vrCreditNet:=vrCreditNet+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier*vrPenalty); 2)
				vrCreditX1:=vrCreditX1+([InvoiceLine:54]extendedPrice:11*1)
				vrCreditX1Net:=vrCreditX1Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier*vrPenalty); 2)
				
			: ((vrPenalty>1) & (vrPenalty<=2))
				
				vrCredit:=vrCredit+([InvoiceLine:54]extendedPrice:11*1)
				vrCreditNet:=vrCreditNet+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier*vrPenalty); 2)
				vrCreditX2:=vrCreditX2+([InvoiceLine:54]extendedPrice:11*1)
				vrCreditX2Net:=vrCreditX2Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier*vrPenalty); 2)
				
			: ((vrPenalty>2) & (vrPenalty<=3))
				
				vrCredit:=vrCredit+([InvoiceLine:54]extendedPrice:11*1)
				vrCreditNet:=vrCreditNet+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier*vrPenalty); 2)
				vrCreditX3:=vrCreditX3+([InvoiceLine:54]extendedPrice:11*1)
				vrCreditX3Net:=vrCreditX3Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier*vrPenalty); 2)
				
			: ((vrPenalty>3) & (vrPenalty<=4))
				
				vrCredit:=vrCredit+([InvoiceLine:54]extendedPrice:11*1)
				vrCreditNet:=vrCreditNet+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier*vrPenalty); 2)
				vrCreditX4:=vrCreditX4+([InvoiceLine:54]extendedPrice:11*1)
				vrCreditX4Net:=vrCreditX4Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier*vrPenalty); 2)
				
			: ((vrPenalty>4) & (vrPenalty<=6))
				
				vrCredit:=vrCredit+([InvoiceLine:54]extendedPrice:11*1)
				vrCreditNet:=vrCreditNet+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier*vrPenalty); 2)
				vrCreditX6:=vrCreditX6+([InvoiceLine:54]extendedPrice:11*1)
				vrCreditX6Net:=vrCreditX6Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier*vrPenalty); 2)
				
			: ((vrPenalty>6) & (vrPenalty<=10))
				
				vrCredit:=vrCredit+([InvoiceLine:54]extendedPrice:11*1)
				vrCreditNet:=vrCreditNet+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier*vrPenalty); 2)
				vrCreditX10:=vrCreditX10+([InvoiceLine:54]extendedPrice:11*1)
				vrCreditX10Net:=vrCreditX10Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier*vrPenalty); 2)
				
			Else 
				vrPenalty:=0
				vrCredit:=vrCredit+([InvoiceLine:54]extendedPrice:11*1)
				vrCreditNet:=vrCreditNet+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier*vrPenalty); 2)
				vrCreditMisc:=vrCreditMisc+([InvoiceLine:54]extendedPrice:11)
				
		End case 
		
		
	End if   //Item Number Found
	
	NEXT RECORD:C51([InvoiceLine:54])
End for 

ERASE WINDOW:C160
CLOSE WINDOW:C154


//End Credits
