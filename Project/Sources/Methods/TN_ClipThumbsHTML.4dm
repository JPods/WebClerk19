//%attributes = {"publishedWeb":true}
//Method: TN_ClipThumbsHTML
C_LONGINT:C283($err; $i; $k; $1; $doHtml; $modLevel)
C_TEXT:C284($fileFold; $theSite)
ARRAY TEXT:C222(aText1; 0)
vText1:=""
$fileFold:=Get_FolderName("Select folder to List Files.")
If ($fileFold#"")
	$error:=HFS_CatToArray($fileFold; "aText1")
	vText1:=vText1+"List of Files & Folders in "+$fileFold+"\r"+"\r"
	// $cntAcross:=Num(Request("How many across?";4))
	$theTarget:=Request:C163("List target for display"; "Frame_Display")
	If ($theTarget="")
		$theTarget:=""
	Else 
		$theTarget:=" target="+Txt_Quoted($theTarget)
	End if 
	$hiResLink:=""
	$hiResTag:=Request:C163("Add HiRes Tag"; "HiRes")
	$doHiRes:=(OK=1)
	$multiCol:=Num:C11(Request:C163("Multiple columns"; "5"))
	$doCol:=((OK=1) & ($multiCol>0))
	$theSite:=HFS_ShortName($fileFold)
	$theSite:="http://"+Storage:C1525.default.domain+"/"+Substring:C12($theSite; 1; Length:C16($theSite)-1)+"/"
	vText1:=vText1+"<br><table class="+Txt_Quoted("imageListing")+">"+"\r"
	$k:=Size of array:C274(aText1)
	TRACE:C157
	For ($i; $k; 1; -1)
		If (aText1{$i}[[1]]=".")
			DELETE FROM ARRAY:C228(aText1; $i; 1)
		End if 
	End for 
	$k:=Size of array:C274(aText1)
	If ($multiCol>1)
		vText1:=vText1+"<tr>"+"\r"
		For ($i; 1; $k)
			If ($doHiRes)
				$hiResLink:="<br><a href="+Txt_Quoted($theSite+"HiRes/"+aText1{$i})+$theTarget+">"+$hiResTag+"</a>"
			End if 
			$modLevel:=Mod:C98($i; $multiCol)
			vText1:=vText1+"<td><a href="+Txt_Quoted($theSite+aText1{$i})+$theTarget+"><img src="+Char:C90(34)+$theSite+"TN/"+aText1{$i}+Char:C90(34)+"><br>WebPage</a>"+$hiResLink+"<br>"+aText1{$i}+"</td>"+"\r"
			If ($modLevel=0)
				vText1:=vText1+"</tr>"+"\r"
				If ($i<$k)
					vText1:=vText1+"<tr>"+"\r"
				End if 
			End if 
		End for 
		If ($modLevel>0)
			$k:=$multiCol-$modLevel
			For ($i; 1; $k)
				vText1:=vText1+"<td></td>"
			End for 
			vText1:=vText1+"</tr>"+"\r"
		End if 
	Else 
		For ($i; 1; $k)
			vText1:=vText1+"<tr><td><a href="+Txt_Quoted($theSite+aText1{$i})+$theTarget+"><img src="+Char:C90(34)+$theSite+"TN/"+aText1{$i}+Char:C90(34)+"></a></td><td>"+aText1{$i}+"</td></tr>"+"\r"
		End for 
	End if 
	//If ($doHtml=1)
	vText1:=vText1+"</table>"
	//End if 
	SET TEXT TO PASTEBOARD:C523(vText1)
End if 