/*  webArea ()
	 Created by: Kirk as Designer, Created: 12/21/20, 14:49:29
	 ------------------
	On the Form: 
	instantiate in context of a form containing the web area:
	     Form.grid_WA:=cs.webArea.new("grid_wa")

	The open_template() function is useful when working with html templates
	All params are passed in the $params object

*/

Class constructor($name : Text)
	If (Count parameters:C259>0)
		This:C1470.name:=String:C10($name)  //  the name of the web area
		This:C1470.url:=""
		
		//  prefs
		This:C1470.prefs:=New object:C1471
		This:C1470.prefs.contextualMenu:=True:C214
		This:C1470.prefs.inspector:=True:C214
		This:C1470.prefs.javaApplets:=False:C215
		This:C1470.prefs.javaScript:=True:C214
		This:C1470.prefs.plugins:=False:C215
		This:C1470.prefs.urlDrop:=False:C215
		This:C1470.setPref()
		
		This:C1470.urlFiltering:=False:C215
		This:C1470.fliters:=New collection:C1472()
	End if 
	
Function setPref($pref : Text; $flag : Boolean)
/* sets the pref to true|false */
	If (Count parameters:C259=2)
		This:C1470[$pref]:=$flag
	End if 
	
	WA SET PREFERENCE:C1041(*; This:C1470.name; WA enable contextual menu:K62:6; This:C1470.prefs.contextualMenu)
	//WA SET PREFERENCE(*; This.name; WA enable Java applets; This.prefs.javaApplets)
	//WA SET PREFERENCE(*; This.name; WA enable JavaScript; This.prefs.javaScript)
	//WA SET PREFERENCE(*; This.name; WA enable plugins; This.prefs.plugins)
	WA SET PREFERENCE:C1041(*; This:C1470.name; WA enable URL drop:K62:8; This:C1470.prefs.urlDrop)
	WA SET PREFERENCE:C1041(*; This:C1470.name; WA enable Web inspector:K62:7; This:C1470.prefs.inspector)
	
Function set_url_filtering($flag : Boolean)
	If (Count parameters:C259>0)
		This:C1470.urlFiltering:=$flag
		
		ARRAY LONGINT:C221($aEvents; 1)
		$aEvents{1}:=On URL Filtering:K2:49
		
		If ($flag)
			OBJECT SET EVENTS:C1239(*; This:C1470.name; $aEvents; Enable events others unchanged:K42:38)
		Else 
			OBJECT SET EVENTS:C1239(*; This:C1470.name; $aEvents; Disable events others unchanged:K42:39)
		End if 
		
	End if 
	
Function set_url_filters
/*  $1 is collection: [{ filter: ""; allow: bool }, ... ]
		enables URL filtering
	*/
	var $1 : Collection
	var $o : Object
	ARRAY TEXT:C222($filters; 0)
	ARRAY BOOLEAN:C223($AllowDeny; 0)
	
	If (Count parameters:C259>0)
		This:C1470.filters:=$1
		This:C1470.set_url_filtering(True:C214)
		
		For each ($o; This:C1470.filters)
			APPEND TO ARRAY:C911($filters; $o.filter)
			APPEND TO ARRAY:C911($AllowDeny; $o.allow)
		End for each 
		
		WA SET URL FILTERS:C1030(This:C1470.name; $filters; $AllowDeny)
	End if 
	
	// --------------------------------------------------------
Function set_url($params : Object)
/*  */
	
	If (Count parameters:C259=1)
		Case of 
			: (String:C10($params.url)#"")
				This:C1470.url:=$params.url
				
			: (Value type:C1509($params.file)=Is object:K8:27)
				This:C1470.url:="File:///"+$params.file.path
				
			: (Value type:C1509($params.file)=Is text:K8:3)
				This:C1470.url:=$params.file
				
		End case 
		
		WA OPEN URL:C1020(*; This:C1470.name; This:C1470.url)
		
	End if 
	
Function open_template($params : Object)
/*  
		template: text|object    //  template to open
		  either 4D File object or system path to file
		head:   pointer or text for <head>
		body:   pointer or text for <body>
		footer: pointer or text for <footer>
			
		target: optional; system path to file | file object
		name:   name for the target template file
			
		target and name are optional. 
		Without either one the file will be 'temp.html'
		if target is specified the setText() is used
		if name is specified the template will be written to the wa_html folder with that name
			
		--------------
		1) get the template file object
		2) PROCESS TAGS on it if $1 or $2 
		3) put file at target
		     default target is wa_html/  next to RESOURCES
		4) open the file in the WA
	*/
	var $template_o; $htmlFile_o : Object
	var $html_text; $temp_t; $head_t; $body_t; $footer_t : Text
	
	If (Count parameters:C259>0)
		If (Value type:C1509($params.template)=Is object:K8:27)
			$template_o:=$params.template
		Else 
			$template_o:=File:C1566($params.template; fk platform path:K87:2)
		End if 
		
		If ($template_o.exists)
			
			$head_t:=This:C1470._get_params_text("head"; $params)
			$body_t:=This:C1470._get_params_text("body"; $params)
			$footer_t:=This:C1470._get_params_text("footer"; $params)
			
			// --------------------------------------------------------
			// get the html_text
			$temp_t:=$template_o.getText()
			
			PROCESS 4D TAGS:C816($temp_t; $html_text; $body_t; $head_t; $footer_t)
			
			// --------------------------------------------------------
			//   the destination file
			
			// UpdateWithResources by: Bill James (2023-01-03T06:00:00Z)
			// Fix and use FC records
			
			Case of 
				: (Value type:C1509($params.target)=Is object:K8:27)
					$htmlFile_o:=$params.target
					
				: (Value type:C1509($params.target)=Is text:K8:3)
					$htmlFile_o:=File:C1566(This:C1470._get_default_wa_folder().path+$params.target; fk posix path:K87:1)
					
				Else   //  default
					$htmlFile_o:=File:C1566(This:C1470._get_default_wa_folder().path+"temp.html"; fk posix path:K87:1)
					
			End case 
			
			$htmlFile_o.setText($html_text)
			This:C1470.set_url(New object:C1471("file"; $htmlFile_o))
			
		Else 
			ALERT:C41("The HTML template can't be found.")
		End if 
		
	End if 
	
Function _get_params_text($key : Text; $params : Object)
/* extracts and returns as text data from $params */
	var $0; $key : Text
	
	Case of 
		: (Count parameters:C259#2)
		: ($key="")
		: (Value type:C1509($params[$key])=Is undefined:K8:13)
			
		: (Value type:C1509($params[$key])=Is pointer:K8:14)
			$0:=String:C10($params[$key]->)
			
		: (Value type:C1509($params[$key])=Is text:K8:3)
			$0:=$params[$key]
			
		: (Value type:C1509($params[$key])=Is object:K8:27) | (Value type:C1509($params[$key])=Is collection:K8:32)
			$0:=JSON Stringify:C1217($params[$key])
			
		Else 
			$0:=String:C10($params[$key])
			
	End case 
	
	// --------------------------------------------------------
Function _get_default_wa_folder
	// folder object for the wa_html folder
	// by default it is on the same level as RESOURCES
	var $0 : Object
	$0:=Folder:C1567(Folder:C1567(Folder:C1567(fk resources folder:K87:11).platformPath; fk platform path:K87:2).parent.path+"wa_html/")
	
Function _get_css_folder
	var $0 : Object
	$0:=Folder:C1567(fk resources folder:K87:11).folder("css")
	