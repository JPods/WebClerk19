//%attributes = {"publishedWeb":true}
//Procedure: RelateByFileNum
//([CallReport];[CallReport]FileID;[CallReport]customerID)
C_LONGINT:C283($i; $k)
C_TEXT:C284($theAcct)
C_POINTER:C301($2; $3; $4)  //[CallReport]; [CallReport]FileID; [CallReport]customerID
C_LONGINT:C283($1)
$curTableNum:=$1
$ptCurFile:=(Table:C252($curTableNum))
$k:=Records in selection:C76($2->)
If ($k>0)
	ORDER BY:C49($2->; $3->; $4->)
	FIRST RECORD:C50($2->)  //[CallReport])
	$i:=0
	$theAcct:=""
	CREATE EMPTY SET:C140(Table:C252($curTableNum)->; "Current")
	Repeat 
		$i:=$i+1
		If (($theAcct#$4->) & ($curTableNum=$3->))
			$theAcct:=$4->
			Case of 
				: ($curTableNum=2)  //Customers
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=$theAcct)
				: ($curTableNum=Table:C252(->[Contact:13]))  //Contacts
					QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11($theAcct))
				: ($curTableNum=Table:C252(->[Vendor:38]))  //Vendor
					$acctCode:=[Vendor:38]vendorID:1
					QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=$theAcct)
			End case 
			ADD TO SET:C119($ptCurFile->; "Current")
		End if 
		NEXT RECORD:C51($2->)  //[CallReport])
	Until ($i>=$k)
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
End if 