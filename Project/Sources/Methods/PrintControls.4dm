//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/15/07, 00:39:02
// ----------------------------------------------------
// Method: Method: PrintControls
// Description
// 
//
// Parameters
// ----------------------------------------------------




//Parameter	Type		Description
//namesArray	Text Array		Printer names
//altNamesArray	Text Array		Windows: Printer locations
//Mac OS: Custom printer names
//modelsArray	Text Array		Printer models(Windows only)
ARRAY TEXT:C222($namesArray; 0)
ARRAY TEXT:C222($altNamesArray; 0)
ARRAY TEXT:C222($modelsArray; 0)
PRINTERS LIST:C789($namesArray; $altNamesArray; $modelsArray)

//PRINTERS LIST($namesArray{;altNamesArray{;modelsArray}})
C_TEXT:C284($thePrinter; $thePrinter1)
$thePrinter:=Get current printer:C788
C_LONGINT:C283($selectPrinter; $findWantedPrinter)

//PAGE SETUP (TABLE, FORM)  4D FORMS ONLY

If ([UserReport:46]PrinterSelected:36#"")
	$findWantedPrinter:=Find in array:C230($namesArray; [UserReport:46]PrinterSelected:36)
	If (($thePrinter#[UserReport:46]PrinterSelected:36) & ($findWantedPrinter>0))
		//Parameter	Type		Description
		//printerName	String		Name of printer to be used
		
		If (False:C215)  //testing
			$selectPrinter:=Num:C11(Request:C163("Select Printer."; "1"))
		End if 
		//$thePrinter:=$namesArray{$selectPrinter}
		
		SET CURRENT PRINTER:C787($namesArray{$findWantedPrinter})
		If (OK=0)  //printer not found
			$doDialog:=[UserReport:46]PrinterProgress:35
		End if 
	End if 
	
	
	If ([UserReport:46]PrinterOptions:37#"")
		$err:=0
		ExecuteText(0; [UserReport:46]PrinterOptions:37)
	End if 
	
	If (False:C215)
		SET PRINT OPTION:C733(Paper option:K47:1; 3)  //1//Paper Options Name, Height, Wid				
		SET PRINT OPTION:C733(Orientation option:K47:2; 2)  //2//Orientation 1-Portrait, 2- Landscape				
		SET PRINT OPTION:C733(Scale option:K47:3; 80)  //3//Scale, number %				
		SET PRINT OPTION:C733(Number of copies option:K47:4; 3)  //4//number of copies				
		SET PRINT OPTION:C733(Paper source option:K47:5; 3)  //5//Paper Source, Window Only, Index Number				
		SET PRINT OPTION:C733(Color option:K47:6; 3)  //8//Color Option, Windows Only, 1-N/B, 2-Color    
		SET PRINT OPTION:C733(Destination option:K47:7; 3)  //9//Destination Option, 1=Printer; 2=File, Access path; 3=PDF (Mac), Access Path; 5=Screen				
		SET PRINT OPTION:C733(Double sided option:K47:9; 3)  //11//Double sideded Windows only, 0=Single-sided; 0=double-sided    
		SET PRINT OPTION:C733(Spooler document name option:K47:10; 3)  //12//Spooler document name    
		SET PRINT OPTION:C733(Mac spool file format option:K47:11; 3)  //13//Mac Spool file format, 0=PDF mode; 1=PostScript
		SET PRINT OPTION:C733(_o_Hide printing progress option:K47:12; 3)  //14//Printing progress, 0=Display; 1=Hide
		C_LONGINT:C283($scaleValue)
		
		
		GET PRINT OPTION:C734(Scale option:K47:3; $scaleValue)
		
		$thePrinter1:=Get current printer:C788
		
	End if 
	//PRINT SETTINGS
	//Sequence:
	//PAGE SETUP
	//SET CURRENT PRINTER("")
	//SET PRINT OPTION
	
	
End if 

