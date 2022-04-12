//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 10/03/17, 09:06:00
// ----------------------------------------------------
// Method: iLo_QueryEditor
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20171003_1442 Replace with [Table] and Field
// ### jwm ### 20171108_1258 added Table Name to DT fields

C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: (After:C31)
		Temp_RayInit
	: (Outside call:C328)
		Prs_OutsideCall
	: (Form event code:C388=On Load:K2:1)
		ptCurTable:=Table:C252(curTableNum)
		bStayInProcess:=doQuickQuote
		$doChange:=(UserInPassWordGroup("EditReportScript"))
		If (Not:C34($doChange))
			OBJECT SET ENTERABLE:C238(vText1; False:C215)
		End if 
		Temp_RayInit
		Srch_EdBefore(eSrchPat)
		C_OBJECT:C1216(voQuery)
		voQuery:=New object:C1471
		myOK:=0
		//C_Longint(queryThisProcess)
		//queryThisProcess:=1
		SET MENU BAR:C67(6)
	Else 
		If (doSearch>0)
			
			C_LONGINT:C283($error)
			//  CHOPPED  $error:=AL_GetSelect(eSrchFlds; aFieldLns)
			
			myOK:=0  //any change to the pattern, exit var    
			If (Size of array:C274(aFieldLns)=0)
				ARRAY LONGINT:C221(aFieldLns; 1)
				aFieldLns{1}:=1
			End if 
			C_LONGINT:C283($row)
			Case of 
				: ((doSearch=3) & (aQueryFieldNames>0) & (aQueryFieldNames<=Size of array:C274(aQueryFieldNames)))
					aQueryFieldNames{aQueryFieldNames}:="["+<>aTableNames{<>aTableNames}+"]"+theFields{aFieldLns{1}}  // ### jwm ### 20171003_1442
				: (doSearch=12)
					If (aQueryFieldNames<=Size of array:C274(aQueryValues))
						aQueryValues{aQueryFieldNames}:="["+<>aTableNames{<>aTableNames}+"]"+theFields{aFieldLns{1}}
					End if 
				: ((doSearch=2) | (doSearch=7))
					If (doSearch=2)
						$row:=Size of array:C274(aQueryFieldNames)+1
					Else 
						If (aQueryFieldNames>Size of array:C274(aQueryFieldNames))
							aQueryFieldNames:=Size of array:C274(aQueryFieldNames)
						Else 
							If (aQueryFieldNames>0)
								$row:=aQueryFieldNames
							Else 
								$row:=1
							End if 
						End if 
					End if 
					INSERT IN ARRAY:C227(aQueryBooleans; $row)
					INSERT IN ARRAY:C227(aQueryFieldNames; $row)
					INSERT IN ARRAY:C227(aQueryOperators; $row)
					INSERT IN ARRAY:C227(aQueryValues; $row)
					aQueryFieldNames{$row}:="["+<>aTableNames{<>aTableNames}+"]"+theFields{aFieldLns{1}}
					aQueryFieldNames:=$row
					If ((theTypes{aFieldLns{1}}="A@") | (theTypes{aFieldLns{1}}="T@"))
						aQueryOperators{$row}:="begins with"
					Else 
						aQueryOperators{$row}:="equals"
					End if 
					If (aQueryFieldNames>1)
						aQueryBooleans{$row}:="and"
					End if 
					If ((theTypes{aFieldLns{1}}="L") & (Substring:C12(theFields{aFieldLns{1}}; 1; 2)="DT"))
						jDateTimeUserCl
						aQueryOperators{$row}:="greater or equal"  // ### jwm ### 20190220_1007  aTmp20Str4{6}
						aQueryValues{$row}:=String:C10(vlDTStart)
						$row:=Size of array:C274(aQueryFieldNames)+1
						INSERT IN ARRAY:C227(aQueryBooleans; $row)
						INSERT IN ARRAY:C227(aQueryFieldNames; $row)
						INSERT IN ARRAY:C227(aQueryOperators; $row)
						INSERT IN ARRAY:C227(aQueryValues; $row)
						aQueryBooleans{$row}:="and"
						aQueryFieldNames{$row}:="["+<>aTableNames{<>aTableNames}+"]"+theFields{aFieldLns{1}}  // ### jwm ### 20171108_1258 added Table Name
						aQueryValues{$row}:=String:C10(vlDTEnd)
						aQueryOperators{$row}:="less than or equal"  // ### jwm ### 20190220_1007  aTmp20Str4{8}
						
					End if 
					C_LONGINT:C283($col)
					$col:=4
				: (Size of array:C274(aTmp20Str4)=0)
					BEEP:C151  //drop out
					BEEP:C151
				: (doSearch=1)
					If (Size of array:C274(aQueryFieldNames)>0)
						If (Size of array:C274(aQueryFieldNames)>=aQueryFieldNames)
							$row:=aQueryFieldNames
						Else 
							$row:=Size of array:C274(aQueryFieldNames)
						End if 
						DELETE FROM ARRAY:C228(aQueryBooleans; $row)
						DELETE FROM ARRAY:C228(aQueryFieldNames; $row)
						DELETE FROM ARRAY:C228(aQueryOperators; $row)
						DELETE FROM ARRAY:C228(aQueryValues; $row)
						Case of 
							: ($row>1)
								$row:=$row-1
							: (Size of array:C274(aQueryFieldNames)=0)
								$row:=0
						End case 
					End if 
				: (doSearch=4)  //choose comparitor
					
					aQueryOperators{aQueryFieldNames}:=aTmp20Str4{aTmp20Str4}
					
				: (doSearch=5)  //choose linking logic
					If (aQueryFieldNames>1)
						aQueryBooleans{aQueryFieldNames}:=aTmp20Str2{aTmp20Str2}
					Else 
						BEEP:C151
					End if 
				: (doSearch=6)  //fill in value
					aQueryValues{aQueryFieldNames}:=vText2+("@"*b41)
				: (doSearch=8)  //fill in value
					
				: ((doSearch=10) | (doSearch=11))
					ExecuteText(0; vText1)
					If (doSearch=10)
						CANCEL:C270
					End if 
					myOK:=1
			End case 
			//      
			ON ERR CALL:C155("jOECNoAction")
			//  --  CHOPPED  AL_UpdateArrays(eSrchPat; -2)
			If ($row>0)
				GOTO OBJECT:C206(eSrchPat)
				//  CHOPPED  AL_GotoCell(eSrchPat; $col; $row)
				// -- AL_SetCellLongProperty(eSrchPat; $row; $col; ALP_Cell_Enterable; 1)
				//// -- AL_SetColumnLongProperty (eSrchPat;$col;ALP_Column_Enterable;1)
				//  CHOPPED  $enterable:=AL_GetCellLongProperty(eSrchPat; $row; $col; ALP_Cell_Enterable)
				
				
			End if 
			ON ERR CALL:C155("")
			doSearch:=0
			////  CHOPPED   Area_Refresh (eSrchPat)  // ### jwm ### 20171002_1734 CalendarSet command invalid with an Area List
		End if 
End case 


