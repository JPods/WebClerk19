//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/08/09, 14:38:16
// ----------------------------------------------------
// Method: WebHelp
// Description
// 
//
// Parameters
// ----------------------------------------------------



// c_text($tableName;$formName)
// C_longint($selector;$formValue;$tableNum)

// $formValue:=FORM GET PARAMETER (ptCurTable->;curForm;$selector)


jCenterWindow(600; 440; 1)
DIALOG:C40([Control:1]; "HelpWeb")
CLOSE WINDOW:C154
vDiaCom:=""
If (myOK=1)
	iLoText2:=URL_Encode(iLoText2)
	myOK:=0
	Case of 
		: (<>vHelpSite#"")
			OPEN URL:C673("http://"+<>vHelpSite+"/"+iLoText2)
		: (aHelpChoice=1)
			OPEN URL:C673("http://"+<>vLocalHost+"/"+iLoText2)
			OPEN URL:C673("http://"+Storage:C1525.default.domain+"/"+iLoText2)
			OPEN URL:C673("http://www.webclerk.com/"+iLoText2)
		: (aHelpChoice=2)
			OPEN URL:C673("http://"+<>vLocalHost+"/"+iLoText2)
			OPEN URL:C673("http://"+Storage:C1525.default.domain+"/"+iLoText2)
		: (aHelpChoice=3)
			OPEN URL:C673("http://www.webclerk.com/"+iLoText2)
		: (aHelpChoice=4)
			OPEN URL:C673("http://"+Storage:C1525.default.domain+"/"+iLoText2)
		: (aHelpChoice=5)
			OPEN URL:C673("http://"+<>vLocalHost+"/"+iLoText2)
		: (aHelpChoice=5)
			OPEN URL:C673("http://"+<>vLocalHost+"/"+iLoText2)
		: (aHelpChoice=6)
			OPEN URL:C673("http://"+iLo35String4+"/"+iLoText2)
		Else 
			OPEN URL:C673("http://www.webclerk.com/"+iLoText2)
	End case 
End if 
iLoText1:=""
iLoText2:=""
iLo35String1:=""
iLo35String2:=""
iLo35String3:=""
iLo35String4:=""
ARRAY TEXT:C222(aiLoText3; 0)
ARRAY TEXT:C222(aiLoText1; 0)
If (False:C215)
	//array TEXT($aObjectName;0)
	//ARRAY POINTER($aObjectPointer;0)
	//ARRAY LONGINT($aObjectPage;0)
	//GET FORM OBJECTS($aObjectName;$aObjectPointer;$aObjectPage,*)
	
	
	
	
	//GET FORM PROPERTIES ({table; }formName; width; height{; numPages{; fixedWidth{; fixedHeight{;title}}}})
	//Parameter Type Description
	//table Table ? Table of the form or Default table, if omitted
	//formName String ? Name of the form
	//width Longint ? Width of the form (in pixels)
	//height Longint ? Height of the form (in pixels)
	//numPages Longint ? Number of pages in the form
	//fixedWidth Boolean ? True = Fixed width, False = Variable width
	//fixedHeight Boolean ? True = Fixed height, False = Variable height
	//title Text ?
	
	
	//$ptTable:=Current form table//provides a pointer to the table of this form
	
	
End if 