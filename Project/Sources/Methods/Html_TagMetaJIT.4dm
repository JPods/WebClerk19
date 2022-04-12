//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Html_TagMetaJIT
	//Date: 07/01/02
	//Who: Bill
	//Description: Insert the jit Meta tags
End if 

C_TEXT:C284($1; $0)
C_TEXT:C284($thePage; $restPage)
C_LONGINT:C283($p; $lenMeta)
$thePage:=$1
vText9:=""
$doMeta:=False:C215
HTML_ParseBody("<!--jitReason: "; $thePage; ->vText9; "-->")

$p:=Position:C15("</Title>"; $thePage)
If ($p>0)
	$doMeta:=True:C214
	$lenMeta:=8
Else 
	$p:=Position:C15("<Head>"; $thePage)
	If ($p>0)
		$lenMeta:=6
		$doMeta:=True:C214
	End if 
End if 
C_TEXT:C284($newLine)
If (Is macOS:C1572)
	$newLine:="\r"
Else 
	$newLine:=Storage:C1525.char.crlf
End if 
C_LONGINT:C283($beenDone)
$beenDone:=Position:C15("jitFrom"; $thePage)
If ($beenDone=0)
	$restPage:=Substring:C12($thePage; $p+$lenMeta)
	$thePage:=Substring:C12($thePage; 1; $p+$lenMeta)+$newLine
	$p:=Position:C15("Name=jitReason"; $thePage)
	If ($p=0)
		$thePage:=$thePage+$newLine+"<META Name="+Txt_Quoted("jitReason")+" Content="+Txt_Quoted(vText9)+">"+$newLine
	End if 
	$p:=Position:C15("Name=jitSecure"; $thePage)
	If ($p=0)
		$thePage:=$thePage+"<META Name="+Txt_Quoted("jitSecure")+" Content="+Txt_Quoted("1")+">"+$newLine
	End if 
	$p:=Position:C15("Name=jitFrom"; $thePage)
	If ($p=0)
		$thePage:=$thePage+"<META Name="+Txt_Quoted("jitFrom")+" Content="+Txt_Quoted("")+">"+$newLine
	End if 
	$p:=Position:C15("Name=jitTo"; $thePage)
	If ($p=0)
		$thePage:=$thePage+"<META Name="+Txt_Quoted("jitTo")+" Content="+Txt_Quoted("")+">"+$newLine
	End if 
	$p:=Position:C15("Name=jitUser"; $thePage)
	If ($p=0)
		$thePage:=$thePage+"<META Name="+Txt_Quoted("jitUser")+" Content="+Txt_Quoted(String:C10(vleventID))+">"+$newLine
	End if 
	$p:=Position:C15("Link Rel"; $thePage)
	If ($p=0)
		$thePage:=$thePage+"<Link Rel="+Txt_Quoted("stylesheet")+" Type="+Txt_Quoted("text/css")+" href="+Txt_Quoted("/formats/defaults.css")+">"
	End if 
	$0:=$thePage+$restPage
Else 
	$0:=$thePage
End if 