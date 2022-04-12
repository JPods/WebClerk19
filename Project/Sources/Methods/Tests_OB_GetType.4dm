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
C_OBJECT:C1216($voBase; $voGoal; $voInput; $voObject)

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
$vbDefined:=OB Is defined:C1231($voObject)
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
// ** SET UP SECOND OBJECT, WHICH WILL BE MERGED DOWN WITH HIGHER PRIORITY ********************  //
// ********************************************************************************************  //

C_OBJECT:C1216($voObject)
OB SET:C1220($voObject; "TextVariableOne"; "NewValue")
OB SET ARRAY:C1227($voObject; "ArrayText"; $atInput)
OB SET ARRAY:C1227($voObject; "ArrayPointers"; $apInput)
OB SET ARRAY:C1227($voObject; "ArrayDate"; $adInput)
OB SET ARRAY:C1227($voObject; "ArrayBoolean"; $abInput)
OB SET ARRAY:C1227($voObject; "ArrayInt"; $aiInput)
OB SET ARRAY:C1227($voObject; "ArrayReal"; $arInput)
OB SET ARRAY:C1227($voObject; "ArrayObject"; $aoInput)

// ********************************************************************************************  //
// ** MERGE $voBase AND $voObject, THEN CHECK IF IT EQUALS $voGoal *************************  //
// ********************************************************************************************  //

If (OB_GetType($voObject; "TextVariableOne")#Is text:K8:3)
	$0:=False:C215
	ConsoleMessage("Tests_OB_GetType: Error when running method: OB_GetType: TextVariableOne")
End if 

If (OB_GetType($voObject; "ArrayText")#Text array:K8:16)
	$0:=False:C215
	ConsoleMessage("Tests_OB_GetType: Error when running method: OB_GetType: ArrayText")
End if 

If (OB_GetType($voObject; "ArrayPointers")#Pointer array:K8:23)
	$0:=False:C215
	ConsoleMessage("Tests_OB_GetType: Error when running method: OB_GetType: ArrayPointers")
End if 

If (OB_GetType($voObject; "ArrayDate")#Date array:K8:20)
	$0:=False:C215
	ConsoleMessage("Tests_OB_GetType: Error when running method: OB_GetType: ArrayDate")
End if 

If (OB_GetType($voObject; "ArrayBoolean")#Boolean array:K8:21)
	$0:=False:C215
	ConsoleMessage("Tests_OB_GetType: Error when running method: OB_GetType: ArrayBoolean")
End if 

If (OB_GetType($voObject; "ArrayInt")#LongInt array:K8:19)
	$0:=False:C215
	ConsoleMessage("Tests_OB_GetType: Error when running method: OB_GetType: ArrayInt")
End if 

If (OB_GetType($voObject; "ArrayReal")#Real array:K8:17)
	$0:=False:C215
	ConsoleMessage("Tests_OB_GetType: Error when running method: OB_GetType: ArrayReal")
End if 

If (OB_GetType($voObject; "ArrayObject")#Object array:K8:28)
	$0:=False:C215
	ConsoleMessage("Tests_OB_GetType: Error when running method: OB_GetType: ArrayObject")
End if 
