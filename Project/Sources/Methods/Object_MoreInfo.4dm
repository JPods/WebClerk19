//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 03/01/18, 14:34:50
// ----------------------------------------------------
// Method: Object_vtMoreInfo
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283(vileftV; vitopV; virightV; vibottomV; widthV; heightV)
C_LONGINT:C283(virightC; vitopC)
Case of 
		
	: (Form event code:C388=On Mouse Enter:K2:33)
		
		// setup for MoreInfo On Hover
		// Width and Height of the Variable object
		//OBJECT SET VISIBLE(*;"vtMoreInfo";False)
		OBJECT GET COORDINATES:C663(*; "vtMoreInfo"; vileftV; vitopV; virightV; vibottomV)
		widthV:=virightV-vileftV
		heightV:=vibottomV-vitopV
		vtMoreInfo:=""
		
		OBJECT GET COORDINATES:C663(*; OBJECT Get name:C1087; vileftF; vitopF; virightF; vibottomF)
		OBJECT SET VISIBLE:C603(*; "vtMoreInfo"; True:C214)
		vtMoreInfo:=String:C10(Self:C308->; "###,###,###,##0.######")
		//OBJECT SET COORDINATES ( {* ;} object ; left ; top {; right ; bottom} ) 
		OBJECT SET COORDINATES:C1248(*; "vtMoreInfo"; virightF-(widthV*0.1); vitopF-(heightV*0.8); virightF+(widthV*0.9); vibottomF-(heightV*0.8))  // upper right
		//OBJECT SET COORDINATES(*;"Variable";vileftF+1;vitopF;virightF;vibottomF)
		//OBJECT SET COLOR(*;OBJECT Get name;-(Black+(256*Yellow)))
		//object set format(*;OBJECT Get name;"###,###,##0.000000")
	: (Form event code:C388=On Mouse Leave:K2:34)
		
		OBJECT SET VISIBLE:C603(*; "vtMoreInfo"; False:C215)
		
End case 