//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2; $5)  //file & field number causing changes
C_BOOLEAN:C305($3)  //Serial Record was locked or saved
C_TEXT:C284($4)  //reason
C_LONGINT:C283($5)
C_TEXT:C284($6; $7)
CREATE RECORD:C68([ItemSerialAction:64])

If (Count parameters:C259=7)
	[ItemSerialAction:64]ItemSerialID:1:=$5  //[ItemSerial]SerialRecID
	[ItemSerialAction:64]SerialNum:2:=$6  //[ItemSerial]SerialNum
	[ItemSerialAction:64]ItemNum:8:=$7  //[ItemSerial]ItemNum
Else 
	[ItemSerialAction:64]ItemSerialID:1:=[ItemSerial:47]idUnique:18
	[ItemSerialAction:64]SerialNum:2:=[ItemSerial:47]SerialNum:4
	[ItemSerialAction:64]ItemNum:8:=[ItemSerial:47]ItemNum:1
End if 
[ItemSerialAction:64]Action:7:=$4
[ItemSerialAction:64]DateAction:6:=Current date:C33
[ItemSerialAction:64]tableNum:3:=$1
[ItemSerialAction:64]DocID:4:=$2
[ItemSerialAction:64]Complete:9:=$3
SAVE RECORD:C53([ItemSerialAction:64])