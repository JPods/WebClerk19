//%attributes = {"publishedWeb":true}

C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
$c:=$1
$suffix:=""
$doThis:=0
vResponse:=""

Case of 
	: (voState.url="/item_Query@")
		voState.url:="item_List"
	: (voState.url="/item_Na@")
		voState.url:="item_List"
End case 

//TRACE
vRelateLevel:=1
Case of 
	: (voState.url="/item_List@")  //list the found items
		Http_ItemsNar($c; $2)  //  Http_ListItems ($c;$2)
		// : (voState.url="/item_Special@")  //list the found items
		// Http_ItemSpecials ($c;$2)
	: (voState.url="/item_Library@")  //list the found items
		Http_ItemLibrary($c; $2)
	: (voState.url="/item_Create_nc@")  //list the found items
		http_ItemCreateNC($c; $2)
	: (voState.url="/item_Bubble@")  //list the found items
		HTTP_ItemKeyword($c; $2)
	: (voState.url="/item_Copy@")  //list the found items
		http_ItemCopy($c; $2)
	: (voState.url="/Item_Menu@")  //Create branching menus
		MenuCall($c; $2)
	: (voState.url="/Item_Configure@")  //new Lead
		MenuCall($c; $2)
	: (voState.url="/Item_Warranty@")  //SerialNumber issue Warrenty
		WarrantyIssue($c; $2)
End case 
READ WRITE:C146([Item:4])
READ WRITE:C146([ItemSpec:31])
READ WRITE:C146([ItemXRef:22])
vItemRelated:=""
pvOrderNum:=""
pvDrawingID:=""
pvBubbleID:=""

