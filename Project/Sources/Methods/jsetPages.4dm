//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-04-06T05:00:00Z)
// Method: jsetPages
// Description 
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($k)
C_POINTER:C301($1)
MESSAGES OFF:C175
Case of 
	: ($1->=0)
		If (aPages=Null:C1517)
			ARRAY LONGINT:C221(aPagePath; Get last table number:C254)
		End if 
		$1->:=aPagePath{Table:C252(ptCurTable)}
		
	: (aPages{aPages}="id to Console")
		C_POINTER:C301($ptid)
		C_LONGINT:C283($viPage)
		$viPage:=FORM Get current page:C276
		$ptid:=STR_Get_idPointer(Table name:C256(ptCurTable))
		ConsoleLog($ptid->)
		aPages:=$viPage
	: (aPages{aPages}="Help")
		KeyModifierCurrent
		If ((OptKey=1) & (CmdKey=1))
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="iLo@"; *)
			QUERY:C277([TallyMaster:60];  | [TallyMaster:60]purpose:3="AcceptTest@"; *)
			QUERY:C277([TallyMaster:60];  | [TallyMaster:60]purpose:3="email@"; *)
			QUERY:C277([TallyMaster:60];  | [TallyMaster:60]purpose:3="Shipping@"; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=Table:C252(ptCurTable))
			If (Records in selection:C76([TallyMaster:60])>0)
				ProcessTableOpen(Table:C252(->[TallyMaster:60])*-1)
			End if 
		Else 
			HelpPopUp(<>viHelpSet; "iLo_"+Table name:C256(ptCurTable)+",page"+String:C10(FORM Get current page:C276))
		End if 
		If (aPages=Null:C1517)
			ARRAY LONGINT:C221(aPagePath; Get last table number:C254)
		End if 
		aPages:=aPagePath{Table:C252(ptCurTable)}
	: (aPages{aPages}="Execute")
		READ ONLY:C145([TallyMaster:60])
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="iLoScripts"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=Storage:C1525.user.securityLevel; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=Table:C252(ptCurTable))
		If (Records in selection:C76([TallyMaster:60])>0)
			
			
		End if 
		UNLOAD RECORD:C212([TallyMaster:60])
		aPages:=aPagePath{Table:C252(ptCurTable)}
	: ($1->=FORM Get current page:C276)
		//no action    
	Else 
		$k:=$1->
		var $vtFormName : Text
		//$vtFormName:=Current form name
		If (process_o.form=Null:C1517)
			process_o.form:=""
		End if 
		Case of 
			: (Current form name:C1298="Input")  // in the legacy layout.
				FORM GOTO PAGE:C247($k)
				Case of 
					: (aPages{aPages}="Docs")
						OBJECT SET SUBFORM:C1138(*; "SF_List"; "ListDocument")
					: (aPages{aPages}="Q&A")
						OBJECT SET SUBFORM:C1138(*; "SF_List"; "ListQA")
					: (aPages{aPages}="Object")
						OBJECT SET SUBFORM:C1138(*; "SF_List"; "ListObject")
						//SF_Tell(OBJECT Get pointer(Object current); OBJECT Get value(OBJECT Get name(Object current)))
						//process_o.layout:="Object"
						//CALL SUBFORM CONTAINER(-100)
						
				End case 
				
			: (process_o.form="OutputDS")  // in the List area and need a window for just the record.
				Process_ByID
				//var $obPassable : Object
				//$ent:=process_o.cur
				//$obPassable:=New object("tableName"; process_o.dataClassName; \
																																			"form"; ""; "tableForm"; \
																																			process_o.dataClassName+"_InputDS"; \
																																			"ents"; _LB_process__.ents; \
																																			"pos"; _LB_process__.pos; \
																																			"cur"; _LB_process__.cur; \
																																			"sel"; _LB_process__.sel; \
																																			"page"; aPages; \
																																			"parentProcess"; Current process)
				//$viProcess:=New process("Process_ByID"; 0; process_o.dataClassName+" - "+String(Count tasks); $obPassable)
				
			: (Current form name:C1298="InputDS")
				FORM GOTO PAGE:C247($k)
				SF_Manage_Pages
		End case 
		
		If (ptCurTable#(->[Admin:1]))
			Set_Window_Title($1)
		End if 
		aPagePath{Table:C252(ptCurTable)}:=$k
End case 