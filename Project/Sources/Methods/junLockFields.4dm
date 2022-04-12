//%attributes = {"publishedWeb":true}
//(P) junLockFields

$doChange:=(UserInPassWordGroup("UnlockRecord"))
Case of 
	: ($doChange)
		C_LONGINT:C283($k; $i; $theFileNum)
		If ((ptCurTable=(->[Customer:2])) | (ptCurTable=(->[Order:3])) | (ptCurTable=(->[Invoice:26])))
			$k:=Get last field number:C255(->[Customer:2])
			$theFileNum:=Table:C252(->[Customer:2])
			For ($i; 1; $k)
				OBJECT SET ENTERABLE:C238(Field:C253($theFileNum; $i)->; True:C214)
			End for 
			$k:=Get last field number:C255(->[Order:3])
			$theFileNum:=Table:C252(->[Order:3])
			For ($i; 1; $k)
				OBJECT SET ENTERABLE:C238(Field:C253($theFileNum; $i)->; True:C214)
			End for 
			If ((ptCurTable=(->[Invoice:26])) & (<>vbLockInvAtPrint=True:C214))
				READ WRITE:C146([Invoice:26])
				LOAD RECORD:C52([Invoice:26])
			End if 
			$k:=Get last field number:C255(->[Invoice:26])
			$theFileNum:=Table:C252(->[Invoice:26])
			For ($i; 1; $k)
				OBJECT SET ENTERABLE:C238(Field:C253($theFileNum; $i)->; True:C214)
			End for 
		Else 
			$k:=Get last field number:C255(ptCurTable)
			$theFileNum:=Table:C252(ptCurTable)
			For ($i; 1; $k)
				OBJECT SET ENTERABLE:C238(Field:C253($theFileNum; $i)->; True:C214)
			End for 
		End if 
		OBJECT SET ENTERABLE:C238(srItemNum; True:C214)
		OBJECT SET ENTERABLE:C238(srCustomer; True:C214)
		OBJECT SET ENTERABLE:C238(srPhone; True:C214)
		OBJECT SET ENTERABLE:C238(srAcct; True:C214)
		OBJECT SET ENTERABLE:C238(srZip; True:C214)
		Case of 
			: (ptCurTable=(->[Order:3]))
				OBJECT SET ENTERABLE:C238(releaseDate; True:C214)
				OBJECT SET ENTERABLE:C238(releaseTime; True:C214)
				OBJECT SET ENTERABLE:C238(complDate; True:C214)
				OBJECT SET ENTERABLE:C238(complTime; True:C214)
		End case 
		FontSrchLabels(1)
		bNewRec:=0
		OBJECT SET ENABLED:C1123(bNewRec; True:C214)
	: ((error#0) & (ptCurTable=(->[Order:3])) & ([Order:3]complete:83=0))
		FontSrchLabels(1)
		HIGHLIGHT TEXT:C210(srCustomer; 1; 40)
	Else 
		TRACE:C157
		jAlertMessage(9200)
End case 