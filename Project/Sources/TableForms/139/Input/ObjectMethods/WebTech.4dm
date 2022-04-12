
// ### bj ### 20181123_1735
// these should be the only active actions
// no internal rendering engine works on mac but not on pcs

Case of 
	: (Form event code:C388=On End URL Loading:K2:47)
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(WebTech; "setContent"; *; tinyMCE_cleanCR(tinyMCE_Content_t))
	: (Form event code:C388=On Load:K2:1)
		
		
		If (False:C215)  // iLo Change records
			C_TEXT:C284($wa_htmlEditor_path_t)
			$wa_htmlEditor_path_t:=Get 4D folder:C485(Current resources folder:K5:16)+"tinymce"+Folder separator:K24:12+"htmleditor.html"
			$wa_htmlEditor_path_t:=Convert path system to POSIX:C1106($wa_htmlEditor_path_t)
			WA OPEN URL:C1020(WebTech; "file:///"+$wa_htmlEditor_path_t)
		End if 
End case 
