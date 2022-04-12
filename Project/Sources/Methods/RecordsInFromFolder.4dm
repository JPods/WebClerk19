//%attributes = {}
C_LONGINT:C283(vi1; vi2; vi7; vi11)
C_POINTER:C301(iLoPointer1)
C_TEXT:C284(myFolder)

KeyModifierCurrent
If (OptKey=0)
	
	myFolder:=Select folder:C670("")
	If (OK=1)
		ARRAY TEXT:C222(a40Str1; 0)
		DOCUMENT LIST:C474(myFolder; a40Str1)
		vi2:=Size of array:C274(a40Str1)
		For (vi1; 1; vi2)
			vi7:=Num:C11(Substring:C12(a40Str1{vi1}; 1; 3))
			If (a40Str1{vi1}[[1]]#".")
				If ((vi7>0) & (vi7<Get last table number:C254))
					MESSAGE:C88("Importing Table: "+Table name:C256(vi7))
					
					
					If (Num:C11(Caps lock down:C547)=1)
						ALERT:C41("Processing table "+Table name:C256(vi7))
					End if 
					
					iLoPointer1:=Table:C252(vi7)
					READ WRITE:C146(iLoPointer1->)
					ALL RECORDS:C47(iLoPointer1->)
					DELETE SELECTION:C66(iLoPointer1->)
					SET CHANNEL:C77(10; myFolder+a40Str1{vi1})
					vi11:=0
					If (Num:C11(Caps lock down:C547)=1)
						ALERT:C41("Processing table "+Table name:C256(vi7)+", OK "+String:C10(OK))
					End if 
					If (OK=1)
						Repeat 
							vi11:=vi11+1
							If (Num:C11(Caps lock down:C547)=1)
								ALERT:C41("Processing table "+Table name:C256(vi7)+", Record "+String:C10(vi11))
							End if 
							CREATE RECORD:C68(iLoPointer1->)
							RECEIVE RECORD:C79(iLoPointer1->)
							If (OK=1)
								SAVE RECORD:C53(iLoPointer1->)
							End if 
						Until (OK=0)
						SET CHANNEL:C77(11)
					End if 
				End if 
			End if 
		End for 
		
	End if 
	
Else 
	
	
	C_LONGINT:C283(vi1; vi2; vi7; vi11)
	C_POINTER:C301(iLoPointer1)
	C_TEXT:C284(myFolder)
	myFolder:=Select folder:C670("")
	If (OK=1)
		ARRAY TEXT:C222(a40Str1; 0)
		DOCUMENT LIST:C474(myFolder; a40Str1)
		vi2:=Size of array:C274(a40Str1)
		For (vi1; 1; vi2)
			vi7:=Num:C11(Substring:C12(a40Str1{vi1}; 1; 3))
			If (a40Str1{vi1}[[1]]#".")
				If ((vi7>0) & (vi7<Get last table number:C254))
					MESSAGE:C88("Importing Table: "+Table name:C256(vi7))
					
					iLoPointer1:=Table:C252(vi7)
					READ WRITE:C146(iLoPointer1->)
					ALL RECORDS:C47(iLoPointer1->)
					DELETE SELECTION:C66(iLoPointer1->)
					SET CHANNEL:C77(10; myFolder+a40Str1{vi1})
					vi11:=0
					If (OK=1)
						Repeat 
							vi11:=vi11+1
							CREATE RECORD:C68(iLoPointer1->)
							RECEIVE RECORD:C79(iLoPointer1->)
							If (OK=1)
								SAVE RECORD:C53(iLoPointer1->)
							End if 
						Until (OK=0)
						SET CHANNEL:C77(11)
					End if 
				End if 
			End if 
		End for 
		
	End if 
	
End if 
