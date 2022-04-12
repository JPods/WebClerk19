//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-12-15T00:00:00, 09:52:34
// ----------------------------------------------------
// Method: CronJobStartup
// Description
// Modified: 12/15/16
// 
// 
//
// Parameters
// ----------------------------------------------------


// always starup ChronJobLoop on all machines

C_LONGINT:C283(viProcessNum; vlProcessID; vifound)
C_BOOLEAN:C305(vbShow)

If (Application type:C494#4D Server:K5:6)  // ### jwm ### 20190228_0904 do not run on server
	If (Count parameters:C259>0)
		
		C_LONGINT:C283($viBottom; $videltaHeight; $videltaWidth; $viFormHeight; $viFormWidth; $viLeft)
		C_LONGINT:C283($viPadding; $viRight; $viTop; $viWindowHeight; $viWindowWidth)
		C_TIME:C306($vhWindow)
		C_BOOLEAN:C305(vbShow)
		
		vbShow:=False:C215
		
		// get all valid cronjobs for Current User and Machine
		Get_Cronjobs
		
		
		// QQQents
		
		//open winow
		$winRef:=Open form window:C675("Cronjob_Manager"; Plain form window:K39:10; On the right:K39:3; At the bottom:K39:6; *)
		C_LONGINT:C283($viWindowWidth; $viWindowHeight; $viLeft; $viTop; $viRight; $viBottom; $viPadding)
		FORM GET PROPERTIES:C674("Cronjob_Manager"; $viFormWidth; $viFormHeight)
		// shrink window to 0 x 0 
		RESIZE FORM WINDOW:C890(-$viFormWidth; -$viFormHeight)
		var $fObject : Object
		$fObject:=New object:C1471("parentProcess"; Current process:C322; \
			"LB_CronJob"; New object:C1471("ents"; New object:C1471; \
			"cur"; New object:C1471; \
			"sel"; New object:C1471; \
			"pos"; 0))
		
		//$dialog_o.LB_CronJob.data:=New object
		//$dialog_o.LB_CronJob.cur:=New object
		//$dialog_o.LB_CronJob.sel:=New object
		//$dialog_o.LB_CronJob.pos:=0
		
		DIALOG:C40("Cronjob_Manager"; $fObject)
		
		
	Else 
		<>machineName:=""
		<>machineName:=Current machine:C483  //### jwm ### 20120924_1045
		vifound:=Prs_CheckRunnin("CronManager")  // Cronjob Manager
		If (vifound=0)
			vlProcessID:=New process:C317("CronJobStartup"; 0; "CronManager"; "startup")
			REDUCE SELECTION:C351([CronJob:82]; 0)
		End if 
		
		// Hide Process
		viProcessNum:=0
		While (viProcessNum=0)
			viProcessNum:=Process number:C372("CronManager")
		End while 
		vbShow:=False:C215
		SET PROCESS VARIABLE:C370(viProcessNum; vbShow; vbShow)
		HIDE PROCESS:C324(viProcessNum)
	End if 
	
End if 
//Cronjob Syntax 20110923
//
//Author: 	James W. Medlen
//Created: 	09/23/2011
//Modified:	09/23/2011
//Notes:		specifies syntax for Cronjob strings
//
//There are six required values which are space or tab delimited
//
//
//*	*	*	*	*	*
//_	_	_	_	_   _
//|	|	|	|	|   |
//|	|	|	|	|   |--- Year (YYYY)
//|	|	|	|	+------- day of the week (0-6) (Sunday = 0 or 7)
//|	|	|	+----------- month (1-12)
//|	|	+--------------- day of month (1-31)
//|	+------------------- hour (0-23)
//+----------------------- minute (0-59)
//
//
//Format
//Field name 		Mandatory? 	Allowed values 	Allowed special characters
//Minutes 		Yes 		0-59 			* / , -
//Hours 			Yes 		0-23 			* / , -
//Day of month 	Yes 		1-31 			* / , - ? L W
//Month 			Yes 		1-12			* / , -
//Day of week 	Yes 		0-6			 	* / , - ? L #
//Year 			Yes 		19702099 		* / , -
//
//
//* is a wild card and matches anything
//, separates multiple values
//- indicates a range of values (1-10) 1 through 10
// / interval must have a start value and an interval 10/5 starting at 10 and repeating every 5 after
//L Last last day of the month valid: L = last day of the month or range 28-L (28 through end of Month) 
//  5L for weekday is last Friday of the month
//# Weekday of the month 5#2 the second friday of the month
//? Not implemented
//W Not implemented
//