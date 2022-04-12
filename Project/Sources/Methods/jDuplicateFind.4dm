//%attributes = {"publishedWeb":true}
//(GP) jDuplicateFind
C_POINTER:C301($1; $2; $4; $6)  //pointer to file;pointers to fields
C_LONGINT:C283($3; $5; $7; myOK; $index; $k)  //first x chars of field pointed to by $#-1
C_TEXT:C284($Text2; $PrvText2; $Text4; $PrvText4; $Text6; $PrvText6)
jsetDefaultFile($1)
CREATE EMPTY SET:C140($1->; "Duppes1")
CREATE EMPTY SET:C140($1->; "Duppes2")
C_LONGINT:C283($cp)
$cp:=Count parameters:C259
Case of 
	: ($cp=3)
		ORDER BY:C49($1->; $2->)
	: ($cp=5)
		ORDER BY:C49($1->; $2->; $4->)
	: ($cp=7)
		ORDER BY:C49($1->; $2->; $4->; $6->)
End case 
C_LONGINT:C283($handle4; $handle2; $handle6)
If ((Type:C295($2->)=2) | (Type:C295($2->)=0))  //type 2 is text
	$handle2:=0
Else 
	$handle2:=1
End if 
If ($3>0)  //use a substring command
	$handle2:=$handle2+2
End if 
If ($cp>4)
	If ((Type:C295($4->)=2) | (Type:C295($4->)=0))  //type 2 is text
		$handle4:=0
	Else 
		$handle4:=1
	End if 
	If ($5>0)  //use a substring command
		$handle4:=$handle4+2
	End if 
Else 
	$handle4:=-1
End if 
If ($cp>6)
	If ((Type:C295($6->)=2) | (Type:C295($6->)=0))  //type 2 is text
		$handle6:=0
	Else 
		$handle6:=1
	End if 
	If ($7>0)  //use a substring command
		$handle6:=$handle6+2
	End if 
Else 
	$handle6:=-1
End if 
FIRST RECORD:C50($1->)
$PrvText2:=""
$PrvText4:=""
$PrvText6:=""
$k:=Records in selection:C76($1->)
//ThermoInitExit (("Searching for duplicates:  "+Table name($1));$k;True)
$viProgressID:=Progress New

For ($index; 1; Records in selection:C76($1->))
	//Thermo_Update ($index)
	ProgressUpdate($viProgressID; $index; $k; "Searching for duplicates: "+Table name:C256($1))
	If (<>ThermoAbort)
		$index:=Records in selection:C76($1->)
	End if 
	Case of 
		: ($handle2=0)
			$Text2:=$2->
		: ($handle2=1)
			$Text2:=String:C10($2->)
		: ($handle2=2)
			$Text2:=Substring:C12($2->; 1; $3)
		: ($handle2=3)
			$Text2:=Substring:C12(String:C10($2->); 1; $3)
	End case 
	Case of 
		: ($handle4=-1)
		: ($handle4=0)
			$Text4:=$4->
		: ($handle4=1)
			$Text4:=String:C10($4->)
		: ($handle4=2)
			$Text4:=Substring:C12($4->; 1; $5)
		: ($handle4=3)
			$Text4:=Substring:C12(String:C10($4->); 1; $5)
	End case 
	Case of 
		: ($handle6=-1)
		: ($handle6=0)
			$Text6:=$6->
		: ($handle6=1)
			$Text6:=String:C10($6->)
		: ($handle6=2)
			$Text6:=Substring:C12($6->; 1; $7)
		: ($handle6=3)
			$Text6:=Substring:C12(String:C10($6->); 1; $7)
	End case 
	If (($Text2=$PrvText2) & ($Text4=$PrvText4) & ($Text6=$PrvText6))
		PREVIOUS RECORD:C110($1->)  //a check to avoid adding the cur rec as the prev rec in next step
		ADD TO SET:C119($1->; "Duppes1")  //is less efficent, in the case that matchs are rare, so
		NEXT RECORD:C51($1->)  //it was left out in the assumption that triple matchs will be very rare relative
		ADD TO SET:C119($1->; "Duppes2")  //to the total number of records being searched.
	End if 
	NEXT RECORD:C51($1->)
	$PrvText2:=$Text2
	$PrvText4:=$Text4
	$PrvText6:=$Text6
End for 
//Thermo_Close 
Progress QUIT($viProgressID)


If ((Records in set:C195("Duppes1")=0) & (Records in set:C195("Duppes2")=0))
	ALERT:C41("There were no duplicate records for "+Table name:C256($1)+" using the selected criteria.")
Else 
	CONFIRM:C162("Show records"; "All Dups, Sorted"; "2nds Only")
	If (OK=1)
		UNION:C120("Duppes1"; "Duppes2"; "Duppes1")
		USE SET:C118("Duppes1")
		Case of 
			: ($cp=3)
				ORDER BY:C49($1->; $2->)
			: ($cp=5)
				ORDER BY:C49($1->; $2->; $4->)
			: ($cp=7)
				ORDER BY:C49($1->; $2->; $4->; $6->)
		End case 
		CANCEL:C270
		myOK:=2
	Else 
		USE SET:C118("Duppes2")
		$k:=Records in set:C195("Duppes2")
		If ($k>0)
			CANCEL:C270
			myOK:=2
		Else 
			ALERT:C41("There were no duplicate records for "+Table name:C256($1)+" using the selected criteria.")
		End if 
	End if 
End if 
CLEAR SET:C117("Duppes1")
CLEAR SET:C117("Duppes2")