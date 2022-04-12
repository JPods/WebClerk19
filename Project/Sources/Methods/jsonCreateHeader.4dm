//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/10/19, 22:26:12
// ----------------------------------------------------
// Method: jsonCreateHeader
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptObject)
C_TEXT:C284($headparts)
C_TEXT:C284($2; $3)
$ptObject:=$1
If (Count parameters:C259>0)
	$purpose:=$2
	If (Count parameters:C259>1)
		$headparts:=$3
	End if 
Else 
	$purpose:="testing"
	$headparts:="typeName:today,versionType:tomorrow,instantName:nextday"
End if 
C_TEXT:C284(vtRPCommand)
C_OBJECT:C1216($obHeader)
ARRAY TEXT:C222($aheadvalues; 0)

OB SET:C1220($obHeader; "Purpose"; $purpose)
OB SET:C1220($obHeader; "Date"; Current date:C33)
OB SET:C1220($obHeader; "Version"; Storage:C1525.version.title)
OB SET:C1220($obHeader; "Database"; Storage:C1525.default.company)
OB SET:C1220($obHeader; "Command"; vtRPCommand)
OB SET:C1220($obHeader; "id"; [SyncRelation:103]id:30)


ARRAY TEXT:C222($aheadvalues; 0)
C_TEXT:C284($headparts)
If ($headparts#"")
	Txt_2Array($headparts; ->$aheadvalues; ",")
	C_LONGINT:C283($incRay; $cntRay)
	$headparts:=""
	$cntRay:=Size of array:C274($aheadvalues)
	For ($incRay; 1; $cntRay)
		ARRAY TEXT:C222($aPairs; 0)
		Txt_2Array($aheadvalues{$incRay}; ->$aPairs; ":")
		If (Size of array:C274($aPairs)=2)
			OB SET:C1220($obHeader; $aPairs{1}; $aPairs{2})
		Else 
			OB SET:C1220($obHeader; $aPairs{1}; "")
		End if 
	End for 
End if 
$ptObject->:=$obHeader
