//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/18/19, 09:55:55
// ----------------------------------------------------
// Method: Tests_OB_Merge
// Description
// 
//
// Parteameters
// ----------------------------------------------------

//<declarations>
//==================================
//  Type variables 
//==================================

// $0;$abInput;$abOutput;$adInput;$adOutput;$aiInput;$aiOutput;$aoInput;$aoOutput
// $apInput;$apOutput;$arInput;$arOutput;$atInput;$atOutput
C_BOOLEAN:C305($vbInput)
C_DATE:C307($vdInput)
C_LONGINT:C283($viInput)
C_REAL:C285($vrInput)
C_TEXT:C284($vtFake; $vtInput)
C_POINTER:C301($vpInput)
C_OBJECT:C1216($voBase; $voGoal; $voInput; $voMerged; $voMergeDown)

//==================================
//  Initialize variables 
//==================================

$vbInput:=False:C215
$vdInput:=!00-00-00!
$viInput:=0
$vrInput:=0
$vtFake:=""
$vtInput:=""

C_BOOLEAN:C305($vbDefined)
$vbDefined:=OB Is defined:C1231($voBase)
$vbDefined:=OB Is defined:C1231($voGoal)
$vbDefined:=OB Is defined:C1231($voInput)
$vbDefined:=OB Is defined:C1231($voMerged)
$vbDefined:=OB Is defined:C1231($voMergeDown)
//</declarations>


C_BOOLEAN:C305($0)
$0:=True:C214

// ********************************************************************************************  //
// ** SET UP TYPED ARRAYS AND USE THEM TO BUILB OBJECTS THAT WILL BE MERGED *******************  //
// ********************************************************************************************  //

ARRAY TEXT:C222($atInput; 0)
ARRAY POINTER:C280($apInput; 0)
ARRAY DATE:C224($adInput; 0)
ARRAY BOOLEAN:C223($abInput; 0)
ARRAY LONGINT:C221($aiInput; 0)
ARRAY REAL:C219($arInput; 0)
ARRAY OBJECT:C1221($aoInput; 0)

ARRAY TEXT:C222($atOutput; 0)
ARRAY POINTER:C280($apOutput; 0)
ARRAY DATE:C224($adOutput; 0)
ARRAY BOOLEAN:C223($abOutput; 0)
ARRAY LONGINT:C221($aiOutput; 0)
ARRAY REAL:C219($arOutput; 0)
ARRAY OBJECT:C1221($aoOutput; 0)

C_TEXT:C284($vtInput)
$vtInput:="Value"

C_POINTER:C301($vpInput)
$vpInput:=->$vtFake

C_DATE:C307($vdInput)
$vdInput:=!2019-01-01!

C_BOOLEAN:C305($vbInput)
$vbInput:=True:C214

C_LONGINT:C283($viInput)
$viInput:=5

C_REAL:C285($vrInput)
$vrInput:=5.5

C_OBJECT:C1216($voInput)
OB SET:C1220($voInput; "Key"; "Value")

APPEND TO ARRAY:C911($atInput; $vtInput)
APPEND TO ARRAY:C911($apInput; $vpInput)
APPEND TO ARRAY:C911($adInput; $vdInput)
APPEND TO ARRAY:C911($abInput; $vbInput)
APPEND TO ARRAY:C911($aiInput; $viInput)
APPEND TO ARRAY:C911($arInput; $vrInput)
APPEND TO ARRAY:C911($aoInput; $voInput)

// ********************************************************************************************  //
// ** SET UP BASE OBJECT, WHICH WILL BE MERGED ONTO *******************************************  //
// ********************************************************************************************  //

C_OBJECT:C1216($voBase)
OB SET:C1220($voBase; "TextVariableOne"; "OriginalValue")
OB SET:C1220($voBase; "TextVariableTwo"; "OriginalValue")

// ********************************************************************************************  //
// ** SET UP SECOND OBJECT, WHICH WILL BE MERGED DOWN WITH HIGHER PRIORITY ********************  //
// ********************************************************************************************  //

C_OBJECT:C1216($voMergeDown)
OB SET:C1220($voMergeDown; "TextVariableTwo"; "NewValue")
OB SET ARRAY:C1227($voMergeDown; "ArrayText"; $atInput)
OB SET ARRAY:C1227($voMergeDown; "ArrayPointers"; $apInput)
OB SET ARRAY:C1227($voMergeDown; "ArrayDate"; $adInput)
OB SET ARRAY:C1227($voMergeDown; "ArrayBoolean"; $abInput)
OB SET ARRAY:C1227($voMergeDown; "ArrayInt"; $aiInput)
OB SET ARRAY:C1227($voMergeDown; "ArrayReal"; $arInput)
OB SET ARRAY:C1227($voMergeDown; "ArrayObject"; $aoInput)

// ********************************************************************************************  //
// ** SET UP FINAL OBJECT, WHICH WILL CONTAIN THE MERGED DATA *********************************  //
// ********************************************************************************************  //

C_OBJECT:C1216($voMerged)

// ********************************************************************************************  //
// ** MERGE $voBase AND $voMergeDown, THEN CHECK IF IT EQUALS $voGoal *************************  //
// ********************************************************************************************  //

$voMerged:=OB_Merge($voBase; $voMergeDown)

If (OB Get:C1224($voMerged; "TextVariableOne")#"OriginalValue")
	$0:=False:C215
	ConsoleLog("Tests_OB_Merge: Error when running method: OB_Merge: TextVariableOne")
End if 

If (OB Get:C1224($voMerged; "TextVariableTwo")#"NewValue")
	$0:=False:C215
	ConsoleLog("Tests_OB_Merge: Error when running method: OB_Merge: TextVariableTwo")
End if 

OB GET ARRAY:C1229($voMerged; "ArrayText"; $atOutput)
If ($atOutput{1}#$vtInput)
	$0:=False:C215
	ConsoleLog("Tests_OB_Merge: Error when running method: OB_Merge: ArrayText")
End if 

OB GET ARRAY:C1229($voMerged; "ArrayPointers"; $apOutput)
If ($apOutput{1}#$vpInput)
	$0:=False:C215
	ConsoleLog("Tests_OB_Merge: Error when running method: OB_Merge: ArrayPointers")
End if 

OB GET ARRAY:C1229($voMerged; "ArrayDate"; $adOutput)
If ($adOutput{1}#$vdInput)
	$0:=False:C215
	ConsoleLog("Tests_OB_Merge: Error when running method: OB_Merge: ArrayDate")
End if 

OB GET ARRAY:C1229($voMerged; "ArrayBoolean"; $abOutput)
If ($abOutput{1}#$vbInput)
	$0:=False:C215
	ConsoleLog("Tests_OB_Merge: Error when running method: OB_Merge: ArrayBoolean")
End if 

OB GET ARRAY:C1229($voMerged; "ArrayInt"; $aiOutput)
If ($aiOutput{1}#$viInput)
	$0:=False:C215
	ConsoleLog("Tests_OB_Merge: Error when running method: OB_Merge: ArrayInt")
End if 

OB GET ARRAY:C1229($voMerged; "ArrayReal"; $arOutput)
If ($arOutput{1}#$vrInput)
	$0:=False:C215
	ConsoleLog("Tests_OB_Merge: Error when running method: OB_Merge: ArrayReal")
End if 

OB GET ARRAY:C1229($voMerged; "ArrayObject"; $aoOutput)
If (OB Get:C1224($aoOutput{1}; "Key")#OB Get:C1224($voInput; "Key"))
	$0:=False:C215
	ConsoleLog("Tests_OB_Merge: Error when running method: OB_Merge: ArrayObject")
End if 
