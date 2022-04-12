//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/01/20, 23:10:39
// ----------------------------------------------------
// Method: WccMimeTypeReturn
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $2; $3; $0; $vtWorking)
C_LONGINT:C283($strLength)
C_OBJECT:C1216(<>voMimes)
If (Count parameters:C259>0)
	$vtWorking:=$1
Else 
	$vtWorking:="Path.JPG"
	// testing
End if 
$0:="text/html"
Case of 
	: ($vtWorking="buildMime@")
		
		OB SET:C1220(<>voMimes; "au"; "audio/basic")
		OB SET:C1220(<>voMimes; "class"; "application")
		OB SET:C1220(<>voMimes; "css"; "text/css")
		OB SET:C1220(<>voMimes; "doc"; "application/msword")
		OB SET:C1220(<>voMimes; "gif"; "image/gif")
		OB SET:C1220(<>voMimes; "hqx"; "application/mac-binhex40")
		OB SET:C1220(<>voMimes; "htm"; "text/html; charset=utf-8")
		OB SET:C1220(<>voMimes; "html"; "text/html; charset=utf-8")
		OB SET:C1220(<>voMimes; "jpeg"; "image/jpeg")
		OB SET:C1220(<>voMimes; "jpg"; "image/jpeg")
		OB SET:C1220(<>voMimes; "js"; "application/javascript")
		OB SET:C1220(<>voMimes; "json"; "application/json")
		OB SET:C1220(<>voMimes; "mid"; "audio/midi")
		OB SET:C1220(<>voMimes; "midi"; "audio/midi")
		OB SET:C1220(<>voMimes; "moov"; "video/quicktime")
		OB SET:C1220(<>voMimes; "mov"; "video/quicktime")
		OB SET:C1220(<>voMimes; "mp3"; "audio/mpeg")
		OB SET:C1220(<>voMimes; "mp4"; "video/quicktime")
		OB SET:C1220(<>voMimes; "pdf"; "application/pdf")
		OB SET:C1220(<>voMimes; "pict"; "image/pict")
		OB SET:C1220(<>voMimes; "pjpg"; "image/jpeg")
		OB SET:C1220(<>voMimes; "png"; "image/png")
		OB SET:C1220(<>voMimes; "ppt"; "application/vnd.ms-powerpoint")
		OB SET:C1220(<>voMimes; "shtm"; "text/html; charset=utf-8")
		OB SET:C1220(<>voMimes; "shtml"; "text/html; charset=utf-8")
		OB SET:C1220(<>voMimes; "sit"; "application/x-stuffit")
		OB SET:C1220(<>voMimes; "svg"; "image/svg+xml")
		OB SET:C1220(<>voMimes; "svgz"; "image/svg+xml")
		OB SET:C1220(<>voMimes; "swf"; "application/x-shockwave-flash")
		OB SET:C1220(<>voMimes; "text"; "text/plain")
		OB SET:C1220(<>voMimes; "txt"; "text/plain")
		OB SET:C1220(<>voMimes; "wav"; "audio/wav")
		OB SET:C1220(<>voMimes; "wc"; "text/html; charset=utf-8")
		OB SET:C1220(<>voMimes; "xls"; "application/vnd.ms-excel")
		OB SET:C1220(<>voMimes; "xml"; "text/xml")
		OB SET:C1220(<>voMimes; "zip"; "application/zip")
		
		
	: ($vtWorking="appendMime@")
		If ((Count parameters:C259>2) & ($2#"") & ($3#""))
			//If (OB Is defined(<>voMimes;$2))  
			// do not know if it need to be checked and replaced
			$2:=Lowercase:C14($2)
			OB SET:C1220(<>voMimes; $2; $3)
		End if 
	Else 
		C_TEXT:C284($vtSuffix; $vtMime)
		$vtWorking:=$vtWorking
		$vtSuffix:=SuffixGet($vtWorking)
		$vtSuffix:=Lowercase:C14($vtSuffix)
		If (OB Is defined:C1231(<>voMimes; $vtSuffix))
			$vtMime:=OB Get:C1224(<>voMimes; $vtSuffix)
			$0:=$vtMime
		End if 
End case 
