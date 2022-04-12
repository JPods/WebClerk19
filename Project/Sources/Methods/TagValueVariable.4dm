//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-18T00:00:00, 09:18:53
// ----------------------------------------------------
// Method: TagValueVariable
// Description
// Modified: 12/18/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $field; $pFormat; $intQualifier; $p; $3)
C_TEXT:C284($0; $2; $strField; $myText)
C_TEXT:C284($strQualifier; $strFormat; $strExt)
C_POINTER:C301($pA)
C_REAL:C285($myRealValue)
C_BOOLEAN:C305($doField)
C_LONGINT:C283(viSecureLvl)
$tableNum:=vWebTagTableNum
$strField:=vWebTagField
$strFormat:=vWebTagFormat

$strQualifier:=<>WebRealFormat
$intQualifier:=<>vlWebRealPr


C_TEXT:C284($pName)
C_LONGINT:C283($pTable; $pField)


Case of   //Nothing
		// ### bj ### 20181222_1850
		// : ($strField="0")  //  this does nothing, needs the pointer before we can evalate the value
		// $0:=""  // and we need to return a value of "0" in managing time in javascript 
		// text variables are required to prevent odd formating
	: (Length:C16($strField)>25)  //error in completing a variable.
		// ### bj ### 20181222_1848
		// is this still true??   
		//: (Num($strField)=1)//Language variable
		$0:=lang
	Else 
		//  TRACE
		// ### bj ### 20200411_2154
		$strField:=Replace string:C233($strField; "&lt;&gt;"; "<>")  // leaking through
		$pA:=Get pointer:C304($strField)
		//C_BOOLEAN($doThis)    //does not help
		//$doThis:=Not(Nil($pa))    //does not help
		//$doThis:=Is a variable($pa)   //does not help
		//see error checking script in Http_Edit window, must
		//compiled does not return an error, must be a script
		RESOLVE POINTER:C394($pA; $pName; $pTable; $pField)
		Case of 
			: (($pName#"") | ($pTable#-1) | ($pField#0))
				$type:=Type:C295($pa->)
				Case of 
					: ($type=Is text:K8:3)  // : ($type=2)
						
						If (($strFormat="@htm@") | ($strFormat="@tex@") | ($strFormat="@tx@") | ($strFormat="@js@") | ($strFormat="@asis@") | ($strFormat="@code@"))
							$myText:=$pa->
						Else 
							$myText:=$pa->
							//$myText:=Replace string($pa->;"\r"+"\r";"<BR><BR>")  // ### jwm ### 20151124_1055 creates unclosed paragraph tag
							//$myText:=Replace string($pa->;"\r"+"\r";"<P>")  // ### jwm ### 20151124_1055 creates unclosed paragraph tag
							$myText:=Replace string:C233($myText; "\r"; "<br>")
							// Modified by: Bill James (2017-09-05T00:00:00)  
						End if 
						If ($strField="voState.request.URL.pathName")
							$0:="__ "+Replace string:C233($myText; "_"; "_!_")
						Else 
							$0:=$myText
						End if 
					: ($type=Is string var:K8:2)  //string and text      0 24  
						$0:=$pa->
					: ($type=Is real:K8:4)  //real   1
						$myRealValue:=$pa->
						If ($strFormat="SetStyle_@")
							$fia:=Find in array:C230(<>aFormatTemplates; Substring:C12($strFormat; 10))
							If ($fia>0)
								If (<>aFormatTemplates{$fia}="FlipSign@")
									$myRealValue:=-$myRealValue
								End if 
								$strQualifier:=<>aFormatReals{$fia}
							End if 
						End if 
						Case of 
							: ($strField="pvQtySuggested")
								If ([Item:4]profile4:38="Accessory")
									$0:=""
								Else 
									$0:=String:C10([Item:4]qtySaleDefault:15)
								End if 
							: ($strField="pBasePrice")
								//TRACE
								//If ((vWccSecurity=0)&(viSecureLvl<<>viWebPriceLevel
								//))
								//$0:=<>vWebNoPriceComment
								//Else 
								$0:=String:C10($myRealValue; $strQualifier)
								//End if 
							: ($strField="pUnitPrice")
								// TRACE
								//If ((vWccSecurity=0)&(viSecureLvl<<>viWebPriceLevel
								//))
								//$0:=<>vWebNoPriceComment
								//Else 
								$0:=String:C10($myRealValue; $strQualifier)
								//End if 
							Else 
								// ### jwm ### 20171212_1307 use real number format
								If ($strFormat="0")
									$strQualifier:="###,###,###,##0"
								Else 
									$vi1:=Abs:C99(Num:C11($strFormat))
									If ($vi1#0)
										$strQualifier:="###,###,###,##0."+("0"*$vi1)
									End if 
								End if 
								$0:=String:C10($myRealValue; $strQualifier)
								
						End case 
					: ($type=Is picture:K8:10)  //Place the reference for the pict  3
						// not managed here
						
					: ($type=Is date:K8:7)  //date    4
						Case of 
							: ($strFormat="iso@")
								$0:=String:C10(Year of:C25($pa->))+"-"+String:C10(Month of:C24($pa->); "00")+"-"+String:C10(Day of:C23($pa->); "00")
							: ($strFormat="short@")
								$0:=String:C10($pa->; 1)
							Else 
								$0:=String:C10($pa->; 1)
						End case 
					: ($type=Is boolean:K8:9)  //boolean     6
						//  $0:="True"*Num($pa->=True)
						Case of 
							: ($strFormat="CheckBox@")
								$0:="checked"*Num:C11($pa->=True:C214)
							Else 
								If ($pa->=True:C214)
									$0:="true"
								Else 
									$0:="false"
								End if 
						End case 
					: (($type=Is integer:K8:5) | ($type=Is longint:K8:6))  //integer   8  9
						$0:=String:C10($pa->; "##################")
					: ($type=Is time:K8:8)  //time    
						$0:=String:C10($pa->; 5)
				End case 
			Else 
				$0:="Error: "+$strField+" Not Found"
		End case 
End case 
//

