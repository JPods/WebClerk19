//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 02/27/02
	//Who: Bill James, JIT
	//Description:
	VERSION_960
End if 

C_POINTER:C301($1)
//Method: Http_MetaParse
C_TEXT:C284($theText; $theTag)
C_TEXT:C284($vQuote)
$vQuote:=Char:C90(34)
C_LONGINT:C283($p; $pMeta)
ARRAY TEXT:C222(aText7; 0)
ARRAY TEXT:C222(aText8; 0)
ARRAY TEXT:C222(aText9; 0)
$theText:=$1->
//myDoc:=Open document("")
//If (OK=1)
//RECEIVE PACKET(myDoc;$theText;<>vEoF)
//CLOSE DOCUMENT(myDoc)

C_TEXT:C284(leadGraphic)
C_BOOLEAN:C305($doBegin; $doEnd)
C_TEXT:C284($leadGraphic)
C_LONGINT:C283($pBegin; $pEnd)
TRACE:C157
$begStr:="<!--nc_GraphicLead-->"
$endStr:="<!--/nc_GraphicLead-->"
$pBegin:=Position:C15($begStr; $theText)
$pEnd:=Position:C15($endStr; $theText)
If (($pBegin>0) & ($pEnd>0))
	$pBegin:=$pBegin+Length:C16($begStr)
	leadGraphic:=Substring:C12($theText; $pBegin; ($pEnd-$pBegin))
End if 
//
$p:=Position:C15("<Title"; $theText)
$pMeta:=Position:C15("</Title"; $theText)
//TRACE
If (($p>0) & ($pMeta>0))
	INSERT IN ARRAY:C227(aText7; 1; 1)
	INSERT IN ARRAY:C227(aText8; 1; 1)
	INSERT IN ARRAY:C227(aText9; 1; 1)
	aText7{1}:="PageTitle"
	aText8{1}:=Substring:C12($theText; $p+7; $pMeta-$p-7)
	If ([Item:4]description:7="http://@")
		[Item:4]description:7:=aText8{1}
	End if 
End if 

$p:=Position:C15("</head"; $theText)
If ($p>0)
	$theText:=Substring:C12($theText; 1; $p-1)
	$pMeta:=Position:C15("<META"; $theText)
	If ($pMeta>0)
		$theText:=Substring:C12($theText; $pMeta-1)
		Repeat 
			$theTag:=""
			$pMeta:=Position:C15("<META"; $theText)
			If ($pMeta>0)
				$theText:=Substring:C12($theText; $pMeta+4)
				$p:=Position:C15(">"; $theText)
				If ($p>0)
					$theTag:=Substring:C12($theText; 1; $p-1)
					$theText:=Substring:C12($theText; $p+1)
					$p:=Position:C15("Name="; $theTag)
					If ($p>0)
						INSERT IN ARRAY:C227(aText7; 1; 1)
						INSERT IN ARRAY:C227(aText8; 1; 1)
						INSERT IN ARRAY:C227(aText9; 1; 1)
						$theTag:=Substring:C12($theTag; $p+6)
						$p:=Position:C15($vQuote; $theTag)
						If ($p>0)
							aText7{1}:=Substring:C12($theTag; 1; $p-1)
						End if 
						$p:=Position:C15("Content="; $theTag)
						If ($p>0)
							$theTag:=Substring:C12($theTag; $p+9)
							$p:=Position:C15($vQuote; $theTag)
							If ($p>0)
								aText8{1}:=Substring:C12($theTag; 1; $p-1)
							End if 
						End if 
					End if 
				End if 
			End if 
		Until ($pMeta=0)
	End if 
End if 
//End if 
