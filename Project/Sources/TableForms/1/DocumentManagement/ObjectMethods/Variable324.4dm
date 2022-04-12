If (False:C215)
	//Method: Html_ImagesByXWide
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 
C_TEXT:C284($thePath; $thumbPath; $hiResPath)
C_LONGINT:C283($err; $i; $k; $1; $doHtml)
C_TEXT:C284($fileFold; $theSite)
TRACE:C157
If (iLoText1="")
	ALERT:C41("Load Docs for a draft html page.")
Else 
	$doThumbs:=False:C215
	If (Size of array:C274(aRayLines)>30)
		ARRAY LONGINT:C221(aRayLines; 30)
	End if 
	$shortname:="zz"+Replace string:C233(HFS_ShortName(iLoText1); Folder separator:K24:12; "")+".html"
	myDoc:=EI_UniqueDoc(<>WebFolder+$shortname)
	C_LONGINT:C283($recID)
	If (OK=1)
		$shortname:=HFS_ShortName(document)
		$thePath:=Replace string:C233(iLoText1; Folder separator:K24:12; "/")
		$pJITWeb:=Position:C15("jitWeb"; iLoText1)
		If ($pJITWeb>0)
			$thePath:=Substring:C12($thePath; $pJITWeb+6)
			$thumbPath:=$thePath+"TN/"
			$hiResPath:=$thePath+"HiRes/"
		End if 
		C_TEXT:C284($pageBuild)
		$pageBuild:=HTMLPageHeadMake("StandardTemplate.txt")
		$pageBuild:=$pageBuild+"<Center><B>Security Level 2 Required to Save.  "+"Current Level:  _jit_0_viEndUserSecurityLevel_0jj</Center>"+"\r"
		$pageBuild:=$pageBuild+"<FORM action="+Txt_Quoted("/CWS_SaveList")+"method="+Txt_Quoted("Get")+">"+"\r"
		$pageBuild:=$pageBuild+"<Input type="+Txt_Quoted("hidden")+" name="+Txt_Quoted("TableName")+" value="+Txt_Quoted("Document")+">"+"\r"
		$pageBuild:=$pageBuild+"<Center>"+iLoText1+"\r"
		$pageBuild:=$pageBuild+"<Input type="+Txt_Quoted("Submit")+" name="+Txt_Quoted("Submit")+" value="+Txt_Quoted("Submit")+"></CENTER>"+"\r"
		//declare page only if you want to see only the summary of an order
		//$headerText:=$headerText+"<input type="+Txt_Quoted ("hidden")+" NAME
		//="+Txt_Quoted ("jitPageOne")+" VALUE="+Txt_Quoted ("Order.html")+">"+"\r"
		//
		$pageBuild:=$pageBuild+"\r"+"<TABLE class"+Txt_Quoted("docList")+">"+"\r"
		$k:=Size of array:C274(aRayLines)
		For ($i; 1; $k)
			$diskPath:=iLoText1+aHtPage{aRayLines{$i}}
			$doImage:=False:C215
			$pageBuild:=$pageBuild+"<TR>"+"\r"+"<TD class="+Txt_Quoted("GOTO")+" rowspan="+Txt_Quoted("5")+"><a HREF="+Txt_Quoted($thePath+aHtPage{aRayLines{$i}})+" target="+Txt_Quoted("_blank")+">GoTo</a>"
			$recID:=Num:C11(aHtvLink{aRayLines{$i}})
			If ($recID>9)
				QUERY:C277([Document:100]; [Document:100]idNum:1=$recID)
			End if 
			$pageBuild:=$pageBuild+"\r"+"<BR><a href="+Txt_Quoted($hiResPath+aHtPage{aRayLines{$i}})+" target="+Txt_Quoted("_hiRes")+">Hi Res</a>"
			If (aHtvLink{aRayLines{$i}}="")
				$pageBuild:=$pageBuild+"\r"+"<input type="+Txt_Quoted("hidden")+" name="+Txt_Quoted("RecordNum")+" value="+Txt_Quoted("-3")+">"
			Else 
				$pageBuild:=$pageBuild+"\r"+"<input type="+Txt_Quoted("hidden")+" name="+Txt_Quoted("RecordNum")+" value="+Txt_Quoted(String:C10(Record number:C243([Document:100])))+">"
			End if 
			$pageBuild:=$pageBuild+"</TD>"+"\r"
			If (Position:C15(".jpg"; aHtPage{aRayLines{$i}})>1)
				$doImage:=True:C214
			Else 
				If (Position:C15(".gif"; aHtPage{aRayLines{$i}})>1)
					$doImage:=True:C214
				End if 
			End if 
			If ($doImage)
				$pageBuild:=$pageBuild+"<td rowspan="+Txt_Quoted("5")+"><img src="+Txt_Quoted($thePath+aHtPage{aRayLines{$i}})+"height="+Txt_Quoted("100")+"></td>"+"\r"
			Else 
				$pageBuild:=$pageBuild+"<td rowspan="+Txt_Quoted("5")+">Not image type</td>"+"\r"
			End if 
			$pageBuild:=$pageBuild+"<TD class="+Txt_Quoted("Explanation")+">Save Me</td><td><input type="+Txt_Quoted("checkbox")+" name="+Txt_Quoted("SaveMe")+" value="+Txt_Quoted("on")+">&nbsp;&nbsp;"+"<input type="+Txt_Quoted("text")+" name="+Txt_Quoted("rjit_100_2jj")+" value="+Txt_Quoted(aHtPage{aRayLines{$i}})+" READONLY></td></TR>"+"\r"
			$pageBuild:=$pageBuild+"<TR><TD class="+Txt_Quoted("Explanation")+">Title</td><td><input type="+Txt_Quoted("text")+" name="+Txt_Quoted("rjit_100_8jj")+" value="+Txt_Quoted(aHtBkGraf{aRayLines{$i}})+" size="+Txt_Quoted("90")+"></td></TR>"+"\r"
			$pageBuild:=$pageBuild+"<TR><TD class="+Txt_Quoted("Explanation")+">Event</td><td><input type="+Txt_Quoted("text")+" name="+Txt_Quoted("rjit_100_9jj")+" value="+Txt_Quoted(aHtBody{aRayLines{$i}})+" size="+Txt_Quoted("90")+"></td></TR>"+"\r"
			$pageBuild:=$pageBuild+"<TR><TD class="+Txt_Quoted("Explanation")+">Description</td><td><input type="+Txt_Quoted("text")+" name="+Txt_Quoted("rjit_100_3jj")+" value="+Txt_Quoted(aHtBkColor{aRayLines{$i}})+" size="+Txt_Quoted("90")+"></td></TR>"+"\r"
			$pageBuild:=$pageBuild+"<TR><TD class="+Txt_Quoted("Explanation")+">Keywords</td><td><input type="+Txt_Quoted("text")+" name="+Txt_Quoted("rjit_100_11jj")+" value="+Txt_Quoted(aHtLink{aRayLines{$i}})+" size="+Txt_Quoted("90")+"></td></TR>"+"\r"
			
		End for 
		$pageBuild:=$pageBuild+"</TABLE>"+"\r"
		$pageBuild:=$pageBuild+"</HTML>"
		SEND PACKET:C103(myDoc; $pageBuild)
		CLOSE DOCUMENT:C267(myDoc)
		App_SetSuffix("html")
		
		
		//SET TEXT TO CLIPBOARD($pageBuild)
		
		//vText2:=""
		//vText1:=document
		//AE_LaunchDoc (vText1)
		Web_LaunchURL("http://127.0.0.1/"+$shortname)
		//  CHOPPED  AL_GetScroll(eHttpEdit; viVert; viHorz)
		//  --  CHOPPED  AL_UpdateArrays(eHttpEdit; -2)
		// -- AL_SetSelect(eHttpEdit; aRayLines)
		// -- AL_SetScroll(eHttpEdit; viVert; viHorz)
		
	End if 
End if 