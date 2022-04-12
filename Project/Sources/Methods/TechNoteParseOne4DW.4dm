//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-05-06T00:00:00, 00:07:02
// ----------------------------------------------------
// Method: TechNoteParseOne4DW
// Description
// Modified: 05/06/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $1)
ARRAY TEXT:C222($allStyles; 0)
ARRAY TEXT:C222(aText7; 0)
C_TEXT:C284($myTecnNoteFolder)
C_TEXT:C284($workingDocText)
C_TEXT:C284($strHTML)


$workingDocText:=$1

$workingDocText:=Txt_CleanEnding($workingDocText)
ARRAY TEXT:C222($arrayActions; 0)  // clear actions
ARRAY TEXT:C222($arrayStyles; 0)
ARRAY TEXT:C222($arrayReplace; 0)
C_TEXT:C284($replaceStyle; $defectStyle; $theBrace)

$defectStyle:="<p class="+"\""+"p@"
$theBrace:="{"


Txt_2Array($workingDocText; ->aText11; "\r")
$cntLines:=Size of array:C274(aText11)
ARRAY TEXT:C222($arrayActions; $cntLines)
For ($incLines; 1; $cntLines)
	If (($incLines>1) & ($incLines<$cntLines))  // avoid array issues
		Case of 
			: (aText11{$incLines}=$defectStyle)  // bypass if already corrected changed to "tn... if fixed
				C_TEXT:C284($myStyleWorking)
				C_LONGINT:C283($pQuoteGreaterThan)
				$pQuoteGreaterThan:=Position:C15(<>quoteChar+">"; aText11{$incLines})
				If ($pQuoteGreaterThan>0)
					$replaceStyle:="p."+Substring:C12(aText11{$incLines}; 11; $pQuoteGreaterThan-11)
					$pQuoteGreaterThan:=Find in array:C230($arrayStyles; $replaceStyle)
					If ($pQuoteGreaterThan>0)
						aText11{$incLines}:="<p class="+Txt_Quoted($arrayReplace{$pQuoteGreaterThan})+">"
					Else 
						aText11{$incLines}:="<p class="+Txt_Quoted("Error_"+$replaceStyle)+Substring:C12(aText11{$incLines}; 11)
					End if 
				Else 
					aText11{$incLines}:="<p class="+Txt_Quoted("ERROR_p")+Substring:C12(aText11{$incLines}; $pQuoteGreaterThan-1)
				End if 
			: (aText11{$incLines}="&nbsp;")  // clear out
				If ((aText11{$incLines-1}="<p@") & (aText11{$incLines+1}="</p@"))
					aText11{$incLines-1}:=""
					aText11{$incLines}:=""
					aText11{$incLines+1}:=""
				End if 
			: (aText11{$incLines}="<img@")
				aText11{$incLines-1}:="<div class="+Txt_Quoted("img_tn_style")+">"+"\r"
				aText11{$incLines+1}:="</div>"+"\r"
				
			: (aText11{$incLines}="p.p@")
				$found:=Position:C15($theBrace; aText11{$incLines})
				If ($found>0)
					APPEND TO ARRAY:C911($arrayStyles; Substring:C12(aText11{$incLines}; 1; $found-1))  // capture the existing style name
					
					$arrayActions{$incLines}:="style"
					Txt_2Array(aText11{$incLines}; ->aText12; ";")  // break the style
					$cntParts:=Size of array:C274(aText12)
					$doProcess:=0
					$resolveLeft:=0
					$resolveRight:=0
					$resolveIndent:=0
					C_LONGINT:C283($foundLeft; $foundRight; $foundIndent)
					C_TEXT:C284($parseMargin)
					$found:=Find in array:C230(aText12; "@margin-left@")
					If ($found>0)
						$parseMargin:=Substring:C12(aText12{$found}; Position:C15(": "; aText12{$found})+2)
						$resolveLeft:=Num:C11($parseMargin)
					End if 
					$found:=Find in array:C230(aText12; "@margin-right@")
					If ($found>0)
						$parseMargin:=Substring:C12(aText12{$found}; Position:C15(": "; aText12{$found})+2)
						$resolveRight:=Num:C11($parseMargin)
					End if 
					$found:=Find in array:C230(aText12; "@text-indent@")
					If ($found>0)
						$parseMargin:=Substring:C12(aText12{$found}; Position:C15(": "; aText12{$found})+2)
						$resolveIndent:=Num:C11($parseMargin)
					End if 
					$resolveLeft:=$resolveLeft+$resolveIndent
					Case of 
						: ($resolveLeft<15)
							$resolveLeft:=0
						: ($resolveLeft<36)
							$resolveLeft:=25
						: ($resolveLeft<61)
							$resolveLeft:=50
						: ($resolveLeft<86)
							$resolveLeft:=75
						: ($resolveLeft<111)
							$resolveLeft:=100
						: ($resolveLeft<136)
							$resolveLeft:=125
						: ($resolveLeft<161)
							$resolveLeft:=150
						: ($resolveLeft<186)
							$resolveLeft:=175
						: ($resolveLeft<211)
							$resolveLeft:=200
						: ($resolveLeft<236)
							$resolveLeft:=225
						Else 
							$resolveLeft:=250
					End case 
					APPEND TO ARRAY:C911($arrayReplace; "tn_p_margin"+String:C10($resolveLeft))  // capture the existing style na
					aText11{$incLines}:="/* "+$arrayReplace{Size of array:C274($arrayReplace)}+" replaced "+aText11{$incLines}+" */"
					$found:=Find in array:C230($allStyles; "tn_p_margin"+String:C10($resolveLeft))
					If ($found<1)
						APPEND TO ARRAY:C911($allStyles; "tn_p_margin"+String:C10($resolveLeft))
					End if 
				Else 
					aText11{$incLines}:="p.ERROR_"+Substring:C12(aText11{$incLines}; 3)
				End if 
		End case 
	End if 
End for 
$workingDocText:=""
$cntLines:=Size of array:C274(aText11)
For ($incLines; 1; $cntLines)
	$workingDocText:=$workingDocText+aText11{$incLines}+"\r"
End for 
// SET TEXT TO PASTEBOARD($workingDocText)
$0:=$workingDocText