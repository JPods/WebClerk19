//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/18/21, 22:58:09
// ----------------------------------------------------
// Method: Fix_Images2
// Description
// 
//
// Parameters
// ----------------------------------------------------

// https://github.com/miyako/4d-component-generate-icon
// https://github.com/4D-JP/code-audit/blob/master/fix_push_button_with_color.txt
// https://github.com/miyako/4d-widget-custom-picture-button
// https://discuss.4d.com/t/project-mode-conversion-highlight-buttons/14919/11
// 

$resourcesFolderPath:=Get 4D folder:C485(Current resources folder:K5:16; *)
$imagesFolderDefaultName:="Images"
$imagesFolderSuffix:=0
$imagesFolderName:=$imagesFolderDefaultName
$imagesFolderPath:=""
Repeat 
	$imagesFolderPath:=$resourcesFolderPath+$imagesFolderName+Folder separator:K24:12
	$pathType:=Test path name:C476($imagesFolderPath)
	Case of 
		: ($pathType=Is a folder:K24:2)
			ARRAY TEXT:C222($folders; 0)
			FOLDER LIST:C473($imagesFolderPath; $folders)
			If (Size of array:C274($folders)#0)
				$imagesFolderPath:=""
				//continue
			Else 
				ARRAY TEXT:C222($files; 0)
				DOCUMENT LIST:C474($imagesFolderPath; $files)
				If (Size of array:C274($files)#0)
					$imagesFolderPath:=""
					//continue
				End if 
			End if 
		: ($pathType=Is a document:K24:1)
			$imagesFolderPath:=""
			//continue
		: ($pathType=-43)
			//break
	End case 
	If ($imagesFolderPath="")
		$imagesFolderSuffix:=$imagesFolderSuffix+1
		$imagesFolderName:=$imagesFolderDefaultName+" "+String:C10($imagesFolderSuffix)
	End if 
Until ($imagesFolderPath#"")
CREATE FOLDER:C475($imagesFolderPath; *)

$template:=""
If (True:C214)
	$svg:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg"; "xmlns:xlink"; "http://www.w3.org/1999/xlink")
	DOM SET XML ATTRIBUTE:C866($svg; "version"; "1.1"; "width"; "$4DTEXT($1.strokeWidth+$1.width)"; "height"; "$4DTEXT(($1.strokeWidth*4)+($1.height*4))")
	$defs:=DOM Create XML element:C865($svg; "defs"; "id"; "defs")
	$filter:=DOM Create XML element:C865($defs; "filter"; "id"; "filter-disabled")
	$feColorMatrix:=DOM Create XML element:C865($filter; "feColorMatrix"; \
		"type"; "matrix"; "values"; \
		".299 .587 .114 0 0 "+\
		".299 .587 .114 0 0 "+\
		".299 .587 .114 0 0 "+\
		".000 .000 .000 1 .000")
	$filter:=DOM Create XML element:C865($defs; "filter"; "id"; "filter-hover")
	$feColorMatrix:=DOM Create XML element:C865($filter; "feColorMatrix"; \
		"type"; "matrix"; "values"; \
		".888 0 0 0 0 0 "+\
		".888 0 0 0 0 0 "+\
		".888 0 0 0 0 0 "+\
		"1 .000")
	$filter:=DOM Create XML element:C865($defs; "filter"; "id"; "filter-clicked")
	$feColorMatrix:=DOM Create XML element:C865($filter; "feColorMatrix"; \
		"type"; "matrix"; "values"; \
		".777 0 0 0 0 0 "+\
		".777 0 0 0 0 0 "+\
		".777 0 0 0 0 0 "+\
		"1 .000")
	$rect:=DOM Create XML element:C865($defs; "rect"; "id"; "rect"; \
		"width"; "$4DTEXT($1.width)"; "height"; "$4DTEXT($1.height)"; \
		"fill"; "$4DTEXT($1.fill)"; \
		"stroke"; "$4DTEXT($1.stroke)"; "stroke-width"; "$4DTEXT($1.strokeWidth)"; \
		"rx"; "$4DTEXT($1.rx)"; "ry"; "$4DTEXT($1.ry)")
	$rect:=DOM Create XML element:C865($svg; "use"; "href"; "#rect"; \
		"x"; "$4DTEXT($1.strokeWidth/2)"; "y"; "$4DTEXT($1.strokeWidth/2)")
	$rect:=DOM Create XML element:C865($svg; "use"; "href"; "#rect"; \
		"filter"; "url(#filter-clicked)"; \
		"x"; "$4DTEXT($1.strokeWidth/2)"; "y"; "$4DTEXT(($1.strokeWidth*1.5)+($1.height))")
	$rect:=DOM Create XML element:C865($svg; "use"; "href"; "#rect"; \
		"filter"; "url(#filter-hover)"; \
		"x"; "$4DTEXT($1.strokeWidth/2)"; "y"; "$4DTEXT(($1.strokeWidth*2.5)+($1.height*2))")
	$rect:=DOM Create XML element:C865($svg; "use"; "href"; "#rect"; \
		"filter"; "url(#filter-disabled)"; \
		"x"; "$4DTEXT($1.strokeWidth/2)"; "y"; "$4DTEXT(($1.strokeWidth*3.5)+($1.height*3))")
	DOM EXPORT TO VAR:C863($svg; $template)
	DOM CLOSE XML:C722($svg)
End if 

$signature:="  // code added by "+Current method name:C684+"\r"
If (True:C214)
	ARRAY TEXT:C222($formNames; 0)
	For ($t; 0; Get last table number:C254)
		If (Is table number valid:C999($t)) | ($t=0)
			If ($t#0)
				FORM GET NAMES:C1167(Table:C252($t)->; $formNames; *)
			Else 
				FORM GET NAMES:C1167($formNames; *)
			End if 
			For ($f; 1; Size of array:C274($formNames))
				$formName:=$formNames{$f}
				If ($t#0)
					FORM LOAD:C1103(Table:C252($t)->; $formName; *)
					$methodPath:=METHOD Get path:C1164(Path table form:K72:5; Table:C252($t)->; $formName; *)
				Else 
					FORM LOAD:C1103($formName; *)
					$methodPath:=METHOD Get path:C1164(Path project form:K72:3; $formName; *)
				End if 
				FORM GET OBJECTS:C898($objectNames; *)
				$code:=""
				
				METHOD GET CODE:C1190($methodPath; $code; Code with tokens:K72:18; *)
				
				$addCode:=(0=Position:C15($signature; $code; *))
				$codeSnippet:=""
				If ($addCode)
					$codeSnippet:=$signature
					$codeSnippet:=$codeSnippet+"If (Form event:C388=On Load:K2:1)\r"
				End if 
				For ($o; 1; Size of array:C274($objectNames))
					$objectName:=$objectNames{$o}
					$objectType:=OBJECT Get type:C1300(*; $objectName)
					Case of 
						: ($objectType=Object type push button:K79:16)
							C_LONGINT:C283($strokeColor; $fillColor; $left; $top; $right; $bottom)
							OBJECT GET RGB COLORS:C1074(*; $objectName; $strokeColor; $fillColor)
							OBJECT GET COORDINATES:C663(*; $objectName; $left; $top; $right; $bottom)
							$x:=$left
							$y:=$top
							$width:=$right-$left
							$height:=$bottom-$top
							$fill:="000000"+Substring:C12(String:C10($fillColor; "&x"); 3)
							$fill:="#"+Substring:C12($fill; Length:C16($fill)-5)
							$stroke:="000000"+Substring:C12(String:C10($strokeColor; "&x"); 3)
							$stroke:="#"+Substring:C12($stroke; Length:C16($stroke)-5)
							$params:=New object:C1471("width"; $width; \
								"height"; $height; \
								"fill"; $fill; "stroke"; $stroke; \
								"strokeWidth"; 2; "rx"; 5; "ry"; 5)
							PROCESS 4D TAGS:C816($template; $svg; $params)
							If ($t=0)
								$tableName:="{projectForm}"
							Else 
								$tableName:=Table name:C256($t)
							End if 
							$path:=$imagesFolderPath+$tableName+Folder separator:K24:12+$objectName+".svg"
							CREATE FOLDER:C475($imagesFolderPath+$tableName+Folder separator:K24:12; *)
							TEXT TO DOCUMENT:C1237($path; $svg; "utf-8"; Document with CRLF:K24:20)
							If ($addCode)
								$format:=OBJECT Get format:C894(*; $objectName)
								$format:="\""+$format+";#;#"+$imagesFolderName+"/"+$tableName+"/"+$objectName+".svg;;1;0;4;;;;;;1"+"\""
								$codeSnippet:=$codeSnippet+"OBJECT SET FORMAT:C236(*;\""+$objectName+"\";"+$format+")\r"
							End if 
					End case 
				End for 
				If ($addCode)
					$codeSnippet:=$code+"\r"+$codeSnippet+"End if\r"
					
					METHOD SET CODE:C1194($methodPath; $codeSnippet; *)
					
				End if 
				FORM UNLOAD:C1299
			End for 
		End if 
	End for 
End if 
