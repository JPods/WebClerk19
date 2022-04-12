//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
$c:=$1
$suffix:=""
$doThis:=0
vResponse:="No records submitted"
//zttp_UserGet 
$jitpageone:=WCapi_GetParameter("jitpageone"; "")
$doc2Print:=WCapi_GetParameter("Doc2Print"; "")
//
//TRACE
C_LONGINT:C283($p; $pEqual; $pEnd; $pCR; $pEndSeg)
$p:=Position:C15("_jit_3_2jj"; $2->)  //do the lines

$doPage:=WC_DoPage("OrdersSplitList.html"; $jitPageOne)

CREATE EMPTY SET:C140([Order:3]; "Current")

$sizeOfList:=Size of array:C274(aParameterName)
C_LONGINT:C283($p; $pEqual; $pEnd; $pCR; $pEndSeg; $countElements; $foundNext; $foundLine)
$endLoop:=False:C215
$workingElement:=1
Repeat 
	$foundLine:=Find in array:C230(aParameterName; "_jit_3_2jj"; $workingElement)
	If ($foundLine<1)
		$endLoop:=True:C214
	Else 
		$workingElement:=$foundLine+1
		$typeSaleLine:=""
		$foundNext:=Find in array:C230(aParameterName; "_jit_3_2jj"; $workingElement)
		If ($foundNext=-1)
			$foundNext:=$sizeOfList
			$endLoop:=True:C214
		End if 
		$theOrderNum:=Num:C11(aParameterValue{$foundLine})
		If ($theOrderNum>0)
			QUERY:C277([Order:3]; [Order:3]orderNum:2=$theOrderNum)
			$countElements:=$foundNext-$foundLine-1
			For ($incRay; 1; $countElements)
				$fieldToChange:=aParameterName{$foundLine+$incRay}
				If ($fieldToChange="_jit_@")
					$fieldValue:=aParameterValue{$foundLine+$incRay}
					If (Length:C16($fieldToChange)>=10)
						$fieldNum:=Num:C11(Substring:C12($fieldToChange; 8; 10))
						If (($fieldToChange[[6]]="3") & ($fieldNum>0) & ($fieldNum<=Get last field number:C255(->[Order:3])))
							QUERY:C277([FieldCharacteristic:94]; [FieldCharacteristic:94]securityLevel:3=vWccSecurity; *)
							QUERY:C277([FieldCharacteristic:94];  & [FieldCharacteristic:94]tableNum:1=3)
							QUERY:C277([FieldCharacteristic:94];  & [FieldCharacteristic:94]fieldNumber:5=$fieldNum)
							If (Records in selection:C76([FieldCharacteristic:94])>0)
								UtFillifNotEmpty(Field:C253(3; $fieldNum); $fieldValue; 1)
							End if 
						End if 
					End if 
				End if 
			End for 
			
			If (False:C215)
				$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_3jj"; $foundLine; $foundNext)
				If ($nextValueElement>0)
					[Order:3]customerPO:3:=aParameterValue{$nextValueElement}
				End if 
				$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_53jj"; $foundLine; $foundNext)
				If ($nextValueElement>0)
					$needDateStr:=aParameterValue{$nextValueElement}
					[Order:3]dateCancel:53:=Date_GoFigure($needDateStr)
				End if 
				$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_5jj"; $foundLine; $foundNext)
				If ($nextValueElement>0)
					$needDateStr:=aParameterValue{$nextValueElement}
					[Order:3]dateNeeded:5:=Date_GoFigure($needDateStr)
				End if 
				$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_23jj"; $foundLine; $foundNext)
				If ($nextValueElement>0)
					[Order:3]terms:23:=aParameterValue{$nextValueElement}
				End if 
				$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_61jj"; $foundLine; $foundNext)
				If ($nextValueElement>0)
					[Order:3]profile1:61:=aParameterValue{$nextValueElement}
				End if 
				$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_62jj"; $foundLine; $foundNext)
				If ($nextValueElement>0)
					[Order:3]profile2:62:=aParameterValue{$nextValueElement}
				End if 
				$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_63jj"; $foundLine; $foundNext)
				If ($nextValueElement>0)
					[Order:3]profile3:63:=aParameterValue{$nextValueElement}
				End if 
				If (False:C215)
					$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_80jj"; $foundLine; $foundNext)
					If ($nextValueElement>0)
						[Order:3]alertMessage:80:=aParameterValue{$nextValueElement}
					End if 
				End if 
				$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_46jj"; $foundLine; $foundNext)
				If ($nextValueElement>0)
					[Order:3]shipInstruct:46:=aParameterValue{$nextValueElement}
				End if 
			End if 
			
			
			If ([Order:3]orderNum:2>0)
				SAVE RECORD:C53([Order:3])
				ADD TO SET:C119([Order:3]; "Current")
			Else 
				[EventLog:75]areYouHuman:36:="zeroOrder"
				EventLogsMessage("Trying to save a zero Order Http_MfgPONeed.")
			End if 
		End if 
	End if 
Until ($endLoop)


USE SET:C118("Current")
CLEAR SET:C117("Current")
//
vResponse:="Changes posted"
If ($doc2Print#"")
	QUERY:C277([UserReport:46]; [UserReport:46]name:2=$doc2Print)
	If (Records in selection:C76([UserReport:46])#1)
		vResponse:="To print, there must be one and only one UserReport: "+$doc2Print
	Else 
		vResponse:="Changes posted; documents printing"
		CREATE SET:C116([Order:3]; "P_Current")
		Prnt_ReportOpts
		USE SET:C118("P_Current")
		CLEAR SET:C117("P_Current")
	End if 
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)
vInAsCustomer:=""
vResponse:=""
vcustomerID:=""