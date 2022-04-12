//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/03/09, 00:47:22
// ----------------------------------------------------
// Method: jpwNewUser
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($obCurrentUser; $obSel; $obRec)

$obRec:=ds:C1482.Employee.query("nameID = :1"; Current user:C182).first()
If ($obRec=Null:C1517)
	ALERT:C41("There is not an Employee Record with nameID: "+Current user:C182)
Else 
	Default_Employee
End if 
If (vHere>1)
	// ### bj ### 20210801_1447
	// QQQZZZQQQ fix with ListBox Change
	//Belongs in its own procedure
	Case of 
		: (ptCurTable=(->[Order:3]))
			changeOrd:=(UserInPassWordGroup("EditOrder"))
		: (ptCurTable=(->[Invoice:26]))
			changeInv:=(UserInPassWordGroup("EditInvoice"))
			If (([Invoice:26]dateLinked:31=!00-00-00!) & ([Invoice:26]jrnlComplete:48=False:C215) & (changeInv=True:C214))
				OBJECT SET ENTERABLE:C238([Invoice:26]shipAdjustments:17; True:C214)
				OBJECT SET ENTERABLE:C238([Invoice:26]repCommission:28; True:C214)
				OBJECT SET ENTERABLE:C238([Invoice:26]salesCommission:36; True:C214)
				OBJECT SET ENTERABLE:C238([Invoice:26]attention:38; True:C214)
				OBJECT SET ENTERABLE:C238([Invoice:26]company:7; True:C214)
				OBJECT SET ENTERABLE:C238([Invoice:26]address1:8; True:C214)
				OBJECT SET ENTERABLE:C238([Invoice:26]address2:9; True:C214)
				OBJECT SET ENTERABLE:C238([Invoice:26]city:10; True:C214)
				OBJECT SET ENTERABLE:C238([Invoice:26]state:11; True:C214)
				OBJECT SET ENTERABLE:C238([Invoice:26]zip:12; True:C214)
				OBJECT SET ENTERABLE:C238([Invoice:26]country:13; True:C214)
				OBJECT SET ENTERABLE:C238([Invoice:26]shipFreightCost:15; True:C214)
				OBJECT SET ENTERABLE:C238([Invoice:26]shipMiscCosts:16; True:C214)
				If (changeInvLines)
					OBJECT SET ENTERABLE:C238(pPartNum; True:C214)
					OBJECT SET ENTERABLE:C238(pQtyShip; True:C214)
					OBJECT SET ENTERABLE:C238(pPricePt; True:C214)
					OBJECT SET ENTERABLE:C238(pUnitPrice; True:C214)
					OBJECT SET ENTERABLE:C238(pDiscnt; True:C214)
					ItemSetButtons((Size of array:C274(aiLineAction)>0); Not:C34([Invoice:26]jrnlComplete:48))
				End if 
			End if 
			
			
			
			
			
		: (ptCurTable=(->[PO:39]))
			changePo:=(UserInPassWordGroup("EditPO"))
	End case 
End if 

// setup Cronjobs for a change in user
CronJobStartup
