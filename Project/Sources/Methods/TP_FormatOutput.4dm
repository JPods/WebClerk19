//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/13/17, 11:34:17
// ----------------------------------------------------
// Method: TP_FormatOutput
//
// Description:
// 
// This method is sent the name of a process variable
// returns the content of that variable, if it exists.
//
// Parameters
// ----------------------------------------------------

// ******************************************* //
// ****** TYPE AND INITIALIZE PARAMETERS ***** //
// ******************************************* //

// RETURN VARIABLE
C_TEXT:C284($0; $vtOutput; $vtTemp)
$0:=""
$vtOutput:=""
$vtTemp:=""

// PARAMETER 1 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_POINTER:C301($1; $vpPointer)
$vpPointer:=$1

// PARAMETER 2 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_TEXT:C284($2; $vtOutputFormat)
$vtOutputFormat:=$2

// $vtRealFormat IS THE FORMAT FOR CONVERTING REAL NUMBERS
// TO STRINGS
C_TEXT:C284($vtRealFormat)
$vtRealFormat:=<>WebRealFormat

// TEST TO SEE IF THE POINTER IS A TABLE/FIELD, OR A VARIABLE

C_TEXT:C284($vtVarName)
C_LONGINT:C283($viTableNum; $viFieldNum)

$vtVarName:=""
$viTableNum:=-1
$viFieldNum:=-1

RESOLVE POINTER:C394($vpPointer; $vtVarName; $viTableNum; $viFieldNum)

C_TEXT:C284($vtFieldName)
$vtFieldName:=""

If (($viTableNum#-1) & ($viFieldNum#-1))
	
	// $vtFieldName WILL BE AN EMPTY STRING IF WE ARE
	// FORMATTING A VARIABLE. IT WILL BE A TEXT STRING
	// ONLY IF WE ARE FORMATTING THE CONTENTS OF A FIELD
	$vtFieldName:=Field name:C257($vpPointer)
	
End if 

// ************************************************* //
// *** CHECK TYPE, THEN FORMAT & CONVERT TO TEXT *** //
// ************************************************* //

$viType:=Type:C295($vpPointer->)

Case of 
	: ($viType=Is text:K8:3)
		$vtOutput:=$vpPointer->
		If (($vtOutputFormat="@htm@") | ($vtOutputFormat=""))
			$vtOutput:=Replace string:C233($vtOutput; "\r"; "<br>")
		End if 
		If ($vtVarName="vWCDocumentURI")
			$vtOutput:="__ "+Replace string:C233($vtOutput; "_"; "_!_")
		End if 
	: (($viType=Is string var:K8:2) | ($viType=Is alpha field:K8:1))
		$vtOutput:=$vpPointer->
		Case of 
			: ($vtFieldName="@email@")
				$vtOutput:="<a href=\"mailto:"+$vtOutput+"\">"+$vtOutput+"</a>"
			: (($vtFieldName="@phone@") | ($vtFieldName="@fax@"))
				$vtTemp:=Format_Phone($vtOutput)  // #### AZM #### 20171003_1333 
				If ($vtOutputFormat="TagFone")
					$vtOutput:="<a href=\"tel:"+$vtOutput+"\">"+$vtTemp+"</a>"
				Else 
					$vtOutput:=$vtTemp
				End if 
			Else 
				If (($vtOutputFormat="@htm@") | ($vtOutputFormat=""))
					$vtOutput:=Replace string:C233($vtOutput; "\r"; "<br>")
				End if 
		End case 
	: (($viType=Is real:K8:4))
		If ($vtOutputFormat="0")
			$vtRealFormat:="###,###,###,##0"
		Else 
			$vi1:=Abs:C99(Num:C11($vtOutputFormat))
			If ($vi1#0)
				$vtRealFormat:="###,###,###,##0."+("0"*$vi1)
			End if 
		End if 
		If (($viTableNum=4) & (viSecureLvl=0) & (($viFieldNum=2) | ($viFieldNum=3) | ($viFieldNum=4) | ($viFieldNum=5)))  //### jwm ### 20130220_1256 changed vWccSecurity to viSecureLvl //pUnitPrice set in ItemKeyPathVariables
			$vtOutput:=String:C10(pUnitPrice; $vtRealFormat)
		Else 
			$vtOutput:=String:C10($vpPointer->; $vtRealFormat)
		End if 
	: ($viType=Is date:K8:7)
		Case of 
			: ($vtOutputFormat="iso@")
				$vtOutput:=String:C10(Year of:C25($vpPointer->))+"-"+String:C10(Month of:C24($vpPointer->); "00")+"-"+String:C10(Day of:C23($vpPointer->); "00")
			Else 
				$vtOutput:=String:C10($vpPointer->; 1)
		End case 
	: ($viType=Is boolean:K8:9)
		Case of 
			: ($vtOutputFormat="CheckBox@")
				If ($vpPointer->=True:C214)
					$vtOutput:="checked"
				Else 
					$vtOutput:=""
				End if 
			Else 
				If ($vpPointer->=True:C214)
					$vtOutput:="true"
				Else 
					$vtOutput:="false"
				End if 
		End case 
	: ($viType=Is integer:K8:5)
		Case of 
			: (($vtOutputFormat="Rating") & ($vpPointer->=0))
				$vtOutput:="Not Rated"
			: (($vtOutputFormat="Null") & ($vpPointer->=0))
				$vtOutput:=""
			Else 
				$vtOutput:=String:C10($vpPointer->; "##################")
		End case 
	: ($viType=Is longint:K8:6)
		If ($vtFieldName="DT@")
			DateTime_DTFrom($vpPointer->; ->vDate1; ->vTime1)
			Case of 
				: ($vtOutputFormat="DateOnly")
					$0:=String:C10(vDate1; 1)
				: ($vtOutputFormat="TimeOnly")
					$0:=String:C10(vTime1; 1)
				Else 
					$0:=String:C10(vDate1; 1)+" "+String:C10(vTime1; 1)
			End case 
		Else 
			$vtOutput:=String:C10($vpPointer->; "##################")
		End if 
	: ($viType=Is time:K8:8)
		$vtOutput:=String:C10($vpPointer->; 5)
End case 

$0:=$vtOutput