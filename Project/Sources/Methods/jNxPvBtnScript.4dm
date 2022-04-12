//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-05-05T00:00:00, 06:27:33
// ----------------------------------------------------
// Method: jNxPvBtnScript
// Description
// Modified: 05/05/17
// 
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($Temp; $1; changeRecord)
C_POINTER:C301($2; $3)
C_TEXT:C284($4)
If (booAccept)
	If ((Modified record:C314(ptCurTable->)) | (vMod))
		$Temp:=myCycle
		myCycle:=6
		jAcceptButton
		myCycle:=$Temp
	Else 
		//use to cancel transaction
	End if 
	Case of 
		: ((ptCurTable=(->[Service:6])) | (ptCurTable=(->[Order:3])))
			If (Modified record:C314([QQQCustomer:2]))
				SAVE RECORD:C53([QQQCustomer:2])
			End if 
		: (ptCurTable=(->[Item:4]))
			If (Modified record:C314([Usage:5]))
				SAVE RECORD:C53([Usage:5])
			End if 
			If (Modified record:C314([BOM:21]))
				SAVE RECORD:C53([BOM:21])
			End if 
			If (Modified record:C314([ItemSpec:31]))
				SAVE RECORD:C53([ItemSpec:31])
			End if 
	End case 
	booPreNext:=True:C214
	booDuringDo:=True:C214
	$endLoop:=False:C215
	Case of 
		: ($1=2)
			$Temp:=$2->
			If (Count parameters:C259>2)
				Repeat 
					$Temp:=$Temp+1
					If ($3->{$Temp}=$4)
						$endLoop:=True:C214
						GOTO RECORD:C242(ptCurTable->; $2->{$Temp})
						changeRecord:=-7
					End if 
				Until (($Temp>=Size of array:C274($2->)) | ($endLoop))
			Else 
				//Repeat 
				$Temp:=$Temp+1
				//If ($2{$Temp}>-1)
				
				//End if 
				// Until ($endLoop)
				GOTO RECORD:C242(ptCurTable->; $2->{$Temp})
				changeRecord:=-7
				jrelateClrFiles
			End if 
			$2->:=$Temp
			jNxPvButtonSet($2)
			booPreNext:=True:C214
		: ($1=-2)
			$Temp:=$2->
			If (Count parameters:C259>2)
				Repeat 
					$Temp:=$Temp-1
					If ($3->{$Temp}=$4)
						$endLoop:=True:C214
						GOTO RECORD:C242(ptCurTable->; $2->{$Temp})
						changeRecord:=-8
						jrelateClrFiles
					End if 
				Until (($Temp<=1) | ($endLoop))
			Else 
				$Temp:=$Temp-1
				GOTO RECORD:C242(ptCurTable->; $2->{$Temp})
				changeRecord:=-8
				jrelateClrFiles
			End if 
			$2->:=$Temp
			jNxPvButtonSet($2)
			booPreNext:=True:C214
		: ($1=1)
			NEXT RECORD:C51(ptCurTable->)
			jNxPvButtonSet  // ### jwm ### 20170606_1121
			changeRecord:=-5
		: ($1=0)  // ### jwm ### 20160414_1213 test case for action built into form
			changeRecord:=-5
		Else   // defaults to else when $1 = -1 could cause errors later
			PREVIOUS RECORD:C110(ptCurTable->)
			jNxPvButtonSet  // ### jwm ### 20170606_1121
			changeRecord:=-6
	End case 
	If (ptCurTable=(->[Item:4]))
		srItemNum:=[Item:4]itemNum:1
	End if 
Else 
	jAlertMessage(9200)
End if 