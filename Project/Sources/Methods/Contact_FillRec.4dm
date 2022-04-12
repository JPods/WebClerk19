//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/02/08, 14:19:55
// ----------------------------------------------------
// Method: Contact_FillRec
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14)
[Contact:13]shipVia:26:=$1->  //[Order]ShipVia
[Contact:13]company:23:=$2->  //[Order]Company
[Contact:13]address1:6:=$3->  //[Order]Address1
[Contact:13]address2:7:=$4->  //[Order]Address2
[Contact:13]city:8:=$5->  //[Order]City
[Contact:13]state:9:=$6->  //[Order]State
[Contact:13]zip:11:=$7->  //[Order]Zip
[Contact:13]country:12:=$8->  //[Order]Country
[Contact:13]taxJuris:24:=$9->  //[Order]TaxJuris
[Contact:13]zone:27:=$10->  //[Order]Zone
[Contact:13]customerID:1:=$11->  //Account
[Contact:13]nameFirst:2:=$12->  //First Name
[Contact:13]nameLast:4:=$13->  //Last Name
[Contact:13]email:35:=$14->  //email