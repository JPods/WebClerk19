//%attributes = {"publishedWeb":true}
//C_LONGINT($1; $c; $doThis; <>vbSaleLevel)
//C_TEXT(vResponse)
//C_POINTER($2)
//$c:=$1
//$suffix:=""
//$doThis:=0
//vResponse:="No records submitted"
////zttp_UserGet 
//$jitpageone:=WCapi_GetParameter("jitpageone"; "")
//$doc2Print:=WCapi_GetParameter("Doc2Print"; "")
////
////TRACE
//C_LONGINT($p; $pEqual; $pEnd; $pCR; $pEndSeg)
//$p:=Position("_jit_3_2jj"; $2->)  //do the lines

//$doPage:=WC_DoPage("OrdersSplitList.html"; $jitPageOne)

//CREATE EMPTY SET([Order]; "Current")

//$sizeOfList:=Size of array(aParameterName)
//C_LONGINT($p; $pEqual; $pEnd; $pCR; $pEndSeg; $countElements; $foundNext; $foundLine)
//$endLoop:=False
//$workingElement:=1
//Repeat 
//$foundLine:=Find in array(aParameterName; "_jit_3_2jj"; $workingElement)
//If ($foundLine<1)
//$endLoop:=True
//Else 
//$workingElement:=$foundLine+1
//$typeSaleLine:=""
//$foundNext:=Find in array(aParameterName; "_jit_3_2jj"; $workingElement)
//If ($foundNext=-1)
//$foundNext:=$sizeOfList
//$endLoop:=True
//End if 
//$theOrderNum:=Num(aParameterValue{$foundLine})
//If ($theOrderNum>0)
//QUERY([Order]; [Order]idNum=$theOrderNum)
//$countElements:=$foundNext-$foundLine-1
//For ($incRay; 1; $countElements)
//$fieldToChange:=aParameterName{$foundLine+$incRay}
//If ($fieldToChange="_jit_@")
//$fieldValue:=aParameterValue{$foundLine+$incRay}
//If (Length($fieldToChange)>=10)
//$fieldNum:=Num(Substring($fieldToChange; 8; 10))
//If (($fieldToChange[[6]]="3") & ($fieldNum>0) & ($fieldNum<=Get last field number(->[Order])))
//QUERY([FC]; [FC]securityLevel=vWccSecurity; *)
//QUERY([FC];  & [FC]tableNum=3)
//QUERY([FC];  & [FC]fieldNumber=$fieldNum)
//If (Records in selection([FC])>0)
//UtFillifNotEmpty(Field(3; $fieldNum); $fieldValue; 1)
//End if 
//End if 
//End if 
//End if 
//End for 

//If (False)
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_3jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//[Order]customerPO:=aParameterValue{$nextValueElement}
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_53jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$needDateStr:=aParameterValue{$nextValueElement}
//[Order]dateCancel:=Date_GoFigure($needDateStr)
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_5jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$needDateStr:=aParameterValue{$nextValueElement}
//[Order]dateNeeded:=Date_GoFigure($needDateStr)
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_23jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//[Order]terms:=aParameterValue{$nextValueElement}
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_61jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//[Order]profile1:=aParameterValue{$nextValueElement}
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_62jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//[Order]profile2:=aParameterValue{$nextValueElement}
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_63jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//[Order]profile3:=aParameterValue{$nextValueElement}
//End if 
//If (False)
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_80jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//[Order]alertMessage:=aParameterValue{$nextValueElement}
//End if 
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_3_46jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//[Order]shipInstruct:=aParameterValue{$nextValueElement}
//End if 
//End if 


//If ([Order]idNum>0)
//SAVE RECORD([Order])
//ADD TO SET([Order]; "Current")
//Else 
//[EventLog]areYouHuman:="zeroOrder"
//EventLogsMessage("Trying to save a zero Order Http_MfgPONeed.")
//End if 
//End if 
//End if 
//Until ($endLoop)


//USE SET("Current")
//CLEAR SET("Current")
////
//vResponse:="Changes posted"
//If ($doc2Print#"")
//QUERY([Report]; [Report]name=$doc2Print)
//If (Records in selection([Report])#1)
//vResponse:="To print, there must be one and only one UserReport: "+$doc2Print
//Else 
//vResponse:="Changes posted; documents printing"
//CREATE SET([Order]; "P_Current")
//Prnt_ReportOpts
//USE SET("P_Current")
//CLEAR SET("P_Current")
//End if 
//End if 
//$err:=WC_PageSendWithTags($1; $doPage; 0)
//vInAsCustomer:=""
//vResponse:=""
//vcustomerID:=""