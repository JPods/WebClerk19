//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-06T00:00:00, 09:33:34
// ----------------------------------------------------
// Method: WC_FieldTagToValue
// Description
// Modified: 12/06/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	//Method: WC_FieldTagToValue
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_TEXT:C284($3)
C_TEXT:C284($2; $0)
C_LONGINT:C283($1)
//TRACE
Case of 
	: ($2="")
		$0:=""
	: ($1=1)  //send out text to web
		Case of 
			: ($3="path")
				$0:=WccDocRef2Web($2)
			: (Position:C15("</"; $2)>0)
				$0:=$2
			: ($3="")
				$0:=$2
			: ($3="text")
				$2:=Replace string:C233($2; Storage:C1525.char.crlf; "\r")
				$2:=Replace string:C233($2; "\n"; "\r")  // ### jwm ### 20151123_1524
				//$0:=Replace string($2;"\r"+"\r";"<P>")  // ### jwm ### 20151124_1353  why the <P>
				$0:=Replace string:C233($2; "\r"; "<br>")
			: ($3="html")
				$0:=NTKString2HTML($2)
				
			: ($3="WC_SiteInsert@")
				$nc_Script:=Substring:C12($strField; 15)
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="WC_SiteInsert"; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=$nc_Script)
				If (Records in selection:C76([TallyMaster:60])=1)
					ExecuteText(0; [TallyMaster:60]script:9)
					//http_NC_GetArticle($nc_URLArticle)
					//$0:=WC_SiteInsert
					// UpdateWithResources by: Bill James (2023-01-03T06:00:00Z)
					
				End if 
			Else 
				$0:=$2
		End case 
	Else   //harvest text from the web
		Case of 
			: ($3="text")  // ### jwm ### 20151124_1053 reversed case text with html
				$0:=NTKString2HTML($2)
			: ($3="html")
				//$0:=Replace string($2;Storage.char.crlf;"\r")
				$2:=Replace string:C233($2; Storage:C1525.char.crlf; "\r")
				$2:=Replace string:C233($2; "\n"; "\r")  // ### jwm ### 20151123_1524
				$0:=$2
			Else 
				$2:=Replace string:C233($2; Storage:C1525.char.crlf; "\r")
				$2:=Replace string:C233($2; "\n"; "\r")  // ### jwm ### 20151123_1524
				$2:=Replace string:C233($2; "<br>"; "\r")
				$0:=$2
				
		End case 
End case 


