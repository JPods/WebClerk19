//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/22/18, 10:29:02
// ----------------------------------------------------
// Method: DateTimeDTEpoch
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $action)
// C_longint($2)
C_POINTER:C301($2; $3)
$action:=$1

C_REAL:C285($vrDTdiff; $vrWorking)

$vrDTdiff:=(!1990-01-01!-!1970-01-01!)*86400

If ($action="ToEpoch")  // using a string to control , and 0.00
	If ($2->=0)
		$3->:="0"
	Else 
		$vrWorking:=($2->+$vrDTdiff)*1000
		$3->:=String:C10($vrWorking)  // ;"#################")  // add difference to DT
	End if 
Else 
	$vrWorking:=Num:C11($3->)*0.001
	If ($vrWorking=0)
		$2->:=0
	Else 
		$2->:=$vrWorking-$vrDTdiff  // subtract difference from Epoch
		If (<>viDeBugMode>410)
			C_DATE:C307($vDate)
			C_TIME:C306($vTime)
			jDateTimeRecov($2->; ->$vDate; ->$vTime)
		End if 
	End if 
End if 
// ### bj ### 20181204_2130
// work with Jim and Andy on this
If (False:C215)  // hold we should convert all our DTs to 1970  and likely to javascript standard
	
	C_REAL:C285($ms19701990; $days; $msDay; $theDays; $theMS; $justNum)
	$msDay:=86400*1000
	$days:=!1990-01-01!-!1970-01-01!
	$ms19701990:=$msDay*$days
	$theDays:=7305
	$theMS:=86400000
	$theLapse:=$theDays*$theMS
	$justNum:=7305*86400
	
	// need to change DTs to reals
	
	
	C_LONGINT:C283($incRecord; $cntRecords; $incTables; $cntTables; $rportRecord)
	C_TEXT:C284($tableName)
	C_TEXT:C284($logOfChanges)
	
	C_LONGINT:C283($fieldNum; $incRec; $cntRec; $theType; $fia)
	C_POINTER:C301($ptField; $ptTable)
	
	
	$cntTables:=Get last table number:C254
	For ($incTables; 1; $cntTables)
		$tableName:=Table name:C256($incTables)
		$ptTable:=Table:C252($incTables)
		//  If ((vText1="Counter@") | (vText1="zz@") | (vText1="(@") | (vText1="Default"))
		If (($tableName="zz@") | ($tableName="(@"))
		Else 
			ALL RECORDS:C47($ptTable->)
			$cntRec:=Records in selection:C76($ptTable->)
			If ($cntRec>0)
				C_LONGINT:C283($incFields; $cntFields)
				$cntFields:=Get last field number:C255($ptTable->)
				ConsoleMessage(Table name:C256($ptTable)+": Field count: "+String:C10($cntFields))
				FIRST RECORD:C50($ptTable->)
				For ($incRec; 1; $cntRec)
					For ($incFields; 1; $cntFields)
						If (Field name:C257(Field:C253($incTables; $incFields))="DT@")
							Field:C253($incTables; $incFields)->:=Field:C253($incTables; $incFields)->+631152000000
						End if 
					End for 
					SAVE RECORD:C53($ptTable->)
					NEXT RECORD:C51($ptTable->)
				End for 
			End if 
			REDUCE SELECTION:C351($ptTable->; 0)
		End if 
	End for 
	SelectionToZero
End if 
