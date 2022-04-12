C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([ItemXRef:22]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[ItemXRef:22])
	//
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			[ItemXRef:22]ItemNumMaster:1:=[Item:4]itemNum:1
			[ItemXRef:22]DescriptionMaster:8:=[Item:4]description:7
			//[ItemXRef]ItemNumXRef:=[Item]ItemNum
			//[ItemXRef]DescriptionXRef:=[Item]Description
			OBJECT SET ENTERABLE:C238([ItemXRef:22]ItemNumMaster:1; False:C215)
			OBJECT SET ENTERABLE:C238([ItemXRef:22]ItemNumXRef:2; True:C214)
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		If (Record number:C243([Order:3])>-1)
			jDateTimeRecov([Order:3]dtProdRelease:56; ->vDate1; ->vTime2)
		End if 
		
		If (([ItemXRef:22]Currency:16#"") & ([ItemXRef:22]Currency:16#<>tcMONEYCHAR))
			$error:=Exch_GetCurr([ItemXRef:22]Currency:16)  //sets viExConPrec, viExDisPrec  
			viLoR1:=[ItemXRef:22]Cost:7*vrExRate
		Else 
			viLoR1:=0
		End if 
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=(([ItemXRef:22]ItemNumXRef:2#"") & ([ItemXRef:22]ItemNumMaster:1#""))
End if 

