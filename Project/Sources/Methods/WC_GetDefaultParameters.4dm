//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 10/16/17, 11:06:25
// ----------------------------------------------------
// Method: WC_GetDefaultParameters
// Description
// 
//
// Parameters
// ----------------------------------------------------

// HERE ARE ARE GOING TO SET THE TYPICAL VARIABLES THAT WE USE EVERY REQUEST.
// ### bj ### 20200329_2347 easier to read
C_TEXT:C284(returnRecordNum; returnUniqueID; returnTableName; returnTable; returnField; returnValue)
C_TEXT:C284(returnPage; returnString; returnMinDate; returnMaxDate)  // #### AZM #### 20171026_1259 ADD RETURN VALUES FOR DATE RANGES TO RETURN TO LISTS CORRECTLY
C_TEXT:C284(returnUUIDKey)
// RETURN VARIABLES, USED FOR BREADCRUMBS AND TO HELP DETERMINE WHERE TO RETURN TO

returnTable:=WCapi_GetParameter("returnTable"; "")

returnField:=WCapi_GetParameter("returnField"; "")
If (returnField="")
	returnField:=WCapi_GetParameter("returnKeyField"; "")
End if 

returnValue:=WCapi_GetParameter("returnValue"; "")
If (returnValue="")
	returnValue:=WCapi_GetParameter("returnID"; "")
End if 
// ### bj ### 20200329_2349
// start using this everywhere
returnUUIDKey:=WCapi_GetParameter("returnUUIDKey"; "")
// ### bj ### 20200105_1423
// not sure these are needed.
C_TEXT:C284(returntaskID)
returntaskID:=WCapi_GetParameter("returntaskID"; "")
// needed for ajax calls from within pages
// not sure need everywhere keep testing
//C_TEXT(cbtaskID;cbUUIDDkey;cbTable;cbThumbnail)
//cbtaskID:=WCapi_GetParameter ("cbtaskID";"")
//cbUUIDDkey:=WCapi_GetParameter ("cbUUIDkey";"")
//cbTable:=WCapi_GetParameter ("cbTable";"")
//  cbThumbnail:=WCapi_GetParameter ("cbThumbnail";"")

returnPage:=WCapi_GetParameter("returnPage"; "")

returnRecordNum:=WCapi_GetParameter("returnRecordNum"; "")
returnUniqueID:=WCapi_GetParameter("returnUniqueID")  // #### AZM #### 20180309_088 ADD THIS TO REPLACE RETURN RECORD NUM
returnTableName:=WCapi_GetParameter("returnTableName"; "")
returnMinDate:=WCapi_GetParameter("returnMinDate"; "")  // #### AZM #### 20171026_1259 ADD RETURN VALUES FOR DATE RANGES TO RETURN TO LISTS CORRECTLY
returnMaxDate:=WCapi_GetParameter("returnMaxDate"; "")  // #### AZM #### 20171026_1259 ADD RETURN VALUES FOR DATE RANGES TO RETURN TO LISTS CORRECTLY


// RETURN STRING ALLOWS ACCESS TO THE FULL RETURN QUERY STRING

returnString:=""

If (returnTable#"")
	returnString:=returnString+"&returnTable="+returnTable
End if 

If (returnField#"")
	returnString:=returnString+"&returnField="+returnField
End if 

If (returnValue#"")
	returnString:=returnString+"&returnValue="+returnValue
End if 

If (returnPage#"")
	returnString:=returnString+"&returnPage="+returnPage
End if 

If (returnTableName#"")
	returnString:=returnString+"&returnTableName="+returnTableName
End if 

If (returnRecordNum#"")
	returnString:=returnString+"&returnRecordNum="+returnRecordNum
End if 

If (returnUniqueID#"")  // #### AZM #### 20180309_088 ADD THIS TO REPLACE RETURN RECORD NUM
	returnString:=returnString+"&returnUniqueID="+returnUniqueID
End if 

If (returnMinDate#"")
	returnString:=returnString+"&returnMinDate="+returnMinDate
End if 

If (returnMaxDate#"")
	returnString:=returnString+"&returnMaxDate="+returnMaxDate
End if 

// PAGE ONE, LIST, AND ERROR. THESE EVENTUALLY WILL BE DEFINING. RIGHT NOW
// THEY GET OVERRIDDEN FURTHER ON.

C_TEXT:C284(jitPageOne; jitPageList; jitPageError)

jitPageOne:=WCapi_GetParameter("jitPageOne"; "")

jitPageList:=WCapi_GetParameter("jitPageList"; "")

jitPageError:=WCapi_GetParameter("jitPageError"; "")