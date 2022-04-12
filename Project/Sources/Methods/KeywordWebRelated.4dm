//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: KeywordWebRelated
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
//TRACE
C_LONGINT:C283($1; $2; $3)
C_TEXT:C284($4)
C_LONGINT:C283($w)
Case of 
	: ($1<0)
	: ($1=0)
		ARRAY LONGINT:C221(aWebRelatedTableNum; 0)
		ARRAY LONGINT:C221(aWebRelatedRecNum; 0)
		ARRAY TEXT:C222(aWebRelatedNote; 0)
		ARRAY LONGINT:C221(aWebBaseRecNum; 0)
	: ($1>0)
		$w:=Find in array:C230(aWebBaseRecNum; $3)
		If ($w>0)
			If ($w<=Get last table number:C254)
				//$myFile:=Request("enter spreader")
				//myDoc:=create document(Storage.folder.jitF+"Keyword"+$myFile)
				//SEND PACKET(myDoc;"$w/size of array table/recNum/Note"+String($w)+
				//"/"+String(Size of array(aWebRelatedTableNum))+"/"+String(Size of array
				//(aWebRelatedRecNum))+"/"+String(Size of array(aWebRelatedNote))+"/"+String
				//(Size of array(aWebBaseRecNum)))
				//CLOSE DOCUMENT(myDoc)
				GOTO RECORD:C242(Table:C252(aWebRelatedTableNum{$w})->; aWebRelatedRecNum{$w})
				pvRelatedComment:=aWebRelatedNote{$w}
			Else 
				ALERT:C41(vText11)
			End if 
		Else 
			pvRelatedComment:=""
		End if 
	Else 
		$w:=Size of array:C274(aWebRelatedTableNum)+1
		INSERT IN ARRAY:C227(aWebRelatedTableNum; $w; 1)
		INSERT IN ARRAY:C227(aWebRelatedRecNum; $w; 1)
		INSERT IN ARRAY:C227(aWebRelatedNote; $w; 1)
		//
		INSERT IN ARRAY:C227(aWebBaseRecNum; $w; 1)
		aWebRelatedTableNum{$w}:=$1
		aWebRelatedRecNum{$w}:=$2
		aWebBaseRecNum{$w}:=$3
		aWebRelatedNote{$w}:=$4
End case 