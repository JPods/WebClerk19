//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Html_ImagesByXWide
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 

C_LONGINT:C283($err; $i; $k; $1; $doHtml)
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
		$theTarget:="_blank"
	End if 
	$theSite:=HFS_ShortName($fileFold)
	$theSite:=Storage:C1525.default.domain+"/"+Substring:C12($theSite; 1; Length:C16($theSite)-1)
	vText1:=vText1+"<BR><TABLE>"+"\r"
	$k:=Size of array:C274(aText1)
	For ($i; 1; $k)
		vText1:=vText1+"<TR><TD align="+Txt_Quoted("Center")+"><img src="+Txt_Quoted($theSite+"/"+aText1{$i})+"></TD>"
		$next:=$i+1
		If ($next<=$k)
			$i:=$next
			vText1:=vText1+"<TD align="+Txt_Quoted("Center")+"><img src="+Txt_Quoted($theSite+"/"+aText1{$i})+"></TD></TR>"+"\r"
		Else 
			vText1:=vText1+"<TD></TD></TR>"+"\r"
		End if 
	End for 
	If ($doHtml=1)
		$theSite:=Storage:C1525.default.domain+$theSite+HFS_ShortName($fileFold)
		vText1:=vText1+"</TABLE>"
	End if 
	SET TEXT TO PASTEBOARD:C523(vText1)
End if 