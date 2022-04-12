//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/11/16, 13:23:11
// ----------------------------------------------------
// Method: Bonus_Report_Main
// Description
// 
//
// Parameters
// ----------------------------------------------------

// Script cleaned 20160809
// script  Bonus Report Main 20160809
// 09/04/2012 10:59 - added 5% Range
// 12/03/2012 12:52 - added vrSalesMisc to vrSubSales
// 06/11/2013 added GroupID, ProductMapping, DateShipped, DateCode, 1 page layout
// updated Positive and negative number formatting
// 11/03/2014 12:55 - increased column spacing len2 to 10
// 11/03/2014 13:30 - extended vtLine
// 09/08/2015 16:43 - added "_" underscore to file name for readability
// 08/09/2016; 11:47 - declared all variables

C_BOOLEAN:C305(vbReadOnly)
C_DATE:C307(vdBegin; vdEnd)
C_LONGINT:C283(viIndex; viFound; vi1; vi2; viAddSpace; viLen1; viLen2; viRecords)
C_REAL:C285(vrAdjustments; vrCredit; vrCreditMisc; vrCreditMiscNet; vrCreditMiscPercent; vrCreditNet)
C_REAL:C285(vrCreditPercent; vrCreditPercentX1; vrCreditPercentX10; vrCreditPercentX2; vrCreditPercentX3)
C_REAL:C285(vrCreditPercentX4; vrCreditPercentX6; vrCreditX1; vrWriteOff)
C_REAL:C285(vrCreditX4; vrCreditX4Net; vrCreditX6; vrCreditX6Net; vrGross; vrInventory; vrMiscCredit; vrNet)
C_REAL:C285(vrCreditX10; vrCreditX10Net; vrCreditX1Net; vrCreditX2; vrCreditX2Net; vrCreditX3; vrCreditX3Net)
C_REAL:C285(vrPenalty; vrPercent; vrPercent2; vrPercent3; vrPercent4; vrPercent5; vrPercent6; vrRCWO)
C_REAL:C285(vrRepairs; vrSales; vrSales2; vrsales2Net; vrSales3; vrSales3Net; vrSales4; vrSales4Net; vrSales5)
C_REAL:C285(vrSales5Net; vrSales6; vrSales6Net; vrSalesMisc; vrSalesMiscNet; vrSalesMiscPercent; vrSalesNet)
C_REAL:C285(vrSamples; vrSamples2; vrSamples2Net; vrSamples3; vrSamples3Net; vrSamples4; vrSamples4Net)
C_REAL:C285(vrSamples5; vrSamples5Net; vrSamples6; vrSamples6Net; vrSamplesMisc; vrSamplesMiscNet)
C_REAL:C285(vrSamplesMiscPercent; vrSamplesNet; vrSamplesNetNeg; vrSamplesPercent; vrSamplesPercent2)
C_REAL:C285(vrSamplesPercent3; vrSamplesPercent4; vrSamplesPercent5; vrSamplesPercent6; vrSubNet; vrSubSales)
C_TEXT:C284(vTab; vtAdjustments; vtBegin; vtClass; vtCredit; vtCreditMisc; vtCreditMiscNet; vtCreditMiscPercent)
C_TEXT:C284(vtCreditNet; vtCreditPercent; vtCreditPercentX1; vtCreditPercentX10; vtCreditPercentX2)
C_TEXT:C284(vtCreditPercentX3; vtCreditPercentX4; vtCreditPercentX6; vtCreditX1; vtCreditX10; vtCreditX10Net)
C_TEXT:C284(vtCreditX1Net; vtCreditX2; vtCreditX2Net; vtCreditX3; vtCreditX3Net; vtCreditX4; vtCreditX4Net)
C_TEXT:C284(vtCreditX6; vtCreditX6Net; vtDateCode; vtDateTime; vtDoc; vtDoubleLine; vtEnd; vText1; vtFooter)
C_TEXT:C284(vtFormat1; vtFormat2; vtGross; vtGroupID; vtHeader; vtHeaderP1; vtInventory; vtLine; vtMiscCredit)
C_TEXT:C284(vtMiscItemNum; vtMonth; vtMonthName; vtMyDate; vtMyName; vtMyTime; vtMyYear; vtNet; vtPage1; vtPage2)
C_TEXT:C284(vtPercent; vtPercent2; vtPercent3; vtPercent4; vtPercent5; vtPercent6; vtPrefix; vtRCWO; vtRemain)
C_TEXT:C284(vtRepairs; vtSales; vtSales2; vtSales2Net; vtSales3; vtSales3Net; vtSales4; vtSales4Net; vtSales5)
C_TEXT:C284(vtSales5Net; vtSales6; vtSales6Net; vtSalesMisc; vtSalesMiscNet; vtSalesMiscPercent; vtSalesNet)
C_TEXT:C284(vtSamples; vtSamples2; vtSamples2Net; vtSamples3; vtSamples3Net; vtSamples4; vtSamples4Net)
C_TEXT:C284(vtSamples5; vtSamples5Net; vtSamples6; vtSamples6Net; vtSamplesMisc; vtSamplesMiscNet)
C_TEXT:C284(vtSamplesMiscPercent; vtSamplesNet; vtSamplesNetNeg; vtSamplesPercent; vtSamplesPercent2)
C_TEXT:C284(vtSamplesPercent3; vtSamplesPercent4; vtSamplesPercent5; vtSamplesPercent6; vtSubNet)
C_TEXT:C284(vtSubSales; vtTheMonth; vtWriteOff; vtYear; vCR; vFF)
C_TEXT:C284(vtYear; vtMonth; vtPrefix; vtDateCode; vtGroupID; vtClass; vtRemain; vtPercent)
C_TIME:C306(vhNow; vhElapsed; vhStartTime; vhPer; vhRemain)

// rebuild check this ******

ARRAY TEXT:C222(atPartPrefix; 34)
ARRAY TEXT:C222(atPartType; 34)

atPartPrefix{1}:="12"
atPartPrefix{2}:="13"
atPartPrefix{3}:="14"
atPartPrefix{4}:="15"
atPartPrefix{5}:="17"
atPartPrefix{6}:="18"
atPartPrefix{7}:="21"
atPartPrefix{8}:="23"
atPartPrefix{9}:="24"
atPartPrefix{10}:="25"
atPartPrefix{11}:="28"
atPartPrefix{12}:="29"
atPartPrefix{13}:="31"
atPartPrefix{14}:="32"
atPartPrefix{15}:="39"
atPartPrefix{16}:="40"
atPartPrefix{17}:="41"
atPartPrefix{18}:="45"
atPartPrefix{19}:="47"
atPartPrefix{20}:="48"
atPartPrefix{21}:="51"
atPartPrefix{22}:="52"
atPartPrefix{23}:="53"
atPartPrefix{24}:="56"
atPartPrefix{25}:="60"
atPartPrefix{26}:="61"
atPartPrefix{27}:="62"
atPartPrefix{28}:="63"
atPartPrefix{29}:="64"
atPartPrefix{30}:="65"
atPartPrefix{31}:="66"
atPartPrefix{32}:="R-"
atPartPrefix{33}:="B-"
atPartPrefix{34}:="RF"

atPartType{1}:="Antennas"
atPartType{2}:="AUDIO EQUIPMENT & ACCESSORIES (HORNS & SPEAKERS)"
atPartType{3}:="CABINETS"
atPartType{4}:="CAPACITORS"
atPartType{5}:="CIRCUIT BOARDS prior to 4/14/09"
atPartType{6}:="COILS"
atPartType{7}:="CONNECTORS"
atPartType{8}:="RESONATORS & Crystals"
atPartType{9}:="PANEL COMP."
atPartType{10}:="Mech. Components in-house"
atPartType{11}:="HARDWARE"
atPartType{12}:="Test & Measurement Equipment"
atPartType{13}:="INSULATORS"
atPartType{14}:="MATERIALS"
atPartType{15}:="PACKING Boxes & Labels"
atPartType{16}:="POWER SUPPLIES / BATTERIES"
atPartType{17}:="Solder Paste stencil followed by PCB number"
atPartType{18}:="RELAYS"
atPartType{19}:="RESISTORS"
atPartType{20}:="SEMICONDUCTORS"
atPartType{21}:="SWITCHES FUSES & CIRCUIT BREAKERS"
atPartType{22}:="CLOCKS"
atPartType{23}:="THERMOSTATS"
atPartType{24}:="TRANSFORMERS"
atPartType{25}:="WIRE/CABLE"
atPartType{26}:="RESALE MATERIAL"
atPartType{27}:="Schematics prior to 4/14/09"
atPartType{28}:="Mechanical Drawing Numbers"
atPartType{29}:="Production Procedures"
atPartType{30}:="open"
atPartType{31}:="Schematics and PCB layouts using Eagle software"
atPartType{32}:="REPAIR"
atPartType{33}:="BOOKS"
atPartType{34}:="REFURBISH"

CREATE EMPTY SET:C140([Item:4]; "No_Profile4")
CREATE EMPTY SET:C140([InvoiceLine:54]; "Misc")

vrSales:=0
vrCredit:=0
vrSubNet:=0
vrNet:=0
vrGross:=0
vrSamples:=0
vrRepairs:=0
vrWriteOff:=0  //write off was 10,000.00, then 4982.21

vrSalesMisc:=0
vrSalesMiscNet:=0
vrMiscCredit:=0

vrSales2:=0
vrSales3:=0
vrSales4:=0
vrSales5:=0
vrSales6:=0
vrSales2Net:=0
vrSales3Net:=0
vrSales4Net:=0
vrSales5Net:=0
vrSales6Net:=0
vrSubSales:=0

vrSamples:=0
vrSamplesNet:=0
vrSamples2:=0
vrSamples3:=0
vrSamples4:=0
vrSamples5:=0
vrSamples6:=0

vrSamples2Net:=0
vrSamples3Net:=0
vrSamples4Net:=0
vrSamples5Net:=0
vrSamples6Net:=0
vrSamplesMisc:=0
vrSamplesMiscNet:=0
vrSamplesNetNeg:=0

vrCredit:=0
vrCreditNet:=0
vrCreditX1:=0
vrCreditX2:=0
vrCreditX3:=0
vrCreditX4:=0
vrCreditX6:=0
vrCreditX10:=0

vrCreditX1Net:=0
vrCreditX2Net:=0
vrCreditX3Net:=0
vrCreditX4Net:=0
vrCreditX6Net:=0
vrCreditX10Net:=0

vrCreditMisc:=0
vrCreditMiscNet:=0
vrPenalty:=0

vrRCWO:=0
vtRCWO:=""
vrInventory:=0
vtInventory:=""
vrAdjustments:=0
vtAdjustments:=""

vtMiscItemNum:=""
vtPage1:=""
vtPage2:=""
vtFooter:=""

vCR:=Char:C90(13)
vTab:=Char:C90(9)
vFF:=Char:C90(12)
vtLine:="_"*72
vtLine:="="*64  //reformat line ### jwm ### 20120130
vtDoubleLine:="="*64
vhStartTime:=Current time:C178

//Audit Log
ARRAY TEXT:C222(atUniqueID; 0)
ARRAY TEXT:C222(atcustomerID; 0)
ARRAY TEXT:C222(atGroupID; 0)  //### jwm ### 20130611_1606 Customer Grouping
ARRAY TEXT:C222(atTypeSale; 0)
ARRAY TEXT:C222(atInvoiceNum; 0)
ARRAY TEXT:C222(atDateShipped; 0)  //### jwm ### 20130611_1607 for pivot table reports with dates
ARRAY TEXT:C222(atDateCode; 0)  //### jwm ### 20130611_1607 for pivot table reports by Month
ARRAY TEXT:C222(atYear; 0)  //### jwm ### 20130613_0852 for pivot tables by year
ARRAY TEXT:C222(atItemNum; 0)
ARRAY TEXT:C222(atAltItem; 0)  //### jwm ### 20130912_0213 alternate item number
ARRAY TEXT:C222(atClass; 0)  //### jwm ### 20130611_1608 Product Mapping
ARRAY TEXT:C222(atQtyShip; 0)
ARRAY TEXT:C222(atUnitPrice; 0)
ARRAY TEXT:C222(atDiscount; 0)
ARRAY TEXT:C222(atDiscountPrice; 0)
ARRAY TEXT:C222(atExtPrice; 0)
ARRAY TEXT:C222(atExtCost; 0)
ARRAY TEXT:C222(atMargin; 0)
ARRAY TEXT:C222(atMarginPercent; 0)
ARRAY TEXT:C222(atProfile1; 0)
ARRAY TEXT:C222(atProfile4; 0)
ARRAY TEXT:C222(atPenalty; 0)
ARRAY TEXT:C222(atGLSales; 0)
ARRAY TEXT:C222(atAdjustedAmount; 0)
ARRAY TEXT:C222(atAdjustedPercent; 0)
ARRAY TEXT:C222(atRange; 0)
ARRAY TEXT:C222(atCity; 0)  //### jwm ### 20130912_0211 ShipTo City
ARRAY TEXT:C222(atState; 0)  //### jwm ### 20130912_0211 ShipTo State
ARRAY TEXT:C222(atCountry; 0)  //### jwm ### 20130912_0211 ShipTo Country


vtFormat1:="###,###,##0.00"
viLen1:=13

vtFormat2:=" ###,##0.00%"
viLen2:=10

ARRAY TEXT:C222(atTheMonth; 12)
atTheMonth{1}:="January"
atTheMonth{2}:="February"
atTheMonth{3}:="March"
atTheMonth{4}:="April"
atTheMonth{5}:="May"
atTheMonth{6}:="June"
atTheMonth{7}:="July"
atTheMonth{8}:="August"
aTtheMonth{9}:="September"
atTheMonth{10}:="October"
atTheMonth{11}:="November"
atTheMonth{12}:="December"

If (Day of:C23(Current date:C33)>7)  //last half of the Month, changed to first week
	SOM:=Current date:C33-Day of:C23(Current date:C33)+1
	EOM:=Add to date:C393(SOM; 0; 1; -1)
Else 
	SOM:=Current date:C33-Day of:C23(Current date:C33)+1
	SOM:=Add to date:C393(SOM; 0; -1; 0)
	EOM:=Current date:C33-Day of:C23(Current date:C33)
End if 

vtTheMonth:=atTheMonth{Month of:C24(SOM)}
vtMonthName:=Request:C163("Enter the Month"; vtTheMonth; "Enter")

vtBegin:=Request:C163("Enter Beginning Date"; String:C10(SOM); "Enter")
If (vtBegin="")
	ALERT:C41("Invalid Beginning Date")
	ABORT:C156
End if 
vdBegin:=Date:C102(vtBegin)
If (vdBegin=!00-00-00!)
	ALERT:C41("Invalid Beginning Date")
	ABORT:C156
End if 

vtEnd:=Request:C163("Enter Ending Date"; String:C10(EOM); "Enter")
If (vtEnd="")
	ALERT:C41("Invalid Ending Date")
	ABORT:C156
End if 
vdEnd:=Date:C102(vtEnd)
If (vdEnd=!00-00-00!)
	ALERT:C41("Invalid Ending Date")
	ABORT:C156
End if 

vtMyYear:=String:C10(Year of:C25(vdBegin); "####")

vtDateCode:=String:C10(Year of:C25(vdBegin))+String:C10(Month of:C24(vdBegin); "00")

QUERY:C277([GenericChild1:90]; [GenericChild1:90]name:3="BonusReport"; *)
QUERY:C277([GenericChild1:90];  & ; [GenericChild1:90]purpose:4=vtDateCode; *)
QUERY:C277([GenericChild1:90])
viRecords:=Records in selection:C76([GenericChild1:90])

Case of 
	: (viRecords=0)
		CREATE RECORD:C68([GenericChild1:90])
		[GenericChild1:90]name:3:="BonusReport"
		[GenericChild1:90]purpose:4:=vtDateCode
		
	: (viRecords=1)
		FIRST RECORD:C50([GenericChild1:90])
		
	: (viRecords>1)
		FIRST RECORD:C50([GenericChild1:90])
		ALERT:C41("More Than One Bonus Report Archive Found")
		
End case 

//[GenericChild1]R01 = Rebates & Commissions
//[GenericChild1]R02 = Inventory
//[GenericChild1]R03 = Adjustments

vtRCWO:=String:C10([GenericChild1:90]r01:18; vtFormat1)
vtInventory:=String:C10([GenericChild1:90]r02:19; vtFormat1)
vtAdjustments:=String:C10([GenericChild1:90]r03:20; vtFormat1)

vtRCWO:=Request:C163("Enter Rebates Commissions & Write Offs"; vtRCWO; "Enter")
vrRCWO:=Num:C11(vtRCWO)
vrRCWO:=Round:C94(vrRCWO; 2)
vrRCWO:=Abs:C99(vrRCWO)*-1  //### jwm ### 20120301 format number as negative
vtRCWO:=String:C10(vrRCWO; vtFormat1)
vtRCWO:="$"+(" "*(viLen1-(Length:C16(vtRCWO))))+vtRCWO

If ([GenericChild1:90]r01:18#Abs:C99(vrRCWO))
	CONFIRM:C162("Replace Rebates & Commissions "+String:C10([GenericChild1:90]r01:18)+" With "+String:C10(Abs:C99(vrRCWO)); "Replace"; "Cancel")
	If (OK=1)
		[GenericChild1:90]r01:18:=Abs:C99(vrRCWO)
		SAVE RECORD:C53([GenericChild1:90])
	End if 
End if 

vtInventory:=Request:C163("Enter Inventory Adjustments"; vtInventory; "Enter")
vrInventory:=Num:C11(vtInventory)
vrInventory:=Round:C94(vrInventory; 2)
vrInventory:=Abs:C99(vrInventory)*-1  //### jwm ### 20120301 format number as negative
vtInventory:=String:C10(vrInventory; vtFormat1)
vtInventory:="$"+(" "*(viLen1-(Length:C16(vtInventory))))+vtInventory

If ([GenericChild1:90]r02:19#Abs:C99(vrInventory))
	CONFIRM:C162("Replace Inventory Adjustments"+String:C10([GenericChild1:90]r02:19)+" With "+String:C10(Abs:C99(vrInventory)); "Replace"; "Cancel")
	If (OK=1)
		[GenericChild1:90]r02:19:=Abs:C99(vrInventory)
		SAVE RECORD:C53([GenericChild1:90])
	End if 
End if 

vtAdjustments:=Request:C163("Enter Any Additional Adjustments"; vtAdjustments; "Enter")
CONFIRM:C162("Select Positive or Negative Adjustment"; " Negative "; " Positive ")
vrAdjustments:=Num:C11(vtAdjustments)
If (OK=1)  // Negative adjustment
	vrAdjustments:=Abs:C99(vrAdjustments)*-1  //  ### jwm ### 20140501_1337 format number as negative
Else 
	vrAdjustments:=Abs:C99(vrAdjustments)  //  ### jwm ### 20140501_1337 format number as positive
End if 
vrAdjustments:=Round:C94(vrAdjustments; 2)
vtAdjustments:=String:C10(vrAdjustments; vtFormat1)
vtAdjustments:="$"+(" "*(viLen1-(Length:C16(vtAdjustments))))+vtAdjustments

If ([GenericChild1:90]r03:20#vrAdjustments)
	CONFIRM:C162("Replace Additional Adjustments "+String:C10([GenericChild1:90]r03:20)+" With "+String:C10(vrAdjustments); "Replace"; "Cancel")
	If (OK=1)
		[GenericChild1:90]r03:20:=vrAdjustments
		SAVE RECORD:C53([GenericChild1:90])
	End if 
End if 

//### jwm ### 20130613_0902 moved to beginning of report with other startup questions
TheFolder:=Select folder:C670("Select location to save report")

QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]dateShipped:25>=vdBegin; *)
QUERY:C277([InvoiceLine:54];  & [InvoiceLine:54]dateShipped:25<=vdEnd; *)
QUERY:C277([InvoiceLine:54])

If (Read only state:C362([InvoiceLine:54]))
	READ WRITE:C146([InvoiceLine:54])
	vbReadOnly:=True:C214
Else 
	vbReadOnly:=False:C215
End if 

//Execute_TallyMaster ("Sales";"Bonus_Report";3)
//Execute_TallyMaster ("Samples";"Bonus_Report";3)
//Execute_TallyMaster ("Credits";"Bonus_Report";3)

Bonus_Report_Sales
Bonus_Report_Samples
Bonus_Report_Credits

//set InvoiceLines back to Read Only if needed
If (vbReadOnly=True:C214)
	READ ONLY:C145([InvoiceLine:54])
	vbReadOnly:=True:C214
Else 
	vbReadOnly:=False:C215
End if 


vrSalesMisc:=Round:C94(vrSalesMisc; 2)
vtSalesMisc:=String:C10(vrSalesMisc; vtFormat1)
vtSalesMisc:="$"+(" "*(viLen1-(Length:C16(vtSalesMisc))))+vtSalesMisc

vrSalesMiscNet:=0
vtSalesMiscNet:=String:C10(vrSalesMiscNet; vtFormat1)
vtSalesMiscNet:="$"+(" "*(viLen1-(Length:C16(vtSalesMiscNet))))+vtSalesMiscNet

vrMiscCredit:=Round:C94(vrMiscCredit; 2)
vtMiscCredit:=String:C10(vrMiscCredit; vtFormat1)
vtMiscCredit:="$"+(" "*(viLen1-(Length:C16(vtMiscCredit))))+vtMiscCredit

vrSamplesMiscNet:=0
vtSamplesMiscNet:=String:C10(vrSamplesMiscNet; vtFormat1)
vtSamplesMiscNet:="$"+(" "*(viLen1-(Length:C16(vtSamplesMiscNet))))+vtSamplesMiscNet

vrSamples:=Round:C94(vrSamples; 2)
vtSamples:=String:C10(vrSamples; vtFormat1)
vtSamples:="$"+(" "*(viLen1-(Length:C16(vtSamples))))+vtSamples

vrRepairs:=vrRepairs*6
vrRepairs:=Round:C94(vrRepairs; 2)
vtRepairs:=String:C10(vrRepairs; vtFormat1)
vtRepairs:="$"+(" "*(viLen1-(Length:C16(vtRepairs))))+vtRepairs

vrWriteOff:=Round:C94(vrWriteOff; 2)
vtWriteOff:=String:C10(vrWriteOff; vtFormat1)
vtWriteOff:="$"+(" "*(viLen1-(Length:C16(vtWriteOff))))+vtWriteOff

vrGross:=Round:C94(vrGross; 2)
vtGross:=String:C10(vrGross; vtFormat1)
vtGross:="$"+(" "*(viLen1-(Length:C16(vtGross))))+vtGross

vrSales:=Round:C94(vrSales; 2)
vtSales:=String:C10(vrSales; vtFormat1)
vtSales:="$"+(" "*(viLen1-(Length:C16(vtSales))))+vtSales

vrCredit:=Round:C94(vrCredit; 2)
vtCredit:=String:C10(vrCredit; vtFormat1)
vtCredit:="$"+(" "*(viLen1-(Length:C16(vtCredit))))+vtCredit

vrSubNet:=vrSales+vrCredit-vrRepairs-vrSamples-vrWriteOff
vtSubNet:=String:C10(vrSubNet; vtFormat1)
vtSubNet:="$"+(" "*(viLen1-(Length:C16(vtSubNet))))+vtSubNet

vrNet:=(vrsales2Net+vrSales3Net+vrSales4Net+vrSales5Net+vrSales6Net)
vtNet:=String:C10(vrNet; vtFormat1)
vtNet:="$"+(" "*(viLen1-(Length:C16(vtNet))))+vtNet

vrSales2:=Round:C94(vrSales2; 2)
vtSales2:=String:C10(vrSales2; vtFormat1)
vtSales2:="$"+(" "*(viLen1-(Length:C16(vtSales2))))+vtSales2

vrSales3:=Round:C94(vrSales3; 2)
vtSales3:=String:C10(vrSales3; vtFormat1)
vtSales3:="$"+(" "*(viLen1-(Length:C16(vtSales3))))+vtSales3

vrSales4:=Round:C94(vrSales4; 2)
vtSales4:=String:C10(vrSales4; vtFormat1)
vtSales4:="$"+(" "*(viLen1-(Length:C16(vtSales4))))+vtSales4

vrSales5:=Round:C94(vrSales5; 2)
vtSales5:=String:C10(vrSales5; vtFormat1)
vtSales5:="$"+(" "*(viLen1-(Length:C16(vtSales5))))+vtSales5

vrSales6:=Round:C94(vrSales6; 2)
vtSales6:=String:C10(vrSales6; vtFormat1)
vtSales6:="$"+(" "*(viLen1-(Length:C16(vtSales6))))+vtSales6

vrSales2Net:=Round:C94(vrSales2Net; 2)
vtSales2Net:=String:C10(vrSales2Net; vtFormat1)
vtSales2Net:="$"+(" "*(viLen1-(Length:C16(vtSales2Net))))+vtSales2Net

vrSales3Net:=Round:C94(vrSales3Net; 2)
vtSales3Net:=String:C10(vrSales3Net; vtFormat1)
vtSales3Net:="$"+(" "*(viLen1-(Length:C16(vtSales3Net))))+vtSales3Net

vrSales4Net:=Round:C94(vrSales4Net; 2)
vtSales4Net:=String:C10(vrSales4Net; vtFormat1)
vtSales4Net:="$"+(" "*(viLen1-(Length:C16(vtSales4Net))))+vtSales4Net

vrSales5Net:=Round:C94(vrSales5Net; 2)
vtSales5Net:=String:C10(vrSales5Net; vtFormat1)
vtSales5Net:="$"+(" "*(viLen1-(Length:C16(vtSales5Net))))+vtSales5Net

vrSales6Net:=Round:C94(vrSales6Net; 2)
vtSales6Net:=String:C10(vrSales6Net; vtFormat1)
vtSales6Net:="$"+(" "*(viLen1-(Length:C16(vtSales6Net))))+vtSales6Net

vrPercent2:=Round:C94(vrSales2Net/vrSales2*100; 2)
vtPercent2:=String:C10(vrPercent2; vtFormat2)
vtPercent2:=(" "*(viLen2-(Length:C16(vtPercent2))))+vtPercent2

vrPercent3:=Round:C94(vrSales3Net/vrSales3*100; 2)
vtPercent3:=String:C10(vrPercent3; vtFormat2)
vtPercent3:=(" "*(viLen2-(Length:C16(vtPercent3))))+vtPercent3

vrPercent4:=Round:C94(vrSales4Net/vrSales4*100; 2)
vtPercent4:=String:C10(vrPercent4; vtFormat2)
vtPercent4:=(" "*(viLen2-(Length:C16(vtPercent4))))+vtPercent4

vrPercent5:=Round:C94(vrSales5Net/vrSales5*100; 2)
vtPercent5:=String:C10(vrPercent5; vtFormat2)
vtPercent5:=(" "*(viLen2-(Length:C16(vtPercent5))))+vtPercent5

vrPercent6:=Round:C94(vrSales6Net/vrSales6*100; 2)
vtPercent6:=String:C10(vrPercent6; vtFormat2)
vtPercent6:=(" "*(viLen2-(Length:C16(vtPercent6))))+vtPercent6

vrSalesMiscPercent:=0
vtSalesMiscPercent:=String:C10(vrSalesMiscPercent; vtFormat2)
vtSalesMiscPercent:=(" "*(viLen2-(Length:C16(vtSalesMiscPercent))))+vtSalesMiscPercent

vrSamples:=Round:C94(vrSamples; 2)
vtSamples:=String:C10(vrSamples; vtFormat1)
vtSamples:="$"+(" "*(viLen1-(Length:C16(vtSamples))))+vtSamples

vrSamples2:=Round:C94(vrSamples2; 2)
vtSamples2:=String:C10(vrSamples2; vtFormat1)
vtSamples2:="$"+(" "*(viLen1-(Length:C16(vtSamples2))))+vtSamples2

vrSamples3:=Round:C94(vrSamples3; 2)
vtSamples3:=String:C10(vrSamples3; vtFormat1)
vtSamples3:="$"+(" "*(viLen1-(Length:C16(vtSamples3))))+vtSamples3

vrSamples4:=Round:C94(vrSamples4; 2)
vtSamples4:=String:C10(vrSamples4; vtFormat1)
vtSamples4:="$"+(" "*(viLen1-(Length:C16(vtSamples4))))+vtSamples4

vrSamples5:=Round:C94(vrSamples5; 2)
vtSamples5:=String:C10(vrSamples5; vtFormat1)
vtSamples5:="$"+(" "*(viLen1-(Length:C16(vtSamples5))))+vtSamples5

vrSamples6:=Round:C94(vrSamples6; 2)
vtSamples6:=String:C10(vrSamples6; vtFormat1)
vtSamples6:="$"+(" "*(viLen1-(Length:C16(vtSamples6))))+vtSamples6

vrSamplesNet:=Round:C94(vrSamplesNet; 2)
vtSamplesNet:=String:C10(vrSamplesNet; vtFormat1)
vtSamplesNet:="$"+(" "*(viLen1-(Length:C16(vtSamplesNet))))+vtSamplesNet

vrSamplesNetNeg:=vrSamplesNet*-1  //### jwm ### 20120301 format samples as negative number
vtSamplesNetNeg:=String:C10(vrSamplesNetNeg; vtFormat1)
vtSamplesNetNeg:="$"+(" "*(viLen1-(Length:C16(vtSamplesNetNeg))))+vtSamplesNetNeg

vrSamples2Net:=Round:C94(vrSamples2Net; 2)
vtSamples2Net:=String:C10(vrSamples2Net; vtFormat1)
vtSamples2Net:="$"+(" "*(viLen1-(Length:C16(vtSamples2Net))))+vtSamples2Net

vrSamples3Net:=Round:C94(vrSamples3Net; 2)
vtSamples3Net:=String:C10(vrSamples3Net; vtFormat1)
vtSamples3Net:="$"+(" "*(viLen1-(Length:C16(vtSamples3Net))))+vtSamples3Net

vrSamples4Net:=Round:C94(vrSamples4Net; 2)
vtSamples4Net:=String:C10(vrSamples4Net; vtFormat1)
vtSamples4Net:="$"+(" "*(viLen1-(Length:C16(vtSamples4Net))))+vtSamples4Net

vrSamples5Net:=Round:C94(vrSamples5Net; 2)
vtSamples5Net:=String:C10(vrSamples5Net; vtFormat1)
vtSamples5Net:="$"+(" "*(viLen1-(Length:C16(vtSamples5Net))))+vtSamples5Net

vrSamples6Net:=Round:C94(vrSamples6Net; 2)
vtSamples6Net:=String:C10(vrSamples6Net; vtFormat1)
vtSamples6Net:="$"+(" "*(viLen1-(Length:C16(vtSamples6Net))))+vtSamples6Net

vrSamplesMisc:=Round:C94(vrSamplesMisc; 2)
vtSamplesMisc:=String:C10(vrSamplesMisc; vtFormat1)
vtSamplesMisc:="$"+(" "*(viLen1-(Length:C16(vtSamplesMisc))))+vtSamplesMisc

vrSamplesPercent:=Round:C94(vrSamplesNet/vrSamples*100; 2)
vtSamplesPercent:=String:C10(vrSamplesPercent; vtFormat2)
vtSamplesPercent:=(" "*(viLen2-(Length:C16(vtSamplesPercent))))+vtSamplesPercent

vrSamplesPercent2:=Round:C94(vrSamples2Net/vrSamples2*100; 2)
vtSamplesPercent2:=String:C10(vrSamplesPercent2; vtFormat2)
vtSamplesPercent2:=(" "*(viLen2-(Length:C16(vtSamplesPercent2))))+vtSamplesPercent2

vrSamplesPercent3:=Round:C94(vrSamples3Net/vrSamples3*100; 2)
vtSamplesPercent3:=String:C10(vrSamplesPercent3; vtFormat2)
vtSamplesPercent3:=(" "*(viLen2-(Length:C16(vtSamplesPercent3))))+vtSamplesPercent3

vrSamplesPercent4:=Round:C94(vrSamples4Net/vrSamples4*100; 2)
vtSamplesPercent4:=String:C10(vrSamplesPercent4; vtFormat2)
vtSamplesPercent4:=(" "*(viLen2-(Length:C16(vtSamplesPercent4))))+vtSamplesPercent4

vrSamplesPercent5:=Round:C94(vrSamples5Net/vrSamples5*100; 2)
vtSamplesPercent5:=String:C10(vrSamplesPercent5; vtFormat2)
vtSamplesPercent5:=(" "*(viLen2-(Length:C16(vtSamplesPercent5))))+vtSamplesPercent5

vrSamplesPercent6:=Round:C94(vrSamples6Net/vrSamples6*100; 2)
vtSamplesPercent6:=String:C10(vrSamplesPercent6; vtFormat2)
vtSamplesPercent6:=(" "*(viLen2-(Length:C16(vtSamplesPercent6))))+vtSamplesPercent6

vrSamplesMiscPercent:=0
vtSamplesMiscPercent:=String:C10(vrSamplesMiscPercent; vtFormat2)
vtSamplesMiscPercent:=(" "*(viLen2-(Length:C16(vtSamplesMiscPercent))))+vtSamplesMiscPercent

vrSamplesPercent:=Round:C94(vrSamplesNet/vrSamples*100; 2)
vtSamplesPercent:=String:C10(vrSamplesPercent; vtFormat2)
vtSamplesPercent:=(" "*(viLen2-(Length:C16(vtSamplesPercent))))+vtSamplesPercent

vrCredit:=Round:C94(vrCredit; 2)
vtCredit:=String:C10(vrCredit; vtFormat1)
vtCredit:="$"+(" "*(viLen1-(Length:C16(vtCredit))))+vtCredit

vrCreditMisc:=Round:C94(vrCreditMisc; 2)
vtCreditMisc:=String:C10(vrCreditMisc; vtFormat1)
vtCreditMisc:="$"+(" "*(viLen1-(Length:C16(vtCreditMisc))))+vtCreditMisc

vrCreditMiscNet:=0
vtCreditMiscNet:=String:C10(vrCreditMiscNet; vtFormat1)
vtCreditMiscNet:="$"+(" "*(viLen1-(Length:C16(vtCreditMiscNet))))+vtCreditMiscNet

//vrCreditNet := (vrCreditX1Net + vrCreditX2Net + vrCreditX3Net + vrCreditX4Net + vrCreditX6Net)
//vtCreditNet := String(vrCreditNet;vtFormat1)
//vtCreditNet := "$"+(" "*(viLen1-(length(vtCreditNet))))+vtCreditNet

vrCreditNet:=Round:C94(vrCreditNet; 2)
vtCreditNet:=String:C10(vrCreditNet; vtFormat1)
vtCreditNet:="$"+(" "*(viLen1-(Length:C16(vtCreditNet))))+vtCreditNet

vrCreditX1:=Round:C94(vrCreditX1; 2)
vtCreditX1:=String:C10(vrCreditX1; vtFormat1)
vtCreditX1:="$"+(" "*(viLen1-(Length:C16(vtCreditX1))))+vtCreditX1

vrCreditX2:=Round:C94(vrCreditX2; 2)
vtCreditX2:=String:C10(vrCreditX2; vtFormat1)
vtCreditX2:="$"+(" "*(viLen1-(Length:C16(vtCreditX2))))+vtCreditX2

vrCreditX3:=Round:C94(vrCreditX3; 2)
vtCreditX3:=String:C10(vrCreditX3; vtFormat1)
vtCreditX3:="$"+(" "*(viLen1-(Length:C16(vtCreditX3))))+vtCreditX3

vrCreditX4:=Round:C94(vrCreditX4; 2)
vtCreditX4:=String:C10(vrCreditX4; vtFormat1)
vtCreditX4:="$"+(" "*(viLen1-(Length:C16(vtCreditX4))))+vtCreditX4

vrCreditX6:=Round:C94(vrCreditX6; 2)
vtCreditX6:=String:C10(vrCreditX6; vtFormat1)
vtCreditX6:="$"+(" "*(viLen1-(Length:C16(vtCreditX6))))+vtCreditX6

vrCreditX10:=Round:C94(vrCreditX10; 2)
vtCreditX10:=String:C10(vrCreditX10; vtFormat1)
vtCreditX10:="$"+(" "*(viLen1-(Length:C16(vtCreditX10))))+vtCreditX10

vrCreditX1Net:=Round:C94(vrCreditX1Net; 2)
vtCreditX1Net:=String:C10(vrCreditX1Net; vtFormat1)
vtCreditX1Net:="$"+(" "*(viLen1-(Length:C16(vtCreditX1Net))))+vtCreditX1Net

vrCreditX2Net:=Round:C94(vrCreditX2Net; 2)
vtCreditX2Net:=String:C10(vrCreditX2Net; vtFormat1)
vtCreditX2Net:="$"+(" "*(viLen1-(Length:C16(vtCreditX2Net))))+vtCreditX2Net

vrCreditX3Net:=Round:C94(vrCreditX3Net; 2)
vtCreditX3Net:=String:C10(vrCreditX3Net; vtFormat1)
vtCreditX3Net:="$"+(" "*(viLen1-(Length:C16(vtCreditX3Net))))+vtCreditX3Net

vrCreditX4Net:=Round:C94(vrCreditX4Net; 2)
vtCreditX4Net:=String:C10(vrCreditX4Net; vtFormat1)
vtCreditX4Net:="$"+(" "*(viLen1-(Length:C16(vtCreditX4Net))))+vtCreditX4Net

vrCreditX6Net:=Round:C94(vrCreditX6Net; 2)
vtCreditX6Net:=String:C10(vrCreditX6Net; vtFormat1)
vtCreditX6Net:="$"+(" "*(viLen1-(Length:C16(vtCreditX6Net))))+vtCreditX6Net

vrCreditX10Net:=Round:C94(vrCreditX10Net; 2)
vtCreditX10Net:=String:C10(vrCreditX10Net; vtFormat1)
vtCreditX10Net:="$"+(" "*(viLen1-(Length:C16(vtCreditX10Net))))+vtCreditX10Net

vrCreditMisc:=Round:C94(vrCreditMisc; 2)
vtCreditMisc:=String:C10(vrCreditMisc; vtFormat1)
vtCreditMisc:="$"+(" "*(viLen1-(Length:C16(vtCreditMisc))))+vtCreditMisc

vrCreditPercentX1:=Round:C94(vrCreditX1Net/vrCreditX1*100; 2)
vtCreditPercentX1:=String:C10(vrCreditPercentX1; vtFormat2)
vtCreditPercentX1:=(" "*(viLen2-(Length:C16(vtCreditPercentX1))))+vtCreditPercentX1

vrCreditPercentX2:=Round:C94(vrCreditX2Net/vrCreditX2*100; 2)
vtCreditPercentX2:=String:C10(vrCreditPercentX2; vtFormat2)
vtCreditPercentX2:=(" "*(viLen2-(Length:C16(vtCreditPercentX2))))+vtCreditPercentX2

vrCreditPercentX3:=Round:C94(vrCreditX3Net/vrCreditX3*100; 2)
vtCreditPercentX3:=String:C10(vrCreditPercentX3; vtFormat2)
vtCreditPercentX3:=(" "*(viLen2-(Length:C16(vtCreditPercentX3))))+vtCreditPercentX3

vrCreditPercentX4:=Round:C94(vrCreditX4Net/vrCreditX4*100; 2)
vtCreditPercentX4:=String:C10(vrCreditPercentX4; vtFormat2)
vtCreditPercentX4:=(" "*(viLen2-(Length:C16(vtCreditPercentX4))))+vtCreditPercentX4

vrCreditPercentX6:=Round:C94(vrCreditX6Net/vrCreditX6*100; 2)
vtCreditPercentX6:=String:C10(vrCreditPercentX6; vtFormat2)
vtCreditPercentX6:=(" "*(viLen2-(Length:C16(vtCreditPercentX6))))+vtCreditPercentX6

vrCreditPercentX10:=Round:C94(vrCreditX10Net/vrCreditX10*100; 2)
vtCreditPercentX10:=String:C10(vrCreditPercentX10; vtFormat2)
vtCreditPercentX10:=(" "*(viLen2-(Length:C16(vtCreditPercentX10))))+vtCreditPercentX10

vrCreditMiscPercent:=0
vtCreditMiscPercent:=String:C10(vrCreditMiscPercent; vtFormat2)
vtCreditMiscPercent:=(" "*(viLen2-(Length:C16(vtCreditMiscPercent))))+vtCreditMiscPercent

vrCreditPercent:=Round:C94(vrCreditNet/vrCredit*100; 2)
vtCreditPercent:=String:C10(vrCreditPercent; vtFormat2)
vtCreditPercent:=(" "*(viLen2-(Length:C16(vtCreditPercent))))+vtCreditPercent

vrNet:=(vrsales2Net+vrSales3Net+vrSales4Net+vrSales5Net+vrSales6Net)
vtNet:=String:C10(vrNet; vtFormat1)
vtNet:="$"+(" "*(viLen1-(Length:C16(vtNet))))+vtNet

vrSubSales:=vrSales2+vrSales3+vrSales4+vrSales5+vrSales6+vrSalesMisc  //### jwm ### 20121203_1252
vrSubSales:=Round:C94(vrSubSales; 2)
vtSubSales:=String:C10(vrSubSales; vtFormat1)
vtSubSales:="$"+(" "*(viLen1-(Length:C16(vtSubSales))))+vtSubSales

vrPercent:=vrSales/vrSubSales*100
vtPercent:=String:C10(vrPercent; vtFormat2)
vtPercent:=(" "*(viLen2-(Length:C16(vtPercent))))+vtPercent

//Adjust sign of values for Report 
//vrSamplesNet := vrSamplesNet * -1
//vrInventory := vrInventory * -1
//vrRCWO := vrRCWO * -1

vrSalesNet:=vrSales+vrSamplesNetNeg+vrCreditNet+vrInventory+vrRCWO+vrAdjustments

//vrSalesNet := vrSales - vrSamplesNet + vrCreditNet - vrInventory - vrRCWO
vrSalesNet:=Round:C94(vrSalesNet; 2)
vtSalesNet:=String:C10(vrSalesNet; vtFormat1)
vtSalesNet:="$"+(" "*(viLen1-(Length:C16(vtSalesNet))))+vtSalesNet


vtPage1:="Gross Sales      = "+vtGross+"    (No Freight)"+vCR+vCR
vtPage1:=vtPage1+"Sales"+vCR
vtPage1:=vtPage1+"Standard RIB     = "+vtSales2+" x "+vtPercent2+" = "+vtSales2Net+vCR
vtPage1:=vtPage1+"Power Supplies   = "+vtSales3+" x "+vtPercent3+" = "+vtSales3Net+vCR
vtPage1:=vtPage1+"Housings         = "+vtSales4+" x "+vtPercent4+" = "+vtSales4Net+vCR
vtPage1:=vtPage1+"Transformers     = "+vtSales5+" x "+vtPercent5+" = "+vtSales5Net+vCR
vtPage1:=vtPage1+"Credits Rebates  = "+vtSales6+" x "+vtPercent6+" = "+vtSales6Net+vCR
vtPage1:=vtPage1+"Sales Misc.      = "+vtSalesMisc+" x "+vtSalesMiscPercent+" = "+vtSalesMiscNet+vCR
vtPage1:=vtPage1+vtDoubleLine+vCR
vtPage1:=vtPage1+"                   "+vtSubSales+" x "+vtPercent+" = "+vtSales+vCR+vCR
//vtPage1 := vtPage1 + "Sales SubTotal   = " + vtSubSales + vCR
//vtPage1 := vtPage1 + "Sales Adjusted   = " + vtSales + vCR
//vtPage1 := vtPage1 + "Sales Percent    = " + vtPercent + vCR + vCR

vtPage1:=vtPage1+"Samples"+vCR
vtPage1:=vtPage1+"Standard RIB     = "+vtSamples2+" x "+vtSamplesPercent2+" = "+vtSamples2Net+vCR
vtPage1:=vtPage1+"Power Supplies   = "+vtSamples3+" x "+vtSamplesPercent3+" = "+vtSamples3Net+vCR
vtPage1:=vtPage1+"Housings         = "+vtSamples4+" x "+vtSamplesPercent4+" = "+vtSamples4Net+vCR
vtPage1:=vtPage1+"Transformers     = "+vtSamples5+" x "+vtSamplesPercent5+" = "+vtSamples5Net+vCR
vtPage1:=vtPage1+"Credits Rebates  = "+vtSamples6+" x "+vtSamplesPercent6+" = "+vtSamples6Net+vCR
vtPage1:=vtPage1+"Samples Misc.    = "+vtSamplesMisc+" x "+vtSamplesMiscPercent+" = "+vtSamplesMiscNet+vCR
vtPage1:=vtPage1+vtDoubleLine+vCR
vtPage1:=vtPage1+"                   "+vtSamples+" x "+vtSamplesPercent+" = "+vtSamplesNet+vCR+vCR
//vtPage1 := vtPage1 + "Samples Gross    = " + vtSamples + vCR
//vtPage1 := vtPage1 + "Samples Adjusted = " + vtSamplesNet + vCR
//vtPage1 := vtPage1 + "Samples Percent  = " + vtSamplesPercent + vCR + vCR

vtPage1:=vtPage1+"Credits"+vCR
vtPage1:=vtPage1+"Credit X 1       = "+vtCreditX1+" x "+vtCreditPercentX1+" = "+vtCreditX1Net+vCR
vtPage1:=vtPage1+"Credit X 2       = "+vtCreditX2+" x "+vtCreditPercentX2+" = "+vtCreditX2Net+vCR
vtPage1:=vtPage1+"Credit X 3       = "+vtCreditX3+" x "+vtCreditPercentX3+" = "+vtCreditX3Net+vCR
vtPage1:=vtPage1+"Credit X 4       = "+vtCreditX4+" x "+vtCreditPercentX4+" = "+vtCreditX4Net+vCR
vtPage1:=vtPage1+"Credit X 6       = "+vtCreditX6+" x "+vtCreditPercentX6+" = "+vtCreditX6Net+vCR
vtPage1:=vtPage1+"Credit X 10      = "+vtCreditX10+" x "+vtCreditPercentX10+" = "+vtCreditX10Net+vCR
vtPage1:=vtPage1+"Credit Misc.     = "+vtCreditMisc+" x "+vtCreditMiscPercent+" = "+vtCreditMiscNet+vCR
vtPage1:=vtPage1+vtDoubleLine+vCR
vtPage1:=vtPage1+"                   "+vtCredit+" x "+vtCreditPercent+" = "+vtCreditNet+vCR+vCR
//vtPage1 := vtPage1 + "Credit Gross     = " + vtCredit + vCR
//vtPage1 := vtPage1 + "Credit Adjusted  = " + vtCreditNet + vCR
//vtPage1 := vtPage1 + "Credit Percent   = " + vtCreditPercent + vCR + vCR

vtPage1:=vtPage1+"Summary"+vCR
vtPage1:=vtPage1+"Adjusted Sales                                 = "+vtSales+vCR
vtPage1:=vtPage1+"Adjusted Samples                               = "+vtSamplesNetNeg+vCR
vtPage1:=vtPage1+"Adjusted Credits                               = "+vtCreditNet+vCR
vtPage1:=vtPage1+"Adjusted Inventory Effects                     = "+vtInventory+vCR
vtPage1:=vtPage1+"Rebates Commissions & Write Offs               = "+vtRCWO+vCR
vtPage1:=vtPage1+"Additional Adjustments                         = "+vtAdjustments+vCR
vtPage1:=vtPage1+vtDoubleLine+vCR
vtPage1:=vtPage1+"Net Sales                                      = "+vtSalesNet+vCR+vCR
vtPage1:=vtPage1+"Employees                = "+"________________________"+vCR+vCR
vtPage1:=vtPage1+"Bonus                    = "+"________________________"+vCR+vCR

vtHeaderP1:="Bonus Report "+vtMonthName+" "+vtMyYear+vCR
viAddSpace:=Round:C94((62-Length:C16(vtHeaderP1)/2); 0)
vtHeaderP1:=" "*viAddSpace+vtHeaderP1
vtHeaderP1:=vtLine+vCR+vtHeaderP1+vtLine+vCR+vCR

vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
vtMyDate:=String:C10(Current date:C33)
vtMyName:=(Current user:C182)
vtFooter:=vtLine+vCR+vTab+"Report Printed By: "+vtMyName+"  "+vtMyDate+"  "+vtMyTime+vCR+vtLine+vCR+vCR

vtPage1:=vtHeaderP1+vtPage1+vtFooter+vFF

vtDoc:=vtPage1

//Message("Saving Monthly Sales.txt")

vText1:="Macintosh HD:Users:jimmedlen:Desktop:New_Bonus_Report.txt"

//myDoc:=create document(vText1)
//### jwm ### 20130613_0902 moved to beginning of report with other startup questions
//TheFolder := Select Folder("Select location to save report")

TheDate:=String:C10(Year of:C25(Date:C102(vtBegin)); "0000")+String:C10(Month of:C24(Date:C102(vtBegin)); "00")
vtDateTime:=Substring:C12(String:C10(Current date:C33; 8); 1; 10)+"_"+Substring:C12(String:C10(Current time:C178; 8); 12; 5)
vtDateTime:=Replace string:C233(vtDateTime; "-"; "")
vtDateTime:=Replace string:C233(vtDateTime; ":"; "")
TheFile:="Bonus_Report_"+TheDate+"_"+vtDateTime+".txt"
ThePath:=TheFolder+TheFile
myDoc:=Create document:C266(ThePath)


SEND PACKET:C103(myDoc; vtDoc)
CLOSE DOCUMENT:C267(myDoc)

ELog_NewRecord(4; "Bonus_Report"; vtDoc)

//Audit Log

Open window:C153(100; 200; 500; 300; 5; "Progress")
ERASE WINDOW:C160
GOTO XY:C161(3; 3)
MESSAGE:C88("Writing Audit File...")
DELAY PROCESS:C323(Current process:C322; 10)

//TheFolder := Select Folder("Select location to Audit Log")
//TheDate := String(Year of(Date(vtBegin));"0000")+String(Month of(Date(vtBegin));"00")
TheFile:="Audit_Log_"+TheDate+"_"+vtDateTime+".txt"
ThePath:=TheFolder+TheFile
myDoc:=Create document:C266(ThePath)

vtHeader:=""
vtHeader:=vtHeader+" UniqueID\t customerID\t GroupID\t TypeSale\t InvoiceNum\t DateShipped\t"
vtHeader:=vtHeader+" DateCode\t Year\t ItemNum\t AltItem\t Class\t QtyShip\t UnitPrice\t"
vtHeader:=vtHeader+" Discount\t DiscountPrice\t ExtPrice\t ExtCost\t Margin\t MarginPercent\t"
vtHeader:=vtHeader+" Profile1\t Profile4\t Penalty\t GLSales\t AdjustedAmount\t"
vtHeader:=vtHeader+" AdjustedPercent\t Range\t City\t State\t Country\r"

SEND PACKET:C103(myDoc; vtHeader)

vi2:=Size of array:C274(atcustomerID)
For (vi1; 1; vi2)
	
	SEND PACKET:C103(myDoc; atUniqueID{vi1}+"\t")
	SEND PACKET:C103(myDoc; atcustomerID{vi1}+"\t")
	SEND PACKET:C103(myDoc; atGroupID{vi1}+"\t")
	SEND PACKET:C103(myDoc; atTypeSale{vi1}+"\t")
	SEND PACKET:C103(myDoc; atInvoiceNum{vi1}+"\t")
	SEND PACKET:C103(myDoc; atDateShipped{vi1}+"\t")
	SEND PACKET:C103(myDoc; atDateCode{vi1}+"\t")
	SEND PACKET:C103(myDoc; atYear{vi1}+"\t")
	SEND PACKET:C103(myDoc; atItemNum{vi1}+"\t")
	SEND PACKET:C103(myDoc; atAltItem{vi1}+"\t")
	SEND PACKET:C103(myDoc; atClass{vi1}+"\t")
	SEND PACKET:C103(myDoc; atQtyShip{vi1}+"\t")
	SEND PACKET:C103(myDoc; atUnitPrice{vi1}+"\t")
	SEND PACKET:C103(myDoc; atDiscount{vi1}+"\t")
	SEND PACKET:C103(myDoc; atDiscountPrice{vi1}+"\t")
	SEND PACKET:C103(myDoc; atExtPrice{vi1}+"\t")
	SEND PACKET:C103(myDoc; atExtCost{vi1}+"\t")
	SEND PACKET:C103(myDoc; atMargin{vi1}+"\t")
	SEND PACKET:C103(myDoc; atMarginPercent{vi1}+"\t")
	SEND PACKET:C103(myDoc; atProfile1{vi1}+"\t")
	SEND PACKET:C103(myDoc; atProfile4{vi1}+"\t")
	SEND PACKET:C103(myDoc; atPenalty{vi1}+"\t")
	SEND PACKET:C103(myDoc; atGLSales{vi1}+"\t")
	SEND PACKET:C103(myDoc; atAdjustedAmount{vi1}+"\t")
	SEND PACKET:C103(myDoc; atAdjustedPercent{vi1}+"\t")
	SEND PACKET:C103(myDoc; atRange{vi1}+"\t")
	SEND PACKET:C103(myDoc; atCity{vi1}+"\t")
	SEND PACKET:C103(myDoc; atState{vi1}+"\t")
	SEND PACKET:C103(myDoc; atCountry{vi1}+"\r")
	
End for 

//Send Packet(myDoc;vtDoc)
CLOSE DOCUMENT:C267(myDoc)

//End Audit Log

ERASE WINDOW:C160
CLOSE WINDOW:C154

If (Records in set:C195("No_Profile4")>0)
	CREATE SET:C116([Item:4]; "Items_Current")
	USE SET:C118("No_Profile4")
	ProcessTableOpen(Table:C252(->[Item:4]); ""; "No Profile4")
	USE SET:C118("Items_Current")
	CLEAR SET:C117("Items_Current")
End if 
CLEAR SET:C117("No_Profile4")

If (Records in set:C195("Misc")>0)
	CREATE SET:C116([Item:4]; "InvoiceLines_Current")
	USE SET:C118("Misc")
	ProcessTableOpen(Table:C252(->[InvoiceLine:54]); ""; "Misc")
	USE SET:C118("InvoiceLines_Current")
	CLEAR SET:C117("InvoiceLines_Current")
End if 
CLEAR SET:C117("Misc")

UNLOAD RECORD:C212([GenericChild1:90])
