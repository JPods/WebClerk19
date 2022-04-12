//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-18T00:00:00, 09:27:59
// ----------------------------------------------------
// Method: TagValueField
// Description
// Modified: 12/18/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


If (<>WebRealFormat="")
	<>vlWebRealPr:=2
	<>WebRealFormat:=("###,###,###,##0.00")
End if 

C_LONGINT:C283($tableNum; $field; $pFormat; $intQualifier; $tableNum)
C_TEXT:C284($0; $strField; $myText; $myTextTemp)  // #### AZM #### 20171004_1614 Added $myTextTemp for use in phone processing
C_TEXT:C284($strQualifier; $strFormat; $strFieldName; $tableName)
C_POINTER:C301($pA; $ptField)
C_REAL:C285($myRealValue)
C_BOOLEAN:C305($doField)
C_LONGINT:C283(viSecureLvl)
$tableNum:=-1
$tableName:=vWebTagTable
$tableNum:=vWebTagTableNum
$strFieldName:=vWebTagField
$strField:=String:C10(viWebTagFieldNum)  // String(viWebTagFieldNum)
$strFormat:=vWebTagFormat
//  vWebTagFormat
$strQualifier:=<>WebRealFormat
$intQualifier:=<>vlWebRealPr

Error:=0
pvChecked:=""
$doField:=False:C215


C_TEXT:C284($pName)
C_LONGINT:C283($pTable; $pField)


$field:=Num:C11($strField)
If ($field<=0)  //  // ### bj ### 20181231_2235 cannot get here if $tableNum is not >0)
	Case of 
		: (($field=-2) | ($strField="RecordNum"))  //Record number
			$0:=String:C10(Record number:C243(Table:C252($tableNum)->))
		: (($field=0) | ($strField="Records"))  //Records in selection
			$0:=String:C10(Records in selection:C76(Table:C252($tableNum)->))
		: (($field=-1) | ($strField="TableName"))  //Table Name
			$0:=Table name:C256($tableNum)
		Else 
			$0:="error"
	End case 
Else 
	$ptField:=Field:C253($tableNum; $field)
	$doField:=True:C214
	GET FIELD PROPERTIES:C258($tableNum; $field; $type)
	Case of 
		: ($type=2)  //text            
			If ($strFormat="path")
				$0:=WccDocRef2Web($ptField->)
				$doField:=False:C215
				TRACE:C157
			Else 
				$myText:=Field:C253($tableNum; $field)->
				$doField:=False:C215
				$p:=Position:C15("<"; $myText)
				If (($p>0) | ($strFormat="html") | ($strFormat="text"))
					$myText:=$myText
					$doField:=False:C215
				Else 
					
					// $myText:=Replace string($myText;"\r"+"\r";"<P>")  // ### jwm ### 20151130_1159 incorrect html formatting
					$myText:=Replace string:C233($myText; "\r"; "<br>")
					$doField:=False:C215
				End if 
				$0:=$myText  //
			End if 
		: (($type=0) | ($type=24))  //string and strings
			$myText:=Replace string:C233(Field:C253($tableNum; $field)->; "&~"; "@")
			//had trouble at one time for symbols for inch, foot, etc  watch this
			Case of 
				: (($myText#"") & ((Field name:C257($ptField)="@email@")))
					Case of 
						: ($strFormat#"Plain")
							// just plain text
						: (<>vWebFormatEmail="")
							$myText:="<a href=\"mailto:"+$myText+"\">"+$myText+"</a>"
						Else 
							pvEmail:=$myText
							ExecuteText(0; <>vWebFormatEmail)
							$myText:=pvEmail
					End case 
				: (($myText#"") & ((Field name:C257($ptField)="@phone@") | (Field name:C257($ptField)="@fax@")))
					If ($strFormat#"Plain")
						$myTextTemp:=Format_Phone($myText)  // #### AZM #### 20171004_1614 Assigned formatted number to temp variable so that the pre-built links in following lines can have raw number in the href section.
					End if 
					Case of 
						: ($strFormat="TagFone")
							$myText:="<a href=\"tel:"+$myText+"\">"+$myTextTemp+"</a>"
						: ($strFormat="Tagsms")
							$myText:="<a href=\"sms:"+$myText+"\">"+$myTextTemp+"</a>"
						: ($strFormat="TagBoth")
							$myText:="<a href=\"tel:"+$myText+"\">"+$myTextTemp+"</a>"
							$myText:=myText+" <a href=\"sms:"+$myText+"\"> sms </a>"
						: ($strFormat="Tag")
							If (<>vWebFormatPhone="")
								$myText:="<a href=\"tel:"+$myText+"\">"+$myTextTemp+"</a>"
								If (Field name:C257($ptField)="@cell@")
									$myText:=myText+" <a href=\"sms:"+$myText+"\"> sms </a>"
								End if 
							Else 
								pvPhone:=$ptField->
								ExecuteText(0; <>vWebFormatPhone)
								$myText:=pvPhone
							End if 
						Else 
							$myText:=Format_Phone($myText)  // #### AZM #### 20171004_1614 Added a default case statement because we added a temp variable in line 100.
					End case 
				: ($myText="")
					$myText:=<>forceEmpty
			End case 
			$0:=$myText
			//End if 
		: ($type=Is real:K8:4)  //real    1   
			$myRealValue:=Field:C253($tableNum; $field)->
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
					End if   //
				: (($tableNum=4) & (viSecureLvl=0) & (($field=2) | ($field=3) | ($field=4) | ($field=5)))  //### jwm ### 20130220_1256 changed vWccSecurity to viSecureLvl //pUnitPrice set in ItemKeyPathVariables
					$0:=String:C10(pUnitPrice; $strQualifier)
				: (($tableNum=22) & (viSecureLvl=0) & (($field=20) | ($field=21) | ($field=22) | ($field=23)))  //### jwm ### 20130220_1256 changed vWccSecurity to viSecureLvl//pUnitPrice set in ItemKeyPathVariables
					$0:=String:C10($myRealValue; $strQualifier)
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
			
			$0:="4DPict?file="+String:C10($tableNum)+"&rec="+String:C10(Record number:C243(Table:C252($tableNum)->))+"&field="+String:C10($field)
			
		: ($type=Is date:K8:7)  //date   4
			$0:=String:C10(Field:C253($tableNum; $field)->; 1)
		: ($type=Is boolean:K8:9)  //boolean      6          
			//$0:="checked"*Num(Field($tableNum;$field)->)
			Case of 
				: ($strFormat="CheckBox@")
					$0:="checked"*Num:C11(Field:C253($tableNum; $field)->=True:C214)
				Else 
					If (Field:C253($tableNum; $field)->=True:C214)
						$0:="true"
					Else 
						$0:="false"
					End if 
			End case 
		: ($type=Is integer:K8:5)  //integer    8
			Case of 
				: (($strFormat="Rating") & (Field:C253($tableNum; $field)->=0))
					$0:="Not Rated"
				: (($strFormat="Null") & (Field:C253($tableNum; $field)->=0))
					$0:=""
				Else 
					$0:=String:C10(Field:C253($tableNum; $field)->)
			End case 
		: ($type=Is longint:K8:6)  //Longint     9
			If (Field name:C257(Field:C253($tableNum; $field))="DT@")
				jDateTimeRecov(Field:C253($tableNum; $field)->; ->vDate1; ->vTime1)
				Case of 
					: ($strFormat="DateOnly")
						$0:=String:C10(vDate1; 1)
					: ($strFormat="TimeOnly")
						$0:=String:C10(vTime1; 1)
					Else 
						$0:=String:C10(vDate1; 1)+" "+String:C10(vTime1; 1)
				End case 
			Else 
				$0:=String:C10(Field:C253($tableNum; $field)->; "###############")
			End if 
		: ($type=Is time:K8:8)  //time
			$0:=String:C10(Field:C253($tableNum; $field)->; 5)
	End case 
End if 



If (False:C215)
	//$pFormat:=Position(<>formatTag;$2)
	If (($pFormat>0) & ($tableNum#-6))
		$strExt:="."+$strFormat
		$intQualifier:=Num:C11($strFormat)
		$strQualifier:="###,###,###,###,##0"+("."*Num:C11($intQualifier>0))+("0"*$intQualifier)
	Else 
		$strExt:=""
		//$strField:=$2
		$strQualifier:=<>WebRealFormat
		$intQualifier:=<>vlWebRealPr
	End if 
End if 
