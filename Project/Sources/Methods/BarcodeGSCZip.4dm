//%attributes = {}

BarcodeInitArray
C_PICTURE:C286(vgBArcode)
vtAppID:="420"
vtZipCode:="46979"  // assgined serial number
vtBarcode:=vtAppID+vtZipCode
vgBarcode:=BarCodeBuild(vtBarcode; 1; "GSC")
SET PICTURE TO PASTEBOARD:C521(vgBarcode)

vtHR_Zip:="("+vtAppID+") "+vtZipCode
