//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-10-26T00:00:00, 10:19:50
// ----------------------------------------------------
// Method: Pro_FillArray
// Description
// Modified: 10/26/16
// 
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $i; $k; $2; $3)
C_TEXT:C284($4)

//Console_Log ("TEST: PROFILES")


If ($1=-9)
	If (($3#1) | ($4#""))
		QUERY:C277([Profile:59]; [Profile:59]tableNum:1=$2; *)
		If ($4="")
			QUERY:C277([Profile:59]; [Profile:59]docNumID:2=$3)
		Else 
			QUERY:C277([Profile:59]; [Profile:59]idForeign:3=$4)
		End if 
		$1:=Records in selection:C76([Profile:59])
	Else 
		$1:=0
	End if 
End if 

//Console_Log ("TEST: END PROFILES")

Case of 
	: ($1=0)
		ARRAY TEXT:C222(aProOrName; $1)  //name rays
		ARRAY TEXT:C222(aProOrValue; $1)  //name rays
		ARRAY LONGINT:C221(aProOrRec; $1)  //name rays
		ARRAY LONGINT:C221(aProOrSeq; $1)  //name rays
	: ($1>0)
		SELECTION TO ARRAY:C260([Profile:59]; aProOrRec; [Profile:59]name:4; aProOrName; [Profile:59]value:5; aProOrValue; [Profile:59]seq:11; aProOrSeq)
	: ($1=-4)  //fill specific record
		
	: ($1=-5)  //Save the changes
		// ### bj ### 20181212_2147
		// fix this to get rid of selection to array
		QUERY:C277([Profile:59]; [Profile:59]tableNum:1=$2; *)
		If ($4="")
			QUERY:C277([Profile:59]; [Profile:59]docNumID:2=$3)
		Else 
			QUERY:C277([Profile:59]; [Profile:59]idForeign:3=$4)
		End if 
		If (Records in selection:C76([Profile:59])>Size of array:C274(aProOrName))
			REDUCE SELECTION:C351([Profile:59]; Records in selection:C76([Profile:59])-Size of array:C274(aProOrName))
			DELETE SELECTION:C66([Profile:59])
			QUERY:C277([Profile:59]; [Profile:59]tableNum:1=$2; *)
			If ($4="")
				QUERY:C277([Profile:59]; [Profile:59]docNumID:2=$3)
			Else 
				QUERY:C277([Profile:59]; [Profile:59]idForeign:3=$4)
			End if 
		End if 
		$k:=Size of array:C274(aProOrName)
		ARRAY LONGINT:C221($aFileNum; $k)
		ARRAY LONGINT:C221($aDocNum; $k)
		ARRAY TEXT:C222($aAcct; $k)
		For ($i; 1; $k)
			$aFileNum{$i}:=$2
			$aDocNum{$i}:=$3
			$aAcct{$i}:=$4
		End for 
		ARRAY TO SELECTION:C261(aProOrName; [Profile:59]name:4; aProOrValue; [Profile:59]value:5; $aFileNum; [Profile:59]tableNum:1; $aDocNum; [Profile:59]docNumID:2; $aAcct; [Profile:59]idForeign:3; aProOrSeq; [Profile:59]seq:11)
	: ($1=-3)  //add a line, $2 for $3 lines    
		//
		INSERT IN ARRAY:C227(aProOrName; $2; $3)  //name rays
		INSERT IN ARRAY:C227(aProOrValue; $2; $3)  //complete bullets
		INSERT IN ARRAY:C227(aProOrRec; $2; $3)  //complete bullets
		INSERT IN ARRAY:C227(aProOrSeq; $2; $3)
		//    
	: ($1=-1)  //delete a line, $2 for $3 lines
		//
		If (Size of array:C274(aProOrRec)>0)
			DELETE FROM ARRAY:C228(aProOrName; $2; $3)  //name rays
			DELETE FROM ARRAY:C228(aProOrValue; $2; $3)  //complete bullets    
			DELETE FROM ARRAY:C228(aProOrRec; $2; $3)  //complete bullets
			DELETE FROM ARRAY:C228(aProOrSeq; $2; $3)
		End if 
		//
	: ($1=-6)  //Show Subset
		
	: ($1=-7)  //Omit Subset
		
	: ($1=-8)
		//ArraySort(aProOrSeq;">";aProOrName;"=";aProOrValue;"=";aProOrRec;"=")
		MULTI SORT ARRAY:C718(aProOrSeq; >; aProOrName; >; aProOrValue; >; aProOrRec; >)
End case 