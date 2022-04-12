//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/11/16, 13:23:21
// ----------------------------------------------------
// Method: Bonus_Report_Multiplier
// Description
// 
//
// Parameters
// ----------------------------------------------------
// Script cleaned 20160802
//Script Bonus Report Multiplier 20131231

C_REAL:C285(vrA; vrB; vrC; vrD; vrE; vrF; vrMultiplier; vrX)

vrMultiplier:=0

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
				
			: (([InvoiceLine:54]marginPerCent:55>=20) & ([InvoiceLine:54]marginPerCent:55<=36))
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