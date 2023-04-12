If (False:C215)
	//Method: Html_ImagesByXWide
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 

C_LONGINT:C283($err; $i; $k; $1; $doHtml)
C_TEXT:C284($fileFold; $theSite)
TRACE:C157
If (iLoText1="")
	ALERT:C41("Load Docs for a draft html page.")
Else 
	$shortname:=Replace string:C233(HFS_ShortName(iLoText1); Folder separator:K24:12; "")+".html"
	myDoc:=EI_UniqueDoc(Storage:C1525.wc.webFolder+$shortname)
	C_LONGINT:C283($recID)
	$doThumbs:=False:C215
	If (OK=1)
		$thePath:=Replace string:C233(iLoText1; Folder separator:K24:12; "/")
		$pJITWeb:=Position:C15("jitWeb"; iLoText1)
		If ($pJITWeb>0)
			$thePath:=Substring:C12($thePath; $pJITWeb+6)
			$thumbPath:=$thePath+"TN/"
			$hiResPath:=$thePath+"HiRes/"
		End if 
		C_TEXT:C284($pageBuild)
		$pageBuild:=HTMLPageHeadMake("StandardTemplate.txt")
		$pageBuild:=$pageBuild+"\r"+"<TABLE class"+Txt_Quoted("docList")+">"+"\r"
		$k:=Size of array:C274(aHtPage)
		For ($i; 1; $k)
			$diskPath:=iLoText1+aHtPage{$i}
			$doImage:=False:C215
			$pageBuild:=$pageBuild+"<TR><TD class="+Txt_Quoted("GOTO")+"><a HREF="+Txt_Quoted($thePath+aHtPage{$i})+" target="+Txt_Quoted("_blank")+">GoTo</a>"
			$recID:=Num:C11(aHtvLink{$i})
			If ($recID>9)
				QUERY:C277([Document:100]; [Document:100]idNum:1=$recID)
			End if 
			$pageBuild:=$pageBuild+"\r"+"<BR><a href="+Txt_Quoted($hiResPath+aHtPage{$i})+" target="+Txt_Quoted("_hiRes")+">Hi Res</a>"  //</TD>"+"\r"    
			$pageBuild:=$pageBuild+"</TD>"+"\r"
			If (Position:C15(".jpg"; aHtPage{$i})>1)
				$doImage:=True:C214
			Else 
				If (Position:C15(".gif"; aHtPage{$i})>1)
					$doImage:=True:C214
				End if 
			End if 
			If ($doImage)
				$pageBuild:=$pageBuild+"<td><img src="+Txt_Quoted($thumbPath+aHtPage{$i})+"></td>"+"\r"
			Else 
				$pageBuild:=$pageBuild+"<td>Not image type</td>"+"\r"
			End if 
			$pageBuild:=$pageBuild+"<TD class="+Txt_Quoted("Explanation")+">Title:  "+aHtBkGraf{$i}+"\r"+"<BR>Event:  "+aHtBody{$i}+"\r"+"<BR>Description:  "+aHtBkColor{$i}+"</TD>"+"\r"+"</TR>"+"\r"
		End for 
		$pageBuild:=$pageBuild+"\r"+"</HTML>"
		SEND PACKET:C103(myDoc; $pageBuild)
		CLOSE DOCUMENT:C267(myDoc)
		App_SetSuffix("html")
		//SET TEXT TO CLIPBOARD($pageBuild)
		
		vText2:=""
		vText1:=document
		AE_LaunchDoc(vText1)
		
	End if 
End if 
