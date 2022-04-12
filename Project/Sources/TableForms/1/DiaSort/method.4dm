C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Load:K2:1)
		vText1:=""
		jaFilesInitial(False:C215; False:C215)  //restricted access; auto load search field
		Fld_ALDefine(eExportFlds)
		Select_ALDefine(eSrchRecs)
		
		FldMatch_ALDefine
		//  --  CHOPPED  AL_UpdateArrays(eMatchList; -2)
		
		myOK:=0
		If (ptCurTable=(->[TallyMaster:60]))
			CREATE SET:C116([TallyMaster:60]; "Current")
		End if 
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]tableNum:1=curTableNum; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="sort")
		SELECTION TO ARRAY:C260([TallyMaster:60]name:8; aTmp20Str1; [TallyMaster:60]; aTmpLong1)
		//  --  CHOPPED  AL_UpdateArrays(eSrchRecs; -2)
		UNLOAD RECORD:C212([TallyMaster:60])
		If (ptCurTable=(->[TallyMaster:60]))
			USE SET:C118("Current")
			CLEAR SET:C117("Current")
		End if 
	: (After:C31)
		Temp_RayInit
	: (Outside call:C328)
		Prs_OutsideCall
	: (doSearch#0)
		Case of 
			: ((doSearch=2) | (doSearch=3))
				C_LONGINT:C283($i; $k)
				$k:=Size of array:C274(aFieldLns)
				If (doSearch=3)
					$pos:=aMatchField
				Else 
					$pos:=Size of array:C274(aMatchField)
				End if 
				For ($i; 1; $k)
					Case of 
						: ((theTypes{theFields}="P") | (theTypes{theFields}="*") | (theTypes{theFields}=" "))
							ALERT:C41("Picture and Subfiles Files may not be imported.")
						: (Find in array:C230(aMatchField; theFields{aFieldLns{$i}})#-1)
							ALERT:C41("Warning:  you are duplicating "+theFields{aFieldLns{$i}}+".")
						Else 
							C_LONGINT:C283($pos)
							$pos:=$pos+1
							INSERT IN ARRAY:C227(aMatchField; $pos)
							INSERT IN ARRAY:C227(aMatchType; $pos)
							INSERT IN ARRAY:C227(aMatchNum; $pos)
							//
							aMatchField{$pos}:=theFields{aFieldLns{$i}}
							aMatchType{$pos}:="A"
							aMatchNum{$pos}:=theFldNum{aFieldLns{$i}}
							//      
							//  --  CHOPPED  AL_UpdateArrays(eMatchList; -2)
					End case 
				End for 
				
				Sort_Build
				
		End case 
		doSearch:=0
End case 
