TRACE:C157
C_LONGINT:C283($i; $k)
C_POINTER:C301($ptField)
$k:=Size of array:C274(aFieldLns)
If ($k>0)
	Case of 
		: (aTmp20Str2=1)
			$ptField:=Field:C253(Table:C252(ptCurTable); theFldNum{aFieldLns{1}})
			QUERY:C277(ptCurTable->; $ptField->=vText8)
		: (aTmp20Str2=2)
			$ptField:=Field:C253(Table:C252(ptCurTable); theFldNum{aFieldLns{1}})
			QUERY:C277(ptCurTable->; $ptField->=vText8+"@")
		: (aTmp20Str2=3)
			$ptField:=Field:C253(Table:C252(ptCurTable); theFldNum{aFieldLns{1}})
			QUERY:C277(ptCurTable->; $ptField->="@"+vText8+"@")
		: (aTmp20Str2=4)
			COPY SET:C600("UserSet"; "<>curSelSet")
			UNLOAD RECORD:C212(ptCurTable->)
			C_LONGINT:C283($viProcess)
			TRACE:C157
			C_LONGINT:C283($fieldNum; $tableNum)
			$fieldNum:=theFldNum{aFieldLns{1}}
			$tableNum:=Table:C252(ptCurTable)
			//   vText7   //set in layout
			$viProcess:=New process:C317("PrsApplyToUserSet"; <>tcPrsMemory; "Apply-"+Table name:C256(ptCurTable); $tableNum; $fieldNum; vText7)
	End case 
	If (Records in selection:C76(ptCurTable->)>0)
		For ($i; 1; $k)
			$ptField:=Field:C253(Table:C252(ptCurTable); theFldNum{aFieldLns{$i}})
			TxtReplaceString($ptField; vText8; vText7)
		End for 
	Else 
		ALERT:C41("No  records in selection")
	End if 
Else 
	ALERT:C41("Select Field (s) to change")
End if 