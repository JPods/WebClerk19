//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
C_LONGINT:C283($2; $3)
vDate1:=[QQQCarrier:11]DateEntered:1
vR1:=[QQQCarrier:11]CODCharge:7
vShipperID:=[QQQCarrier:11]ShipperID:21
//$COD:=[Carrier]COD Charge
prntQtyShip:=$1  //"Table"
ShipTo:=[QQQCarrier:11]CarrierID:10
//
prntKeyNum:=""
prntAcct:=""
prntItemNum:=""
prntTotal:=String:C10(vDate1)
prntExt:=""
prntFrght:=""
v2:=""
v3:=""
v4:=""
v5:=""
v6:=""
Print form:C5([QQQCarrier:11]; "Manifest_Lines")
$0:=$2+1