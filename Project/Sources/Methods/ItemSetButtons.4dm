//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/14/15, 13:03:56
// ----------------------------------------------------
// Method: ItemSetButtons
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150106_1333 disable  buttons if NOT changeInvLines

C_BOOLEAN:C305($1; $2; $changeInv; $lineToWork)
//$lineToWork:=$1
//$changeInv$2
If ($1)  //                                  are there array elements
	OBJECT SET ENABLED:C1123(vDetails; True:C214)
	OBJECT SET ENABLED:C1123(bItemSpec; True:C214)
	OBJECT SET ENABLED:C1123(bItemXRef; True:C214)
	OBJECT SET ENABLED:C1123(bItemShow; True:C214)
Else 
	OBJECT SET ENABLED:C1123(vDetails; False:C215)
	OBJECT SET ENABLED:C1123(bItemSpec; False:C215)
	OBJECT SET ENABLED:C1123(bItemXRef; False:C215)
	OBJECT SET ENABLED:C1123(bItemShow; False:C215)
	OBJECT SET ENABLED:C1123(bSubDel; False:C215)
End if 
If ($2)  //   
	C_BOOLEAN:C305(changeInvLines)
	If ((changeInvLines) | (ptcurTable#(->[Invoice:26])))  //  allow line changes
		OBJECT SET ENABLED:C1123(bSubAdd; True:C214)
		If ($1)  //                                   else is taken care of above
			OBJECT SET ENABLED:C1123(bSubDel; True:C214)
		End if 
		ItemSetFields(True:C214)
		// ### jwm ### 20150106_1333_begin
	Else 
		OBJECT SET ENABLED:C1123(bSubDel; False:C215)
		OBJECT SET ENABLED:C1123(bSubAdd; False:C215)
		ItemSetFields(False:C215)
		// ### jwm ### 20150106_1333_end
	End if 
Else   //                                         no changes by setting $2 to false
	OBJECT SET ENABLED:C1123(bSubDel; False:C215)
	OBJECT SET ENABLED:C1123(bSubAdd; False:C215)
	ItemSetFields(False:C215)
End if 