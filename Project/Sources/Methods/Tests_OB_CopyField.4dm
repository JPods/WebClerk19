//%attributes = {}

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
C_OBJECT:C1216($voInput; $voObject1; $voObject2)

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
$vbDefined:=OB Is defined:C1231($voInput)
$vbDefined:=OB Is defined:C1231($voObject1)
$vbDefined:=OB Is defined:C1231($voObject2)
//</declarations>

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/18/19, 09:55:55
// ----------------------------------------------------
// Method: Tests_OB_Merge
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($0)
$0:=True:C214

// ********************************************************************************************  //
// ** SET UP TYPED ARRAYS AND USE THEM TO BUILD OBJECTS THAT WILL BE MERGED *******************  //
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

C_OBJECT:C1216($voObject1)
OB SET:C1220($voObject1; "TextVariable"; "Value")
OB SET ARRAY:C1227($voObject1; "ArrayText"; $atInput)
OB SET ARRAY:C1227($voObject1; "ArrayPointers"; $apInput)
OB SET ARRAY:C1227($voObject1; "ArrayDate"; $adInput)
OB SET ARRAY:C1227($voObject1; "ArrayBoolean"; $abInput)
OB SET ARRAY:C1227($voObject1; "ArrayInt"; $aiInput)
OB SET ARRAY:C1227($voObject1; "ArrayReal"; $arInput)
OB SET ARRAY:C1227($voObject1; "ArrayObject"; $aoInput)

// ********************************************************************************************  //
// ** SET UP FINAL OBJECT, WHICH WILL CONTAIN THE MERGED DATA *********************************  //
// ********************************************************************************************  //

C_OBJECT:C1216($voObject2)

// ********************************************************************************************  //
// ** COPY OBJECT FIELDS FROM OBJECT1 TO OBJECT2, KEEPING THE SAME PROPERTY NAMES *************  //
// ********************************************************************************************  //

OB_CopyField(->$voObject1; "TextVariable"; ->$voObject2; "TextVariable")
If (OB Get:C1224($voObject2; "TextVariable")#"Value")
	$0:=False:C215
	ConsoleMessage("Tests_OB_CopyField: Error when running method: OB_CopyField: TextVariable")
End if 
CLEAR VARIABLE:C89($voObject2)

OB_CopyField(->$voObject1; "ArrayText"; ->$voObject2; "ArrayText")
OB GET ARRAY:C1229($voObject2; "ArrayText"; $atOutput)
If ($atOutput{1}#$vtInput)
	$0:=False:C215
	ConsoleMessage("Tests_OB_CopyField: Error when running method: OB_CopyField: ArrayText")
End if 
CLEAR VARIABLE:C89($voObject2)

OB_CopyField(->$voObject1; "ArrayPointers"; ->$voObject2; "ArrayPointers")
OB GET ARRAY:C1229($voObject2; "ArrayPointers"; $apOutput)
If ($apOutput{1}#$vpInput)
	$0:=False:C215
	ConsoleMessage("Tests_OB_CopyField: Error when running method: OB_CopyField: ArrayPointers")
End if 
CLEAR VARIABLE:C89($voObject2)

OB_CopyField(->$voObject1; "ArrayDate"; ->$voObject2; "ArrayDate")
OB GET ARRAY:C1229($voObject2; "ArrayDate"; $adOutput)
If ($adOutput{1}#$vdInput)
	$0:=False:C215
	ConsoleMessage("Tests_OB_CopyField: Error when running method: OB_CopyField: ArrayDate")
End if 
CLEAR VARIABLE:C89($voObject2)

OB_CopyField(->$voObject1; "ArrayBoolean"; ->$voObject2; "ArrayBoolean")
OB GET ARRAY:C1229($voObject2; "ArrayBoolean"; $abOutput)
If ($abOutput{1}#$vbInput)
	$0:=False:C215
	ConsoleMessage("Tests_OB_CopyField: Error when running method: OB_CopyField: ArrayBoolean")
End if 
CLEAR VARIABLE:C89($voObject2)

OB_CopyField(->$voObject1; "ArrayInt"; ->$voObject2; "ArrayInt")
OB GET ARRAY:C1229($voObject2; "ArrayInt"; $aiOutput)
If ($aiOutput{1}#$viInput)
	$0:=False:C215
	ConsoleMessage("Tests_OB_CopyField: Error when running method: OB_CopyField: ArrayInt")
End if 
CLEAR VARIABLE:C89($voObject2)

OB_CopyField(->$voObject1; "ArrayReal"; ->$voObject2; "ArrayReal")
OB GET ARRAY:C1229($voObject2; "ArrayReal"; $arOutput)
If ($arOutput{1}#$vrInput)
	$0:=False:C215
	ConsoleMessage("Tests_OB_CopyField: Error when running method: OB_CopyField: ArrayReal")
End if 
CLEAR VARIABLE:C89($voObject2)

OB_CopyField(->$voObject1; "ArrayObject"; ->$voObject2; "ArrayObject")
OB GET ARRAY:C1229($voObject2; "ArrayObject"; $aoOutput)
If (OB Get:C1224($aoOutput{1}; "Key")#OB Get:C1224($voInput; "Key"))
	$0:=False:C215
	ConsoleMessage("Tests_OB_CopyField: Error when running method: OB_CopyField: ArrayObject")
End if 
CLEAR VARIABLE:C89($voObject2)

// ********************************************************************************************  //
// ** COPY OBJECT FIELDS FROM OBJECT1 TO OBJECT1, USING DIFFERNET PROPERTY NAMES **************  //
// ********************************************************************************************  //

$voObject2:=OB Copy:C1225($voObject1)
OB_CopyField(->$voObject2; "ArrayPointers"; ->$voObject2; "ArrayPointersCopy")
OB GET ARRAY:C1229($voObject2; "ArrayPointersCopy"; $apOutput)
If ($apOutput{1}#$vpInput)
	$0:=False:C215
	ConsoleMessage("Tests_OB_CopyField: Error when running method: OB_CopyField: ArrayPointersCopy")
End if 
CLEAR VARIABLE:C89($voObject2)

$voObject2:=OB Copy:C1225($voObject1)
OB_CopyField(->$voObject2; "ArrayDate"; ->$voObject2; "ArrayDateCopy")
OB GET ARRAY:C1229($voObject2; "ArrayDateCopy"; $adOutput)
If ($adOutput{1}#$vdInput)
	$0:=False:C215
	ConsoleMessage("Tests_OB_CopyField: Error when running method: OB_CopyField: ArrayDateCopy")
End if 
CLEAR VARIABLE:C89($voObject2)

$voObject2:=OB Copy:C1225($voObject1)
OB_CopyField(->$voObject2; "ArrayBoolean"; ->$voObject2; "ArrayBooleanCopy")
OB GET ARRAY:C1229($voObject2; "ArrayBooleanCopy"; $abOutput)
If ($abOutput{1}#$vbInput)
	$0:=False:C215
	ConsoleMessage("Tests_OB_CopyField: Error when running method: OB_CopyField: ArrayBooleanCopy")
End if 
CLEAR VARIABLE:C89($voObject2)
