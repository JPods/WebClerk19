C_LONGINT:C283($i; $k)
C_LONGINT:C283($sumLong; vStdWrkWk; $tTimeOut)
C_BOOLEAN:C305($notOver)
C_DATE:C307($tDateOut)
C_REAL:C285(vStdHrWk; $Pay; $Wage)
vStdWrkWk:=Round:C94(vStdHrWk*60*60; 0)  //seconds in a work week of vStdHrWk hours
$notOver:=True:C214
CONFIRM:C162("Pay time over "+String:C10(vStdHrWk)+" hrs,"+"\r"+"at "+String:C10(vOTMultiple; "#,##0.00")+" times std rate."+"\r"+"This will total all current lines.")
If (OK=1)
	$sumLong:=0
	For ($i; 1; Size of array:C274(aTCTimeRecs))
		If ($notOver)  //not overtime
			$sumLong:=$sumLong+aTCLapsed{$i}  //add up the hours to the standard work week
			If ($sumLong>vStdWrkWk)  //record which is going overtime
				$notOver:=False:C215  //end testing for over 40 hours  
				$lengthSec:=$sumLong-vStdWrkWk
				$lengthFirst:=aTCLapsed{$i}-$lengthSec
				$tTimeOut:=aTCTimeOut{$i}  // vTimeOut of the second part
				$tDateOut:=aTCDateOut{$i}  // vDateOut of the second part
				//  
				vNameID:=aTCNameID{$i}
				vLapseTime:=$lengthFirst
				vTimeIn:=aTCTimeIn{$i}
				vDateIn:=aTCDateIn{$i}
				TC_TimeLapse(2; ->vTimeIn; ->vTimeOut; ->vLapseTime; ->vDateIn; ->vDateOut)  //Calc the Time/Date Out
				vActivity:=aTCActivity{$i}
				vWONum:=aTCOrdNum{$i}
				$Wage:=aTCHourWage{$i}
				$Pay:=Round:C94($Wage*(vLapseTime/3600); 2)
				
				//need this
				TC_SaveRayRec($i; True:C214; $Wage; $Pay)
				//
				If ($lengthSec>0)
					vLapseTime:=$lengthSec
					vTimeOut:=$tTimeOut
					vDateOut:=$tDateOut
					TC_TimeLapse(3; ->vTimeIn; ->vTimeOut; ->vLapseTime; ->vDateIn; ->vDateOut)  //Calc the Time/Date In
					$Wage:=aTCHourWage{$i}*vOTMultiple
					$Pay:=Round:C94($Wage*(vLapseTime/3600); 2)
					
					//need this
					TC_SaveRayRec(-3; True:C214; $Wage; $Pay)  //adjusting the pay and total of the post change over records
				End if 
			End if 
		Else 
			$Wage:=aTCHourWage{$i}*vOTMultiple
			$Pay:=Round:C94($Wage*(aTCLapsed{$i}/3600); 2)
			
			//need this
			TC_SaveRayRec($i; False:C215; $Wage; $Pay)  //adjusting the pay and total of the post change over records
		End if 
	End for 
	// TC_CalcTotal
	//  --  CHOPPED  AL_UpdateArrays(eTimeList; Size of array(aTCTimeRecs))
	// -- AL_SetSort(eTimeList; 2; 5; 6)
End if 