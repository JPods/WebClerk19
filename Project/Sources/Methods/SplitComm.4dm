//%attributes = {"publishedWeb":true}
//SplitComm
C_LONGINT:C283($i; $k)
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12)  //Amount; RepID; others
C_LONGINT:C283($p; $w; $pCR; $cntParam; $pPcC)
C_TEXT:C284($theText)
If (Count parameters:C259<3)
	ALERT:C41("Three parameters needed;Amount, RepID; Date")
Else 
	$cntParam:=Count parameters:C259
	$k:=Records in selection:C76(Table:C252(Table:C252($1))->)
	ORDER BY:C49(Table:C252(Table:C252($1))->; $2->)
	FIRST RECORD:C50(Table:C252(Table:C252($1))->)
	ARRAY TEXT:C222(aText1; 0)
	ARRAY TEXT:C222(aText2; 0)
	ARRAY TEXT:C222(aText3; 0)
	ARRAY TEXT:C222(aText4; 0)
	ARRAY TEXT:C222(aText5; 0)
	ARRAY TEXT:C222(aText6; 0)
	ARRAY TEXT:C222(aText7; 0)
	ARRAY TEXT:C222(aText8; 0)
	ARRAY TEXT:C222(aText9; 0)
	ARRAY TEXT:C222(aText10; 0)
	ARRAY TEXT:C222(aText11; 0)
	ARRAY TEXT:C222(aText12; 0)
	For ($i; 1; $k)
		If ($2->#[Rep:8]repID:1)
			QUERY:C277([Rep:8]; [Rep:8]repID:1=$2->)
			If ([Rep:8]split:23>1)
				$endLoop:=False:C215
				$doLine:=True:C214
				$theText:=[Rep:8]comment:19
				ARRAY TEXT:C222(aTmpText1; 0)
				ARRAY REAL:C219(aTmpReal1; 0)
				ARRAY REAL:C219(aTmpReal2; 0)  //was  1
				TRACE:C157
				Repeat 
					$p:=Position:C15("/"; $theText)
					If ($p>0)
						$theRep:=Substring:C12($theText; 1; $p-1)
						$theText:=Substring:C12($theText; $p+1)
					End if 
					$pPcC:=Position:C15("/"; $theText)
					$pCR:=Position:C15("\r"; $theText)
					$w:=Size of array:C274(aTmpText1)+1
					If ($p>0)
						INSERT IN ARRAY:C227(aTmpText1; $w; 1)
						INSERT IN ARRAY:C227(aTmpReal1; $w; 1)
						INSERT IN ARRAY:C227(aTmpReal2; $w; 1)
						aTmpText1{$w}:=$theRep
						If ($pPcC>0)
							aTmpReal1{$w}:=Round:C94(Num:C11(Substring:C12($theText; 1; $pPcC-1))*[Rep:8]comRate:13*0.01; 4)  //commission
						Else 
							aTmpReal1{$w}:=0
						End if 
						Case of 
							: (($pCR>0) & ($pPcC>0))
								aTmpReal2{$w}:=Num:C11(Substring:C12($theText; $pPcC+1; $pCR-1-$pPcC))  //amount credit
							: ($pPcC>0)
								aTmpReal2{$w}:=Num:C11(Substring:C12($theText; $pPcC+1))
							Else 
								aTmpReal2{$w}:=0
						End case 
					End if 
					If ($pCR=0)
						$endLoop:=True:C214
					Else 
						$theText:=Substring:C12($theText; $pCR+1)
					End if 
				Until ($endLoop)
			Else 
				ARRAY TEXT:C222(aTmpText1; 1)
				ARRAY REAL:C219(aTmpReal1; 1)
				ARRAY REAL:C219(aTmpReal2; 1)
				aTmpText1{1}:=[Rep:8]repID:1
				aTmpReal1{1}:=[Rep:8]comRate:13
				aTmpReal2{1}:=100
			End if 
		End if 
		$cntRep:=Size of array:C274(aTmpText1)
		For ($incRep; 1; $cntRep)
			$w:=Size of array:C274(aText1)+1
			INSERT IN ARRAY:C227(aText1; $w; 1)
			INSERT IN ARRAY:C227(aText2; $w; 1)
			INSERT IN ARRAY:C227(aText3; $w; 1)
			INSERT IN ARRAY:C227(aText4; $w; 1)
			INSERT IN ARRAY:C227(aText5; $w; 1)
			INSERT IN ARRAY:C227(aText6; $w; 1)
			INSERT IN ARRAY:C227(aText7; $w; 1)
			INSERT IN ARRAY:C227(aText8; $w; 1)
			INSERT IN ARRAY:C227(aText9; $w; 1)  //sales credit
			INSERT IN ARRAY:C227(aText10; $w; 1)  //Amount
			INSERT IN ARRAY:C227(aText11; $w; 1)  //Commission
			INSERT IN ARRAY:C227(aText12; $w; 1)  //%
			aText1{$w}:=aTmpText1{$incRep}
			aText2{$w}:=$2->
			aText9{$w}:=String:C10(Round:C94($1->*0.01*aTmpReal2{$incRep}; <>tcDecimalTt); <>tcFormatTt)  //amount credit
			aText10{$w}:=String:C10($1->; <>tcFormatTt)  //amount
			aText11{$w}:=String:C10(Round:C94($1->*aTmpReal1{$incRep}*0.01; <>tcDecimalTt); <>tcFormatTt)  //commission
			aText12{$w}:=String:C10(aTmpReal1{$incRep}; "###0.00")  //per cent commission
			aText3{$w}:=String:C10($3->)
			If ($cntParam>3)
				aText4{$w}:=PackMakeText($4)
				If ($cntParam>4)
					aText5{$w}:=PackMakeText($5)
					If ($cntParam>5)
						aText6{$w}:=PackMakeText($6)
						If ($cntParam>6)
							aText7{$w}:=PackMakeText($7)
							If ($cntParam>7)
								aText8{$w}:=PackMakeText($8)
							End if 
						End if 
					End if 
				End if 
			End if 
		End for 
		NEXT RECORD:C51(Table:C252(Table:C252($1))->)
	End for 
End if 