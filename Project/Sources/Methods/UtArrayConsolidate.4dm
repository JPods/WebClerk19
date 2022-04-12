//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: UtArrayConsolidate
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_POINTER:C301($1; $3; $5; $7; $9; $11; $13; $15)
C_LONGINT:C283($2; $4; $6; $8; $10; $12; $14; $16)
C_LONGINT:C283($action1; $action3; $action5; $action7; $action9; $action11; $action13; $action15)
C_LONGINT:C283($i; $k; $paraCount; $cntText; $cntInt; $cntLong; $cntTime; $cntReal; $cntStr; $lenStr; $cntDate)
ARRAY POINTER:C280(aRptAccumIn; 0)
ARRAY POINTER:C280(aRptAccumOut; 0)
ARRAY LONGINT:C221($aRptAction; 0)
ARRAY LONGINT:C221(aRptCount; 0)
$paraCount:=Count parameters:C259
If ($paraCount>1)
	For ($i; 1; $paraCount; 2)
		$theType:=Type:C295(${$i}->)
		$w:=Size of array:C274(aRptAccumIn)+1
		INSERT IN ARRAY:C227(aRptAccumIn; $w; 1)
		INSERT IN ARRAY:C227(aRptAccumOut; $w; 1)
		Case of 
			: ($theType=Is alpha field:K8:1) | ($theType=Is text:K8:3)  //2; 0
				$cntText:=$cntText+1
				aRptAccumIn{$w}:=Get pointer:C304("aTmpText"+String:C10($cntText))
				$cntText:=$cntText+1
				aRptAccumOut{$w}:=Get pointer:C304("aTmpText"+String:C10($cntText))
			: ($theType=Is real:K8:4)
				$cntReal:=$cntReal+1
				aRptAccumIn{$w}:=Get pointer:C304("aTmpReal"+String:C10($cntReal))
				$cntReal:=$cntReal+1
				aRptAccumOut{$w}:=Get pointer:C304("aTmpReal"+String:C10($cntReal))
			: ($theType=Is integer:K8:5)
				$cntInt:=$cntInt+1
				aRptAccumIn{$w}:=Get pointer:C304("aTmpInt"+String:C10($cntInt))
				$cntInt:=$cntInt+1
				aRptAccumOut{$w}:=Get pointer:C304("aTmpInt"+String:C10($cntInt))
			: ($theType=Is longint:K8:6)
				$cntLong:=$cntLong+1
				aRptAccumIn{$w}:=Get pointer:C304("aTmpLong"+String:C10($cntLong))
				$cntLong:=$cntLong+1
				aRptAccumOut{$w}:=Get pointer:C304("aTmpLong"+String:C10($cntLong))
			: ($theType=Is date:K8:7)
				$cntDate:=$cntDate+1
				aRptAccumIn{$w}:=Get pointer:C304("aTmpDate"+String:C10($cntDate))
				$cntDate:=$cntDate+1
				aRptAccumOut{$w}:=Get pointer:C304("aTmpDate"+String:C10($cntDate))
			: ($theType=Is time:K8:8)
				$cntTime:=$cntTime+1
				aRptAccumIn{$w}:=Get pointer:C304("aTmpTime"+String:C10($cntTime))
				$cntTime:=$cntTime+1
				aRptAccumOut{$w}:=Get pointer:C304("aTmpTime"+String:C10($cntTime))
		End case 
	End for 
	//  
	
	$k:=$paraCount/2
	ARRAY LONGINT:C221($aRptAction; $k)
	
	
	Case of 
		: ($paraCount=16)
			SELECTION TO ARRAY:C260($1->; aRptAccumIn{1}->; $3->; aRptAccumIn{2}->; $5->; aRptAccumIn{3}->; $7->; aRptAccumIn{4}->; $9->; aRptAccumIn{5}->; $11->; aRptAccumIn{6}->; $13->; aRptAccumIn{7}->; $15->; aRptAccumIn{8}->)
			MULTI SORT ARRAY:C718(aRptAccumIn{1}->; >; aRptAccumIn{2}->; aRptAccumIn{3}->; aRptAccumIn{4}->; aRptAccumIn{5}->; aRptAccumIn{6}->; aRptAccumIn{7}->; aRptAccumIn{8}->)
			$aRptAction{1}:=$2
			$aRptAction{2}:=$4
			$aRptAction{3}:=$6
			$aRptAction{4}:=$8
			$aRptAction{5}:=$10
			$aRptAction{6}:=$12
			$aRptAction{7}:=$14
			$aRptAction{8}:=$16
		: ($paraCount=14)
			SELECTION TO ARRAY:C260($1->; aRptAccumIn{1}->; $3->; aRptAccumIn{2}->; $5->; aRptAccumIn{3}->; $7->; aRptAccumIn{4}->; $9->; aRptAccumIn{5}->; $11->; aRptAccumIn{6}->; $13->; aRptAccumIn{7}->)
			MULTI SORT ARRAY:C718(aRptAccumIn{1}->; >; aRptAccumIn{2}->; aRptAccumIn{3}->; aRptAccumIn{4}->; aRptAccumIn{5}->; aRptAccumIn{6}->; aRptAccumIn{7}->)
			$aRptAction{1}:=$2
			$aRptAction{2}:=$4
			$aRptAction{3}:=$6
			$aRptAction{4}:=$8
			$aRptAction{5}:=$10
			$aRptAction{6}:=$12
			$aRptAction{7}:=$14
		: ($paraCount=12)
			SELECTION TO ARRAY:C260($1->; aRptAccumIn{1}->; $3->; aRptAccumIn{2}->; $5->; aRptAccumIn{3}->; $7->; aRptAccumIn{4}->; $9->; aRptAccumIn{5}->; $11->; aRptAccumIn{6}->)
			MULTI SORT ARRAY:C718(aRptAccumIn{1}->; >; aRptAccumIn{2}->; aRptAccumIn{3}->; aRptAccumIn{4}->; aRptAccumIn{5}->; aRptAccumIn{6}->)
			$aRptAction{1}:=$2
			$aRptAction{2}:=$4
			$aRptAction{3}:=$6
			$aRptAction{4}:=$8
			$aRptAction{5}:=$10
			$aRptAction{6}:=$12
		: ($paraCount=10)
			SELECTION TO ARRAY:C260($1->; aRptAccumIn{1}->; $3->; aRptAccumIn{2}->; $5->; aRptAccumIn{3}->; $7->; aRptAccumIn{4}->; $9->; aRptAccumIn{5}->)
			MULTI SORT ARRAY:C718(aRptAccumIn{1}->; >; aRptAccumIn{2}->; aRptAccumIn{3}->; aRptAccumIn{4}->; aRptAccumIn{5}->)
			$aRptAction{1}:=$2
			$aRptAction{2}:=$4
			$aRptAction{3}:=$6
			$aRptAction{4}:=$8
			$aRptAction{5}:=$10
		: ($paraCount=8)
			SELECTION TO ARRAY:C260($1->; aRptAccumIn{1}->; $3->; aRptAccumIn{2}->; $5->; aRptAccumIn{3}->; $7->; aRptAccumIn{4}->)
			MULTI SORT ARRAY:C718(aRptAccumIn{1}->; >; aRptAccumIn{2}->; aRptAccumIn{3}->; aRptAccumIn{4}->)
			//ALERT(String(Size of array(aRptAccumIn))+"; "+aRptAccumIn{1}->{1})
			//SORT ARRAY(aRptAccumIn{1}->;aRptAccumIn{2}->;aRptAccumIn{3}->;aRptAccumIn{4}->)
			$aRptAction{1}:=$2
			$aRptAction{2}:=$4
			$aRptAction{3}:=$6
			$aRptAction{4}:=$8
		: ($paraCount=6)
			SELECTION TO ARRAY:C260($1->; aRptAccumIn{1}->; $3->; aRptAccumIn{2}->; $5->; aRptAccumIn{3}->)
			MULTI SORT ARRAY:C718(aRptAccumIn{1}->; >; aRptAccumIn{2}->; aRptAccumIn{3}->)
			$aRptAction{1}:=$2
			$aRptAction{2}:=$4
			$aRptAction{3}:=$6
		: ($paraCount=4)
			SELECTION TO ARRAY:C260($1->; aRptAccumIn{1}->; $3->; aRptAccumIn{2}->)
			MULTI SORT ARRAY:C718(aRptAccumIn{1}->; >; aRptAccumIn{2}->)
			$aRptAction{1}:=$2
			$aRptAction{2}:=$4
	End case 
	
	
	$k:=Size of array:C274(aRptAccumIn{1}->)
	$baseText:="lkqj22o123r298fgashdjjlakhfuqw////LIUH~"
	C_LONGINT:C283($cntOut; incOut)
	$cntOut:=Size of array:C274(aRptAccumOut)
	For ($i; 1; $k)
		If (aRptAccumIn{1}->{$i}#$baseText)
			$w:=Size of array:C274(aRptAccumOut{1}->)+1
			INSERT IN ARRAY:C227(aRptCount; $w)
			For ($incOut; 1; $cntOut)
				INSERT IN ARRAY:C227(aRptAccumOut{$incOut}->; $w; 1)
			End for 
			aRptAccumOut{1}->{$w}:=aRptAccumIn{1}->{$i}
			
			
			$baseText:=aRptAccumOut{1}->{$w}
			$doNew:=True:C214
		Else 
			$doNew:=False:C215
		End if 
		For ($incOut; 2; $cntOut)
			Case of 
				: ($aRptAction{$incOut}=2)
					aRptAccumOut{$incOut}->{$w}:=aRptAccumOut{$incOut}->{$w}+aRptAccumIn{$incOut}->{$i}
				: (($aRptAction{$incOut}=1) & ($doNew))
					aRptAccumOut{$incOut}->{$w}:=aRptAccumIn{$incOut}->{$i}
			End case 
		End for 
		aRptCount{$w}:=aRptCount{$w}+1
	End for 
	
	$w:=Size of array:C274(aRptAccumOut)+1
	If ($w>1)
		INSERT IN ARRAY:C227(aRptAccumOut; $w; 1)
		aRptAccumOut{$w}:=(->aRptCount)
	End if 
End if 




