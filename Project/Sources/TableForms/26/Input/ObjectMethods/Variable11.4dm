C_LONGINT:C283($w)
If (aiLineAction>0)
	//TRACE
	Case of 
		: (([Invoice:26]jrnlComplete:48=False:C215) & (Not:C34(Locked:C147([Invoice:26]))))  //([Invoice]OrderKey=1)&      
			For ($i; Size of array:C274(aRayLines); 1; -1)
				If (aiUniqueID{aRayLines{$i}}>-1)
					$w:=Size of array:C274(aiLinesDelete)+1
					INSERT IN ARRAY:C227(aiLinesDelete; $w; 1)
					aiLinesDelete{$w}:=aiUniqueID{aRayLines{$i}}
				End if 
				If ((<>vbDoSrlNums) & (aiSerialRc{aRayLines{$i}}>0))
					Srl_SalvageSale(aiSerialRc{aRayLines{$i}}; ->[Invoice:26]idNum:2)  //salvage deleted lines    
					doSearch:=888
				End if 
				INSERT IN ARRAY:C227(aiOgLineNum; 1; 1)
				aiOgLineNum{1}:=aiLineNum{aRayLines{$i}}
				IvcLn_RaySize(-1; aRayLines{$i}; 1)
			End for 
			aiLineAction:=Ray_ReturnElem(->aiLineAction)
			//   IvcLnFillVar(aiLineAction)
			vLineMod:=True:C214
			HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
			ItemSetButtons((Size of array:C274(aiLineAction)>0); Not:C34([Invoice:26]jrnlComplete:48))
		: ([Invoice:26]jrnlComplete:48)
			jAlertMessage(10007)
	End case 
End if 