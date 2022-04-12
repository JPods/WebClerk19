If (Record number:C243([Invoice:26])<0)
	If (Size of array:C274(aInvSelRec)>0)
		If (Size of array:C274(aInvRecs)>=aInvSelRec{1})
			GOTO RECORD:C242([Invoice:26]; aInvRecs{aInvSelRec{1}})
		End if 
	End if 
End if 
LOAD RECORD:C52([Invoice:26])
If (Not:C34(Locked:C147([Invoice:26])))
	viRecordPushed:=Record number:C243([Invoice:26])
	PUSH RECORD:C176([Invoice:26])
	vi9:=aInvoices{aInvSelRec{1}}
	jCenterWindow(720; 330; 1)
	DIALOG:C40([Payment:28]; "diaOffSetInvoic")
	CLOSE WINDOW:C154
	IvcCredRayInit(0)
	QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=srAcct; *)
	QUERY:C277([Invoice:26];  & [Invoice:26]balanceDue:44#0)
	//  //  CHOPPED FillInvArrays(Records in selection([Invoice]); 0; 0; eIvc2Pay)
	doSearch:=20
	If (viRecordPushed>-1)
		POP RECORD:C177([Invoice:26])
	End if 
End if 