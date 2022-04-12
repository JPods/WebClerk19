//%attributes = {"publishedWeb":true}
// Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)


// 
// If (False)
// If (False)
//   //Method: Wcc_ImageServer 
//   //Date: 07/01/02
//   //Who: Bill
//   //Description: List of structure
// End if 
// 
// End if 
// C_LONGINT($w;$h;$t;$1;vItemCount)
// C_TEXT($cat;$ser;$val)
// C_LONGINT(vBeenHere;vlBeenHere)
// C_POINTER($2)
// C_TEXT($keyWord)
// C_DATE($dateBeg;$dateEnd)
// 
// $doPage:="Error.html"
// $theEvent:=WCapi_GetParameter("Event";"")
// $keyWord:=WCapi_GetParameter("keyWord";"")
//   //$theDate:=WCapi_GetParameter("imageDate";"")
// TRACE
// $testCnt:=0
// C_LONGINT($testCnt)
// 
// QUERY([DocPath];[DocPath]Publish>0;*)
// If ($theEvent#"")
// QUERY([DocPath]; & [DocPath]Event=$theEvent+"@";*)
// End if 
// If ($keyWord#"")
// C_LONGINT($p;$cycleCnt)
// C_TEXT($testWord)
// $cycleCnt:=$testCnt
// $keyWord:=Replace string($keyWord;", ";"; ")
// Repeat 
// $p:=Position("; ";$keyWord)
// If ($p>0)
// $testWord:=Substring($keyWord;1;$p-1)
// $keyWord:=Substring($keyWord;$p+2)
// Else 
// $testWord:=$keyWord
// End if 
// If ($testWord#"")
// QUERY([DocPath]; & =$testWord+"@";*)
// End if 
// Until ($p=0)
// QUERY([DocPath]; & [DocPath]Publish<=viEndUserSecurityLevel-<>vlSecurityBump)
// End if 
// $num:=Records in selection([DocPath])
// vResponse:="No Images available at this authority level"
// Case of 
// : ($num>1)
// $jitPageList:=WCapi_GetParameter("jitPageList";"")
// If ($jitPageList#"")
// $doPage:=$jitPageList
// Else 
// $doPage:="WccImagePathsList.html"
// End if 
// : ($num=1)
// $jitPageOne:=WCapi_GetParameter("jitPageOne";"")
// If ($jitPageOne#"")
// $doPage:=$jitPageOne
// Else 
// $doPage:="WccImagePathsOne.html"
// End if 
// End case 
// $err:=WC_PageSendWithTags ($1;WC_DoPage ($doPage;"");0)