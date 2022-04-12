//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2)
C_BOOLEAN:C305($3)
C_LONGINT:C283($theType)
$doPop:=False:C215
TRACE:C157
If (Not:C34($3))  //do not change the current record
	If (Record number:C243([TechNote:58])>-1)
		PUSH RECORD:C176([TechNote:58])
		$doPop:=True:C214
	End if 
End if 
$theType:=Type:C295($1->)
If (($theType=0) | ($theType=2) | ($theType=22))
	QUERY:C277([TechNote:58]; $1->=$2->+"@")
Else 
	QUERY:C277([TechNote:58]; $1->=$2->)
End if 
If (Records in selection:C76([TechNote:58])>0)
	SELECTION TO ARRAY:C260([TechNote:58]name:2; aTNName; [TechNote:58]subject:6; aTNSub; [TechNote:58]; aTNRec; [TechNote:58]chapter:14; aTNChap; [TechNote:58]section:15; aTNSect)
	If ($3)
		MULTI SORT ARRAY:C718(aTNChap; >; aTNSect; >; aTNName; aTNSub; aTNRec)
		ARRAY LONGINT:C221(aTNRecSel; 1)
		aTNRecSel{1}:=1
		GOTO RECORD:C242([TechNote:58]; aTNRec{1})
		vi3:=Record number:C243([TechNote:58])
		srTNName:=[TechNote:58]name:2
		srTNSubject:=[TechNote:58]subject:6
		srTnKey:=""
		vi2:=[TechNote:58]chapter:14
		//**WR UPDATE MODE (eTechNote;0)
		//**WR PICTURE TO AREA (eTechNote;[TechNote]Body_)
		//**WR O DISPLAY RULER (eTechNote;1)
		
		
		//**WR UPDATE MODE (eTechNote;1)
		//
		//  --  CHOPPED  AL_UpdateArrays(eTNList; -2)
		viHorz:=1
		viVert:=1
		// -- AL_SetSelect(eTNList; aTNRecSel)
		// -- AL_SetScroll(eTNList; viVert; viHorz)
	Else 
		If ($doPop)
			POP RECORD:C177([TechNote:58])
		End if 
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 