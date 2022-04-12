//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/02/18, 17:29:02
// ----------------------------------------------------
// Method: BarcodeSSCC
// Description
// 
//
// Parameters
// ----------------------------------------------------


BarcodeInitArray
C_PICTURE:C286(vgBArcode)
vtAppID:="00"
vtExtNum:="0"  // The Extension Digit is used to increase the capacity of the Serial Number Reference (default zero)
vtCompanyID:="0094236"  // GS1 Company ID = "0"+UPC CompanyID "094236"
vtSerialNum:="123456789"  // assgined serial number
vtSSCC:=vtExtNum+vtCompanyID+vtSerialNum

// SSCC Check Digit
viSum:=0
For (vi1; 1; Length:C16(vtSSCC))
	If (vi1%2=1)
		viSum:=viSum+Num:C11(vtSSCC)*3  // odd position X 3
	Else 
		viSum:=viSum+Num:C11(vtSSCC)*1  // even position X 1
	End if 
End for 
vtCheckSum:=String:C10(viSum%10)

vtBarcode:=vtAppID+vtSSCC+vtCheckSum
vgBarcode:=BarCodeBuild(vtBarcode; 1; "GSC")
SET PICTURE TO PASTEBOARD:C521(vgBarcode)

vtHR_SSCC:="("+vtAppID+") "+vtExtNum+" "+vtCompanyID+" "+vtSerialNum+" "+vtCheckSum
ALERT:C41(vtHR_SSCC)
