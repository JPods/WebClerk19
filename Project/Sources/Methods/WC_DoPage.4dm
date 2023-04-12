//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Method: WC_DoPage 
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 

// Modified by: Bill James (2017-09-11T00:00:00)
// Changed to support folder depth to pages

C_TEXT:C284($pathText; $pathDepth)
ARRAY TEXT:C222($atextPath; 0)
C_LONGINT:C283($incRay; $cntRay)
$pathDepth:=""
// revisit some time

C_TEXT:C284($0; $1; $pageDo; $2; $Page2; $page1)
// ### bj ### 20181228_0003  so we can redirect based on scripts and process variable


//$0:=Storage.wc.webFolder+"Error.html"
$0:=Storage:C1525.wc.webFolder+"Error.html"  // # AZM #### // 20171212_0905 - NEED TO SHOW ERROR FROM CORRECT FOLDER
$cntParameters:=Count parameters:C259
If ($cntParameters>0)
	$Page2:=""
	$Page1:=""
	If ($1="")
		$page1:="Error.html"
	Else 
		If ($1[[1]]="/")
			$1:=Substring:C12($1; 2)
		End if 
		$Page1:=Replace string:C233($1; "/"; Folder separator:K24:12)
	End if 
	If ($cntParameters>1)
		If ($2#"")
			If ($2[[1]]="/")
				$2:=Substring:C12($2; 2)
			End if 
			$Page2:=Replace string:C233($2; "/"; Folder separator:K24:12)
		End if 
	End if 
	//
	If ($Page2#"")
		If (Position:C15("."; $Page2)=0)  //page without the extension
			$Page2:=$Page2+".html"
		End if 
		//$0:=Storage.wc.webFolder+$Page2  //  Storage.wc.webFolder+$pathDepth+$Page2 $pageDepth to subfolders should be listed on the page
		$0:=Storage:C1525.wc.webFolder+$Page2  // # AZM #### // 20190409 - NEED TO SHOW ERROR FROM CORRECT FOLDER
	Else 
		If ($Page1="")
			vResponse:="Page request empty: "+Substring:C12(vText11; 1; 30)
			$Page1:="Error.html"
		Else 
			If (Position:C15("."; $Page1)=0)  //page without the extension
				$Page1:=$Page1+".html"
			End if 
		End if 
		
		$0:=Storage:C1525.wc.webFolder+$Page1  // # AZM #### // 20171212_0905 - NEED TO SHOW ERROR FROM CORRECT FOLDER
	End if 
Else 
	vResponse:=vResponse+": Missing page parameters."
End if 

