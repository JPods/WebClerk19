//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2; $3)
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(aQQuestKey; 0)
		ARRAY TEXT:C222(aQQuest; 0)
		ARRAY LONGINT:C221(aQQRec; 0)
		ARRAY LONGINT:C221(aQQCol; 0)
		ARRAY TEXT:C222(aQQGroup; 0)
		ARRAY LONGINT:C221(aQQDays; 0)
		//
		ARRAY LONGINT:C221(aQQLns; 0)
	: ($1>0)
		SELECTION TO ARRAY:C260([QAQuestion:71]; aQQRec; [QAQuestion:71]idNum:1; aQQuestKey; [QAQuestion:71]question:3; aQQuest; [QAQuestion:71]seq:4; aQQCol; [QAQuestion:71]daysToAdd:5; aQQDays; [QAQuestion:71]TableGroup:7; aQQGroup)
		
	: ($1=-5)  //array to selection
	: ($1=-3)  //new line
		
End case 
