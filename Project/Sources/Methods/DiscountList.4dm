//%attributes = {"publishedWeb":true}
QUERY:C277([SpecialDiscount:44]; [SpecialDiscount:44]DateEnd:3>=Current date:C33)
SELECTION TO ARRAY:C260([SpecialDiscount:44]TypeSale:1; aDiscType; [SpecialDiscount:44]PriceBase:8; aPriceLevel; [SpecialDiscount:44]DateBegin:2; aDateBegins; [SpecialDiscount:44]DateEnd:3; aDateEnds; [SpecialDiscount:44]PerCentDiscount:6; aPerCents; [SpecialDiscount:44]Note:7; aNotes)
viRecordsInSelection:=Size of array:C274(aDiscType)
UNLOAD RECORD:C212([SpecialDiscount:44])
jCenterWindow(462; 220; 1)
DIALOG:C40([SpecialDiscount:44]; "diaListDscnts")
CLOSE WINDOW:C154
initSpclDisRay(0)