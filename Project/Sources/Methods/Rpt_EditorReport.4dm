//%attributes = {"publishedWeb":true}
//Method: Rpt_EditorReport
C_LONGINT:C283($1; $sortBy; $issueDT)
C_TEXT:C284($2; $publication)
C_TEXT:C284($3; $issueText)
$publication:=""
$issueText:=""
$doReport:=False:C215
If (Count parameters:C259=0)
	$sortBy:=1
Else 
	$sortBy:=$1
	If (Count parameters:C259>1)
		$publication:=$2
		If (Count parameters:C259>2)
			$issueText:=$3
			$doReport:=True:C214
		End if 
	End if 
End if 
TRACE:C157
If (Not:C34($doReport))
	ALERT:C41("Requires both Publication and Issue values>")
Else 
	QUERY:C277([Item:4]; [Item:4]profile1:35=$publication; *)
	QUERY:C277([Item:4];  & [Item:4]profile2:36=$issueText)
	If (Records in selection:C76([Item:4])=0)
		ALERT:C41("There were no articles for "+$publication+"; "+$issueText)
	Else 
		CONFIRM:C162("Report on : "+$publication+"; "+$issueText)
		If (OK=1)
			C_LONGINT:C283($i; $k; $incService; $cntService)
			$k:=0  //Size of array(aTmp35Str1)
			ARRAY TEXT:C222(aTmp10Str1; $k)  //custID
			ARRAY TEXT:C222(aTmp25Str1; $k)  //nameID
			ARRAY TEXT:C222(aQueryFieldNames; $k)  //company
			ARRAY LONGINT:C221(aTmpLong1; $k)  //Item Rec
			ARRAY LONGINT:C221(aTmpLong2; $k)  //Service Rec
			ARRAY LONGINT:C221(aTmpLong3; $k)  //contact Unique
			ARRAY TEXT:C222(aTmp35Str1; $k)  //ItemNum
			ARRAY TEXT:C222(aText1; $k)  //Publication
			ARRAY TEXT:C222(aText2; $k)  //Issue
			ARRAY TEXT:C222(aText3; $k)  //Publisher
			ARRAY TEXT:C222(aText4; $k)  //Pages
			ARRAY TEXT:C222(aText5; $k)  //Title
			//
			ARRAY LONGINT:C221($aItemRecs; 0)
			ARRAY TEXT:C222($aItemNumbers; 0)
			SELECTION TO ARRAY:C260([Item:4]; $aItemRecs; [Item:4]itemNum:1; $aItemNumbers)
			$k:=Size of array:C274($aItemRecs)
			For ($i; 1; $k)
				GOTO RECORD:C242([Item:4]; $aItemRecs{$i})
				QUERY:C277([Service:6]; [Service:6]reference:37=[Item:4]itemNum:1)
				$cntService:=Records in selection:C76([Service:6])
				FIRST RECORD:C50([Service:6])
				For ($incService; 1; $cntService)
					INSERT IN ARRAY:C227(aTmp10Str1; 1; 1)  //CustID          
					INSERT IN ARRAY:C227(aTmp25Str1; 1; 1)  //nameID
					INSERT IN ARRAY:C227(aTmp40Str1; 1; 1)  //company
					INSERT IN ARRAY:C227(aTmpLong1; 1; 1)  //Item Rec
					INSERT IN ARRAY:C227(aTmpLong2; 1; 1)  //Service Rec
					INSERT IN ARRAY:C227(aTmpLong3; 1; 1)  //ContactUnique
					INSERT IN ARRAY:C227(aTmp35Str1; 1; 1)  //ItemNum
					INSERT IN ARRAY:C227(aText1; 1; 1)  //Publication
					INSERT IN ARRAY:C227(aText2; 1; 1)  //Issue
					INSERT IN ARRAY:C227(aText3; 1; 1)  //Publisher
					INSERT IN ARRAY:C227(aText4; 1; 1)  //Pages
					INSERT IN ARRAY:C227(aText5; 1; 1)  //Title
					aTmp10Str1{1}:=[Service:6]customerID:1
					aTmp25Str1{1}:=[Service:6]actionBy:12
					aQueryFieldNames{1}:=[Service:6]company:48
					aTmpLong1{1}:=$aItemRecs{$i}
					aTmpLong2{1}:=Record number:C243([Service:6])
					aText1{1}:=[Item:4]profile1:35  //$aPublication{$i}:=
					aText2{1}:=[Item:4]profile2:36  //          
					aTmpLong3{1}:=[Service:6]contactid:52
					aText3{1}:=[Item:4]typeid:26  //$aIssue{$i}:=
					aText4{1}:=[Item:4]unitofMeasure:11  //$aPages{$i}:=
					aText5{1}:=[Item:4]description:7  //$aTitle{$i}:=
					NEXT RECORD:C51([Service:6])
				End for 
			End for 
			Case of 
				: ($sortBy<1)  //no action
				: ($sortBy=1)  //publication, issue, title, sales, company
					MULTI SORT ARRAY:C718(aText1; >; aText2; >; aText5; >; aTmp25Str1; >; aQueryFieldNames; >; aTmpLong2; aTmpLong1)  //;aText4;aText3              
				: ($sortBy=2)  //publication, issue, company, sales, title
					MULTI SORT ARRAY:C718(aText1; >; aText2; >; aQueryFieldNames; >; aTmp25Str1; >; aText5; >; aTmpLong2; aTmpLong1)  //;aText4;aText3
				: ($sortBy=3)  //publication, issue, title, company, sales
					MULTI SORT ARRAY:C718(aText1; >; aText2; >; aText5; >; aQueryFieldNames; >; aTmp25Str1; >; aTmpLong2; aTmpLong1)  //;aText4;aText3
				: ($sortBy=4)  //publication, issue, sales, title, company
					MULTI SORT ARRAY:C718(aText1; >; aText2; >; aTmp25Str1; >; aText5; >; aQueryFieldNames; >; aTmpLong2; aTmpLong1)  //;aText4;aText3     
				: ($sortBy=5)  //publication, issue, sales, company, title
					MULTI SORT ARRAY:C718(aText1; >; aText2; >; aTmp25Str1; >; aQueryFieldNames; >; aText5; >; aTmpLong2; aTmpLong1)  //;aText4;aText3              
			End case 
		End if 
	End if 
End if 