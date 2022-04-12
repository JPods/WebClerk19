//%attributes = {"publishedWeb":true}
//jImportMassive
//June 7, 2002
C_LONGINT:C283($i; $o; $k)
C_BOOLEAN:C305($doSave; <>ThermoAbort)
vRecDelim:="\r"
//If (OK=1)
//vFldSepBeg:=Char(34)
//vFldSepEnd:=Char(34)
//vFldDelim:=","
//Else 
vFldSepBeg:=""
vFldSepEnd:=""
vFldDelim:="\t"
C_TEXT:C284(vSearchBy)
KeyModifierCurrent
// CONFIRM("This will take a long time.")
OK:=1
CmdKey:=1
vText1:="Beldin:Applications:4Dv15.4:Jit-DataMemory-Dump:"
If (OK=1)
	//CONFIRM("Add Quots")
	vRecDelim:="\r"
	//If (OK=1)
	//vFldSepBeg:=Char(34)
	//vFldSepEnd:=Char(34)
	//vFldDelim:=","
	//Else 
	vFldSepBeg:=""
	vFldSepEnd:=""
	vFldDelim:="\t"
	// End if   
	If (CmdKey=0)
		For ($o; 1; Get last table number:C254)
			// ThermoInitExit ("Loading records";20000;True)
			$i:=0
			If (OptKey=1)
				CONFIRM:C162("Import for file "+Table name:C256($o))
			Else 
				OK:=1
			End if 
			If (OK=1)
				$strName:=Storage:C1525.folder.jitF+"zzzME_"+Table name:C256($o)+".mdd"
				// $strName:=Storage.folder.jitF+"zzzME_"+String($o;"000")+Table name($o)+".mdd"
				If (HFS_Exists($strName)=1)
					READ WRITE:C146(Table:C252($o)->)
					ALL RECORDS:C47(Table:C252($o)->)
					DELETE SELECTION:C66(Table:C252($o)->)
					SET CHANNEL:C77(10; $strName)
					MESSAGE:C88("Importing Table: "+$strName)
					If (OK=1)
						Repeat 
							$i:=$i+1
							//  CREATE RECORD(Table($o)->) // no longer needed
							RECEIVE RECORD:C79(Table:C252($o)->)
							If (OK=1)
								$doSave:=IEA_UniqueByTables(Table:C252($o))
								If ($doSave)
									SAVE RECORD:C53(Table:C252($o)->)
								End if 
							End if 
							//ThermoUpdate ($i)
							If (<>ThermoAbort)
								$i:=$k
							End if 
						Until (OK=0)
						SET CHANNEL:C77(11)
					End if 
				End if 
			End if 
		End for 
		
		
		
		
		// ThermoClose 
	Else 
		
		
		//vText1:=Get_FolderName ("Select folder for importing all.")
		If (vText1#"")
			vi9:=HFS_CatToArray(vText1; "aText1")
			vi2:=Size of array:C274(aText1)
			TRACE:C157
			For (vi1; 1; vi2)
				KeyModifierCurrent
				If (CapKey=1)
					TRACE:C157
				End if 
				vi8:=Num:C11(Substring:C12(aText1{vi1}; 1; 3))
				If ((vi8>0) & (vi8<100))
					curTableNum:=vi8
					StructureFields(curTableNum)
					
					myDoc:=Open document:C264(vText1+aText1{vi1}; Read mode:K24:5)
					jimpGenImpArray
					KeyModifierCurrent
					If (CapKey=1)
						TRACE:C157
					End if 
					
					EI_AutoMatch
					KeyModifierCurrent
					If (CapKey=1)
						TRACE:C157
					End if 
					OK:=jimport_FillRay
					READ WRITE:C146(Table:C252(curTableNum)->)
					ALL RECORDS:C47(Table:C252(curTableNum)->)
					DELETE SELECTION:C66(Table:C252(curTableNum)->)
					jimpMultipleRec
					KeyModifierCurrent
					If (CapKey=1)
						TRACE:C157
					End if 
				End if 
			End for 
		End if 
	End if 
End if 


REDRAW WINDOW:C456
//CONFIRM("Delete ALL RECORDS???")
//If (OK=1)
//CONFIRM("Really??  DELETE ALL RECORDS????")
//If (OK=1)
//vi2:=Count tables
//For (vi1;1;vi2)
//READ WRITE(Table(vi1)->)
//ALL RECORDS(Table(vi1)->)
//DELETE SELECTION(Table(vi1)->)
//End for 
//End if 
//End if 

If (False:C215)
	vText1:=Get_FolderName("Select folder for importing all.")
	If (vText1#"")
		vi9:=HFS_CatToArray(vText1; "aText1")
		vi2:=Size of array:C274(aText1)
		For (vi1; 1; vi2)
			vi8:=Num:C11(Substring:C12(aText1{vi1}; 1; 3))
			If ((vi8>0) & (vi8<100))
				curTableNum:=vi8
				StructureFields(curTableNum)
				myDoc:=Open document:C264(vText1+aText1{vi1})
				jimpGenImpArray
				EI_AutoMatch
				OK:=jimport_FillRay
				READ WRITE:C146(Table:C252(curTableNum)->)
				ALL RECORDS:C47(Table:C252(curTableNum)->)
				DELETE SELECTION:C66(Table:C252(curTableNum)->)
				jimpMultipleRec
				
			End if 
		End for 
	End if 
	
	
	
	
	
End if 



If (False:C215)
	
	For ($o; 1; Get last table number:C254)
		// ThermoInitExit ("Loading records";20000;True)
		$i:=0
		OK:=1
		
		If (OK=1)
			// $strName:=Storage.folder.jitF+"zzzME_"+String($o;"000")+Table name($o)+".mdd"
			$strName:=Storage:C1525.folder.jitF+"zzzME_"+Table name:C256($o)+".mdd"
			If (HFS_Exists($strName)=1)
				READ WRITE:C146(Table:C252($o)->)
				ALL RECORDS:C47(Table:C252($o)->)
				DELETE SELECTION:C66(Table:C252($o)->)
				SET CHANNEL:C77(10; $strName)
				MESSAGE:C88("Importing Table: "+$strName)
				If (OK=1)
					Repeat 
						$i:=$i+1
						//  CREATE RECORD(Table($o)->) // no longer needed
						RECEIVE RECORD:C79(Table:C252($o)->)
						If (OK=1)
							$doSave:=IEA_UniqueByTables(Table:C252($o))
							If ($doSave)
								SAVE RECORD:C53(Table:C252($o)->)
							End if 
						End if 
					Until (OK=0)
					SET CHANNEL:C77(11)
				End if 
			End if 
		End if 
	End for 
	
End if 


If (False:C215)  // 
	For (vi1; 1; Get last table number:C254)
		vText1:=Storage:C1525.folder.jitF+"zzzME_"+Table name:C256(vi1)+".mdd"
		If (HFS_Exists(vText1)=1)
			READ WRITE:C146(Table:C252(vi1)->)
			ALL RECORDS:C47(Table:C252(vi1)->)
			DELETE SELECTION:C66(Table:C252(vi1)->)
			SET CHANNEL:C77(10; vText1)
			MESSAGE:C88("Importing Table: "+vText1)
			If (OK=1)
				Repeat 
					vi9:=vi9+1
					RECEIVE RECORD:C79(Table:C252(vi1)->)
					If (OK=1)
						SAVE RECORD:C53(Table:C252(vi1)->)
					End if 
				Until (OK=0)
				SET CHANNEL:C77(11)
			End if 
		End if 
	End for 
End if 