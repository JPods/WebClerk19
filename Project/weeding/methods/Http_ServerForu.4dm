//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
$c:=$1
$suffix:=""
$doThis:=0
vResponse:=""
//zttp_UserGet 
TRACE:C157
Case of 
	: (voState.url="/Forum_List@")
		//   Http_SrchForum ($c;->vText11)
		// Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)
		// use standard query tools
		//
	: ((voState.url="/Forum_Reply@") | (voState.url="/Forum_Add@"))
		Http_ForumReply($c; ->vText11)
		//
	: (voState.url="/Forum_New@")  //Forum
		Http_ForumNew($c; ->vText11)
End case 