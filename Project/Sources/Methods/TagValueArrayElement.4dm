//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-18T00:00:00, 09:23:20
// ----------------------------------------------------
// Method: TagValueArrayElement
// Description
// Modified: 12/18/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// no current way to get element number

C_LONGINT:C283($1; $field; $pFormat; $intQualifier; $p; $3)
C_TEXT:C284($0; $2; $strField; $myText)
C_TEXT:C284($strQualifier; $strFormat; $strExt)
C_POINTER:C301($pA)
C_REAL:C285($myRealValue)
C_BOOLEAN:C305($doField)
C_LONGINT:C283(viSecureLvl)
$tableNum:=vWebTagTableNum
$strField:=vWebTagField  // #### AZM #### No longer passed in as variable. This was missing.
$strFormat:=vWebTagFormat
Error:=0


C_TEXT:C284($pName)
C_LONGINT:C283($pTable; $pField)

If ($strField="0")  //was the num of this but it was always 0
	$0:=""
Else 
	C_LONGINT:C283($pStart; $pEnd)
	C_POINTER:C301($pa; $ptRay)
	C_TEXT:C284($rayName; $elementStr)
	$rayName:=Substring:C12($strField; 1; (Position:C15("{"; $strField))-1)
	$pStart:=Position:C15("{"; $strField)+1
	$pEnd:=Position:C15("}"; $strField)-$pStart
	$elementStr:=Substring:C12($strField; $pStart; $pEnd)
	$elementValue:=Get pointer:C304($elementStr)->
	//$elementValue:=Num($elementStr)
	If ($elementValue>0)
		$pa:=Get pointer:C304($rayName)
		If (Size of array:C274($pa->)>=$elementValue)
			$type:=Type:C295($pa->)
			Case of 
				: ($type=18)
					$myText:=$pa->{$elementValue}
					$p:=Position:C15("</TD"; $myText)
					If (($p>0) | ($strFormat="html") | ($strFormat="text"))
						$myText:=$myText
					Else 
						//$myText:=Replace string($myText;"\r"+"\r";"<P>")  // ### jwm ### 20151130_1158 incorrect html formatting
						$myText:=Replace string:C233($myText; "\r"; "<br>")
					End if 
					$0:=$myText
				: (($type=21) | ($type=24))  //string and text
					//$text:=$pa
					$0:=$pa->{$elementValue}
				: ($type=14)  //real
					$myRealValue:=($pa->{$elementValue})
					Case of 
						: ($strFormat="SetStyle@")
							$fia:=Find in array:C230(<>aFormatTemplates; Substring:C12($strFormat; 10))
							If ($fia>0)
								If (<>aFormatTemplates{$fia}="FlipSign@")
									$myRealValue:=-$myRealValue
								End if 
								$0:=String:C10($myRealValue; <>aFormatReals{$fia})
							Else 
								$0:=String:C10($myRealValue; $strQualifier)
							End if 
						: ($myRealValue=-0.777)
							$0:="Call"
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
				: ($type=19)  //Place the reference for the pict
					//cannot be a 4D pict coming form a variable.
					//$0:="4DPict?file="+String($1)+"&rec="+String(Record number
					//(File($1)))+"&field="+String($field)
					
				: ($type=17)  //date
					$0:=String:C10($pa->{$elementValue}; 1)
				: ($type=22)  //boolean
					//  $0:="True"*Num($pa->=True)
					Case of 
						: ($strFormat="CheckBox@")
							$0:="checked"*Num:C11($pa->{$elementValue}=True:C214)
						Else 
							If ($pa->{$elementValue}=True:C214)
								$0:="true"
							Else 
								$0:="false"
							End if 
					End case 
				: (($type=15) | ($type=16))  //integer
					$0:=String:C10($pa->{$elementValue}; "##################")
				: ($type=11)  //time
					$0:=String:C10($pa->{$elementValue}; 5)
			End case 
		Else 
			$0:=""
		End if 
	Else 
		$0:=""
	End if 
End if 
//  

If (False:C215)
	If (($pFormat>0) & ($1#-6))
		// TRACE
		$strField:=Substring:C12($2; 1; $pFormat-1)
		$strFormat:=Substring:C12($2; $pFormat+1)
		$strExt:="."+$strFormat
		$intQualifier:=Num:C11($strFormat)
		$strQualifier:="###,###,###,###,##0"+("."*Num:C11($intQualifier>0))+("0"*$intQualifier)
	Else 
		$strExt:=""
		$strField:=$2
		$strQualifier:=<>WebRealFormat
		$intQualifier:=<>vlWebRealPr
	End if 
End if 