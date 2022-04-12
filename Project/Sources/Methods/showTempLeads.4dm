//%attributes = {"publishedWeb":true}
C_LONGINT:C283($fileNum; vHere)
$fileNum:=0
Case of 
	: (vHere=0)
		DB_ShowByTableName("Lead")
	: (vHere=1)
		Case of 
			: (ptCurTable=(->[QA:70]))
				RelateByFileNum(Table:C252(->[Lead:48]); ->[QA:70]; ->[QA:70]tableNum:11; ->[QA:70]customerID:1)
			: (ptCurTable=(->[CallReport:34]))
				RelateByFileNum(Table:C252(->[Lead:48]); ->[CallReport:34]; ->[CallReport:34]tableNum:2; ->[CallReport:34]customerID:1)
				//: (ptCurFile=([CallReport]))
				//SEARCH SELECTION([CallReport];[CallReport]FileID=File([Lead]))
				//C_LONGINT($i;$k)
				//C_TEXT($acctCode)
				//SEARCH SELECTION([CallReport];[CallReport]FileID=File([Lead]))
				//$k:=Records in selection([CallReport])
				//TRACE
				//If ($k>0)
				//SORT SELECTION([CallReport];[CallReport]customerID)
				//$acctCode:=""
				//REDUCE SELECTION([Lead];0)
				//CREATE SET([Lead];"Current")
				//$i:=0
				//Repeat 
				//If ($acctCode#[CallReport]customerID)
				//SEARCH([Lead];[Lead]UniqueID=Num([CallReport]customerID))
				//ADD TO SET([Lead];"Current")
				//$acctCode:=[CallReport]customerID
				//End if 
				//NEXT RECORD([CallReport])
				//$i:=$i+1
				//Until ($i>=$k)
				//USE SET("Current")
				//CLEAR SET("Current")
				//End if 
			Else 
				DB_ShowByTableName("CallReport")
		End case 
		$fileNum:=Table:C252(->[Lead:48])*Num:C11(Records in selection:C76([Lead:48])>0)
		If ($fileNum>0)
			ProcessTableOpen(Table:C252($fileNum))
		End if 
	Else 
		jAlertMessage(10100)
End case 