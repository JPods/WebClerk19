//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/11/16, 13:23:36
// ----------------------------------------------------
// Method: Bonus_Report_Sales
// Description
// 
//
// Parameters
// ----------------------------------------------------

// Script cleaned 20160809
//Script Bonus Report Sales 20160809
//09/04/2012 10:59 - added 5% Range
//06/11/2013 added GroupID, ProductMapping, DateShipped, DateCode
//06/13/2013 State, Year, moved select folder to end of input section

C_LONGINT:C283(vi1; vi2; vi3; viFound; viIndex; <>tcDecimalUP)
C_REAL:C285(vrGross; vrMiscCredit; vrMultiplier; vrRepairs; vrSales; vrSales2; vrSales2Net; vrSales3; vrSales3Net; vrSales4; vrSales4Net; vrSales5; vrSales5Net; vrSales6; vrSales6Net; vrSalesMisc)
C_TEXT:C284(vtClass; vtDateCode; vtElapsed; vtGroupID; vtMiscItemNum; vtMonth; vtPercent; vtPrefix; vtRemain; vtYear)
C_TIME:C306(vhElapsed; vhNow; vhPer; vhRemain; vhStartTime)

ERASE WINDOW:C160
GOTO XY:C161(3; 3)

vhStartTime:=Current time:C178

vi2:=Records in selection:C76([InvoiceLine:54])
FIRST RECORD:C50([InvoiceLine:54])
For (vi1; 1; vi2)
	
	vhNow:=Current time:C178
	vhElapsed:=vhNow-vhStartTime
	vtElapsed:=String:C10(vhElapsed)
	vhPer:=vhElapsed/vi1
	vhRemain:=(vi2-vi1)*vhPer
	vtRemain:=Time string:C180(vhRemain)
	vtPercent:=String:C10(Round:C94(vi1/vi2*100; 0))+"%"
	
	ERASE WINDOW:C160
	GOTO XY:C161(3; 3)
	MESSAGE:C88(" Record "+String:C10(vi1)+" of "+String:C10(vi2)+" "+vtPercent)
	GOTO XY:C161(3; 5)
	MESSAGE:C88("Elapsed Time - "+vtElapsed+" Remaining - "+vtRemain)
	
	QUERY:C277([Item:4]; [Item:4]itemNum:1=[InvoiceLine:54]itemNum:4)
	
	vi3:=Records in selection:C76([Item:4])
	
	If (vi3=1)  //Item Number Found
		FIRST RECORD:C50([Item:4])
		
		//Correct missing information in InvoiceLines
		
		If ([InvoiceLine:54]profile1:30="")
			[InvoiceLine:54]profile1:30:=[Item:4]profile1:35
			SAVE RECORD:C53([InvoiceLine:54])
		End if 
		If ([InvoiceLine:54]profile2:31="")
			[InvoiceLine:54]profile2:31:=[Item:4]profile2:36
			SAVE RECORD:C53([InvoiceLine:54])
		End if 
		If ([InvoiceLine:54]profile3:32="")
			[InvoiceLine:54]profile3:32:=[Item:4]profile3:37
			SAVE RECORD:C53([InvoiceLine:54])
		End if 
		If ([InvoiceLine:54]profile4:33="")
			[InvoiceLine:54]profile4:33:=[Item:4]profile4:38
			SAVE RECORD:C53([InvoiceLine:54])
		End if 
		If ([InvoiceLine:54]glCost:58="")
			[InvoiceLine:54]glCost:58:=[Item:4]costGLAccount:22
			SAVE RECORD:C53([InvoiceLine:54])
		End if 
		If ([InvoiceLine:54]glInventory:57="")
			[InvoiceLine:54]glInventory:57:=[Item:4]inventoryGlAccount:23
			SAVE RECORD:C53([InvoiceLine:54])
		End if 
		If ([InvoiceLine:54]glSales:56="")
			[InvoiceLine:54]glSales:56:=[Item:4]salesGlAccount:21
			SAVE RECORD:C53([InvoiceLine:54])
		End if 
		
		If ([InvoiceLine:54]idNum:47=0)
			
			SAVE RECORD:C53([InvoiceLine:54])
		End if 
		If (([InvoiceLine:54]margin:54=0) | ([InvoiceLine:54]marginPerCent:55=0))
			If ([InvoiceLine:54]margin:54=0)
				[InvoiceLine:54]margin:54:=[InvoiceLine:54]extendedPrice:11-[InvoiceLine:54]extendedCost:13
			End if 
			[InvoiceLine:54]marginPerCent:55:=Round:C94([InvoiceLine:54]margin:54/[InvoiceLine:54]extendedPrice:11*100; <>tcDecimalUP)
			SAVE RECORD:C53([InvoiceLine:54])
		End if 
		
		
		//Execute_TallyMaster ("Multiplier";"Bonus_Report";3)  //calculate multiplier
		Bonus_Report_Multiplier
		
		//Apply Multiplier
		
		Case of 
			: ([InvoiceLine:54]profile4:33="2-HA-LPC")
				
				vrGross:=vrGross+([InvoiceLine:54]extendedPrice:11*1)
				vrSales:=vrSales+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				vrSales2:=vrSales2+([InvoiceLine:54]extendedPrice:11*1)
				vrSales2Net:=vrSales2Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				
			: ([InvoiceLine:54]profile4:33="3-HA-HPC")
				
				vrGross:=vrGross+([InvoiceLine:54]extendedPrice:11*1)
				vrSales:=vrSales+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				vrSales3:=vrSales3+([InvoiceLine:54]extendedPrice:11*1)
				vrSales3Net:=vrSales3Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				
			: ([InvoiceLine:54]profile4:33="4-LA-HPC")
				
				vrGross:=vrGross+([InvoiceLine:54]extendedPrice:11*1)
				vrSales:=vrSales+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				vrSales4:=vrSales4+([InvoiceLine:54]extendedPrice:11*1)
				vrSales4Net:=vrSales4Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				
			: ([InvoiceLine:54]profile4:33="5-NA-HPC")
				
				vrGross:=vrGross+([InvoiceLine:54]extendedPrice:11*1)
				vrSales:=vrSales+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				vrSales5:=vrSales5+([InvoiceLine:54]extendedPrice:11*1)
				vrSales5Net:=vrSales5Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				
			: ([InvoiceLine:54]profile4:33="6-NA-NPC")
				
				vrGross:=vrGross+([InvoiceLine:54]extendedPrice:11*1)
				vrSales:=vrSales+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				vrSales6:=vrSales6+([InvoiceLine:54]extendedPrice:11*1)
				vrSales6Net:=vrSales6Net+Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)
				
				
			Else 
				ADD TO SET:C119([Item:4]; "No_Profile4")
				ADD TO SET:C119([InvoiceLine:54]; "Misc")
				vrGross:=vrGross+([InvoiceLine:54]extendedPrice:11*1)
				vrSales:=vrSales+([InvoiceLine:54]extendedPrice:11*0)  //vrMultiplier = 0
				vrSalesMisc:=vrSalesMisc+([InvoiceLine:54]extendedPrice:11)
				vtMiscItemNum:=[InvoiceLine:54]itemNum:4
				If (([InvoiceLine:54]itemNum:4="Credit") | ([InvoiceLine:54]itemNum:4="Rebate"))
					vrMiscCredit:=vrMiscCredit+([InvoiceLine:54]extendedPrice:11*1)
				End if 
				
		End case 
		
		
		SAVE RECORD:C53([InvoiceLine:54])
		
		If ([Item:4]class:92#"")
			vtClass:=[Item:4]class:92
		Else 
			
			//Additional Information 20130611
			//Product Mapping
			
			QUERY:C277([GenericChild2:91]; [GenericChild2:91]purpose:4="ProductMapping"; *)
			QUERY:C277([GenericChild2:91]; [GenericChild2:91]itemNum:43=[Item:4]itemNum:1; *)
			QUERY:C277([GenericChild2:91])
			
			viFound:=Records in selection:C76([GenericChild2:91])
			
			If (viFound=0)
				vtClass:="N/A"
			Else 
				vtClass:=[GenericChild2:91]a02:29
			End if 
			
			vtPrefix:=Substring:C12([Item:4]itemNum:1; 1; 2)
			viIndex:=Find in array:C230(atPartPrefix; vtPrefix)
			
			If ((viIndex>0) & (viFound=0))
				vtClass:=atPartType{viIndex}
				CREATE RECORD:C68([GenericChild2:91])
				
				[GenericChild2:91]name:3:=[Item:4]itemNum:1
				[GenericChild2:91]purpose:4:="ProductMapping"
				[GenericChild2:91]itemNum:43:=[Item:4]itemNum:1
				[GenericChild2:91]a01:28:=[Item:4]mfrItemNum:39
				[GenericChild2:91]a02:29:=vtClass
				[GenericChild2:91]a05:27:=[Item:4]description:7
				SAVE RECORD:C53([GenericChild2:91])
			End if 
			UNLOAD RECORD:C212([GenericChild2:91])
			
			[Item:4]class:92:=vtClass
			SAVE RECORD:C53([Item:4])
			
		End if 
		
		// Get GroupID
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[InvoiceLine:54]customerID:2)
		vtGroupID:=[Customer:2]profile5:30
		UNLOAD RECORD:C212([Customer:2])
		
		QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=[InvoiceLine:54]idNumInvoice:1)
		
		vtMonth:=String:C10(Month of:C24([InvoiceLine:54]dateShipped:25); "00")
		vtYear:=String:C10(Year of:C25([InvoiceLine:54]dateShipped:25); "0000")
		vtDateCode:="'"+vtYear+vtMonth
		
		APPEND TO ARRAY:C911(atUniqueID; String:C10([InvoiceLine:54]idNum:47))
		APPEND TO ARRAY:C911(atcustomerID; [InvoiceLine:54]customerID:2)
		APPEND TO ARRAY:C911(atGroupID; vtGroupID)  //### jwm ### 20130611_1557
		APPEND TO ARRAY:C911(atTypeSale; [InvoiceLine:54]typeSale:27)
		APPEND TO ARRAY:C911(atInvoiceNum; String:C10([InvoiceLine:54]idNumInvoice:1))
		APPEND TO ARRAY:C911(atDateShipped; String:C10([InvoiceLine:54]dateShipped:25; 1))  //### jwm ### 20130611_1624
		APPEND TO ARRAY:C911(atDateCode; vtDateCode)  //### jwm ### 20130611_1624
		APPEND TO ARRAY:C911(atYear; vtYear)  //### jwm ### 20130613_0852 for pivot tables by year
		APPEND TO ARRAY:C911(atItemNum; [InvoiceLine:54]itemNum:4)
		APPEND TO ARRAY:C911(atAltItem; [InvoiceLine:54]itemNumAlt:29)
		APPEND TO ARRAY:C911(atClass; vtClass)  //### jwm ### 20130611_1625
		APPEND TO ARRAY:C911(atQtyShip; String:C10([InvoiceLine:54]qty:7))
		APPEND TO ARRAY:C911(atUnitPrice; String:C10([InvoiceLine:54]unitPrice:9))
		APPEND TO ARRAY:C911(atDiscount; String:C10([InvoiceLine:54]discount:10))
		APPEND TO ARRAY:C911(atDiscountPrice; String:C10([InvoiceLine:54]discountedPrice:59))
		APPEND TO ARRAY:C911(atExtPrice; String:C10([InvoiceLine:54]extendedPrice:11))
		APPEND TO ARRAY:C911(atExtCost; String:C10([InvoiceLine:54]extendedCost:13))
		APPEND TO ARRAY:C911(atMargin; String:C10([InvoiceLine:54]margin:54))
		APPEND TO ARRAY:C911(atMarginPercent; String:C10([InvoiceLine:54]marginPerCent:55))
		APPEND TO ARRAY:C911(atProfile1; [InvoiceLine:54]profile1:30)
		APPEND TO ARRAY:C911(atProfile4; [InvoiceLine:54]profile4:33)
		APPEND TO ARRAY:C911(atPenalty; String:C10([InvoiceLine:54]profileReal1:61))
		APPEND TO ARRAY:C911(atGLSales; [InvoiceLine:54]glSales:56)
		APPEND TO ARRAY:C911(atAdjustedAmount; String:C10(Round:C94(([InvoiceLine:54]extendedPrice:11*vrMultiplier); 2)))
		APPEND TO ARRAY:C911(atAdjustedPercent; String:C10(vrMultiplier))
		APPEND TO ARRAY:C911(atRange; String:C10((Round:C94((vrMultiplier*100/5); 0)*5)))
		APPEND TO ARRAY:C911(atCity; [Invoice:26]city:10)  //### jwm ### 20130912_0302
		APPEND TO ARRAY:C911(atState; [Invoice:26]state:11)  //### jwm ### 20130912_0302
		APPEND TO ARRAY:C911(atCountry; [Invoice:26]country:13)  //### jwm ### 20130912_0302
		
		UNLOAD RECORD:C212([Invoice:26])
		
		//Repairs
		If ([InvoiceLine:54]itemNum:4="R-@")
			vrRepairs:=vrRepairs+([InvoiceLine:54]qty:7*[InvoiceLine:54]unitPrice:9)
		End if 
		
	End if   //Item Number Found
	
	NEXT RECORD:C51([InvoiceLine:54])
End for 

ERASE WINDOW:C160
CLOSE WINDOW:C154
