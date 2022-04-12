//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-06-07T00:00:00, 17:02:29
// ----------------------------------------------------
// Method: Object_OnFocus
// Description
// Modified: 06/07/18
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($vileftV; $vitopV; $virightV; $vibottomV; $widthV; $heightV)
C_LONGINT:C283($virightC; $vitopC)
Case of 
		
	: (Form event code:C388=On Getting Focus:K2:7)
		
		// setup for MoreInfo On Hover
		// Width and Height of the Variable object
		//OBJECT SET VISIBLE(*;"vtMoreInfo";False)
		OBJECT GET COORDINATES:C663(*; "vtMoreInfo"; $vileftV; $vitopV; $virightV; $vibottomV)
		$widthV:=$virightV-$vileftV
		$heightV:=$vibottomV-$vitopV
		vtMoreInfo:=""
		
		OBJECT GET COORDINATES:C663(*; OBJECT Get name:C1087; $vileftF; $vitopV; $virightV; $vibottomV)
		OBJECT SET VISIBLE:C603(*; "vtMoreInfo"; True:C214)
		vtMoreInfo:=String:C10(Self:C308->; "###,###,###,##0.######")
		//OBJECT SET COORDINATES ( {* ;} object ; left ; top {; right ; bottom} ) 
		OBJECT SET COORDINATES:C1248(*; "vtMoreInfo"; $vileftF; $vitopV; $virightV; $vibottomV+($heightV*3))  // upper right
		//OBJECT SET COORDINATES(*;"Variable";$vileftF+1;vitopF;virightF;vibottomF)
		//OBJECT SET COLOR(*;OBJECT Get name;-(Black+(256*Yellow)))
		//object set format(*;OBJECT Get name;"###,###,##0.000000")
	: (Form event code:C388=On Losing Focus:K2:8)
		
		OBJECT SET VISIBLE:C603(*; "vtMoreInfo"; False:C215)
		
End case 