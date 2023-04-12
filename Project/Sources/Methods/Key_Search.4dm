//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-06-24T00:00:00, 00:51:02
// ----------------------------------------------------
// Method: Key_Search
// Description
// Modified: 06/24/13
// 
// 
//
// Parameters
// ----------------------------------------------------

// DELETETHIS

// ### bj ### 20200519_0009
// replace this

//
C_TEXT:C284($1; $keywords; vURLQueryScript; vURLKeywords)
C_POINTER:C301($2; $ptKeyField; $ptTable)  //the Table the Keyword is to find a match to
C_TEXT:C284($wildCard; $3)  //"@"
C_TEXT:C284($4; $5)
C_LONGINT:C283($0)
$0:=0
C_BOOLEAN:C305($webbased; $showretired)
$webbased:=False:C215
$hideretired:=True:C214
$ptKeyField:=$2
ARRAY TEXT:C222($aCombinedAlpha; 0)
ARRAY LONGINT:C221($aCombinedLong; 0)
$wildCard:=$3
If (Count parameters:C259>3)
	$webbased:=($4="web")
	If (Count parameters:C259>4)
		$hideretired:=($5#"showretired")
	End if 
End if 
vURLKeywords:=""  // start empty
//
C_LONGINT:C283($p; $cycleCnt; $tableNum)
$tableNum:=Table:C252($2)
$ptTable:=Table:C252($tableNum)
C_TEXT:C284($testWord)

// Modified by: Bill James (2023-01-14T06:00:00Z)
// ; ", "; ";")
$keyWords:=Replace string:C233($1; ", "; ";")
$keyWords:=Replace string:C233($keyWords; ","; ";")
$keyWords:=Replace string:C233($keyWords; "; "; ";")
$keyWords:=Replace string:C233($keyWords; " "; ";")
$firstLoop:=0
If ($keyWords#"")
	Repeat 
		
		$p:=Position:C15(";"; $keyWords)
		If ($p>0)
			$testWord:=Substring:C12($keyWords; 1; $p-1)
			$keyWords:=Substring:C12($keyWords; $p+1)
		Else 
			$testWord:=$keyWords
			$p:=0  // consume the last keyword, drop out
		End if 
		If ($testWord#"")
			ARRAY LONGINT:C221($aKeywordRecs; 0)
			ARRAY TEXT:C222($akeywordWord; 0)
			ARRAY TEXT:C222($akeywordRelated; 0)
			QUERY:C277([zzzWord:99]; [zzzWord:99]tableNum:2=$tableNum; *)
			QUERY:C277([zzzWord:99];  & [zzzWord:99]wordCombined:5=$testWord+$wildCard)
			C_LONGINT:C283($cntRay; $incRay; $w)
			If ($firstLoop=0)  // first time through
				SELECTION TO ARRAY:C260([zzzWord:99]relatedAlpha:8; $akeywordRelated)
				$cntRay:=Size of array:C274($akeywordRelated)
				For ($incRay; 1; $cntRay)
					$w:=Find in array:C230($aCombinedAlpha; $akeywordRelated{$incRay})
					If ($w=-1)
						APPEND TO ARRAY:C911($aCombinedAlpha; $akeywordRelated{$incRay})
					End if 
				End for 
				
			Else 
				SELECTION TO ARRAY:C260([zzzWord:99]relatedAlpha:8; $akeywordRelated)
				$cntRay:=Size of array:C274($aCombinedAlpha)
				For ($incRay; $cntRay; 1; -1)
					$w:=Find in array:C230($akeywordRelated; $aCombinedAlpha{$incRay})
					If ($w=-1)
						DELETE FROM ARRAY:C228($aCombinedAlpha; $incRay; 1)
					End if 
				End for 
				
				
			End if 
			$firstLoop:=$firstLoop+1
			//
			vURLWords:="QUERY([Word];&[Word]TableNum="+String:C10($tableNum)+";*)"+"\r"
			vURLWords:=vURLWords+"QUERY([Word];&[Word]WordCombined="+Txt_Quoted($testWord+$wildCard)+";*)"+"\r"
			
		End if 
		
	Until ($p=0)
	vURLWords:=vURLWords+"QUERY([Word])"
	$cntRay:=Size of array:C274($aCombinedAlpha)
	If ($cntRay>0)
		CREATE EMPTY SET:C140($ptTable->; "current")
		Case of 
			: ($ptTable=(->[Item:4]))
				For ($incRay; 1; $cntRay)
					QUERY:C277([Item:4]; [Item:4]itemNum:1=$aCombinedAlpha{$incRay}; *)
					If ($hideretired)
						QUERY:C277([Item:4];  & [Item:4]retired:64=False:C215; *)
					End if 
					If ($webbased)
						QUERY:C277([Item:4];  & [Item:4]publish:60>0; *)
						QUERY:C277([Item:4];  & [Item:4]publish:60<=viEndUserSecurityLevel; *)
					End if 
					QUERY:C277([Item:4])
					If (Records in selection:C76($ptTable->)>0)
						ADD TO SET:C119($ptTable->; "current")
					End if 
				End for 
				
			: ($ptTable=(->[Customer:2]))
				
				For ($incRay; 1; $cntRay)
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=$aCombinedAlpha{$incRay}; *)
					If ($hideretired)
						QUERY:C277([Customer:2];  & ; [Customer:2]dateRetired:111=!00-00-00!; *)
					End if 
					If ($webbased)
						QUERY:C277([Customer:2];  & [Customer:2]publish:91>0; *)
						QUERY:C277([Customer:2];  & [Customer:2]publish:91<=viEndUserSecurityLevel; *)
					End if 
					QUERY:C277([Customer:2])
					If (Records in selection:C76($ptTable->)>0)
						ADD TO SET:C119($ptTable->; "current")
					End if 
				End for 
				
			Else 
				For ($incRay; 1; $cntRay)
					QUERY:C277($ptTable->; $ptKeyField->=$aCombinedAlpha{$incRay})
					If (Records in selection:C76($ptTable->)>0)
						ADD TO SET:C119($ptTable->; "current")
					End if 
				End for 
				
		End case 
		USE SET:C118("current")
		CLEAR SET:C117("current")
		$0:=Records in selection:C76($ptTable->)
	End if 
End if 


C_LONGINT:C283(<>queryItemsByFormula)
If (<>queryItemsByFormula=1)
	// QUERY BY FORMULA([Item];([Item]ItemNum=[Word]RelatedAlpha & [Word]WordOnly=vText & [Item]Retired=False)) 
End if 





