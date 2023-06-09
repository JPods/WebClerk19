//=== === === === === === === === === === === === === === === === === === === === === 
// UI-with-Classes

Class constructor($dataClassName : Text; $method : Text)
	
	Super:C1705()  // look at formObject 
	
	This:C1470.name:=Current form name:C1298
	This:C1470.window:=Current form window:C827
	If ($dataClassName="")
		$dataClassName:="Customer"
	End if 
	This:C1470.dataClassName:=$dataClassName
	
	// need to build this
	This:C1470.role:=""
	// put here for now
	This:C1470.view:="default"
	Form:C1466.view:=This:C1470.view
	
	This:C1470.toBeInitialized:=True:C214
	
	This:C1470.callback:=Null:C1517
	This:C1470.worker:=Null:C1517
	
	This:C1470.isSubform:=False:C215
	
	//This.focused:=Null
	This:C1470.current:=Null:C1517
	
	This:C1470.widgets:=New object:C1471
	
	This:C1470.getFC()
	
	
	
	// Leave at the Form level for now
	//This.view:=""
	//This.fc:=New object()
	//This.setFC("default")
	
	
	
	If (Count parameters:C259>=1)
		
		This:C1470.setCallBack($method)
		
	End if 
	
	//MARK:-[FC]
	//=== === === === === === === === === === === === === === === === === === === === ===
	
Function getFC()
	If (Undefined:C82(This:C1470.fc.data.views))
		This:C1470._fixFCdata()
	End if 
	If (This:C1470.fc.data.views.default.list.lbName="LB_Selection")
		This:C1470.fc.data.views.default.list.lbName:="LB_DataBrowser"
		This:C1470.fc.save()
	End if 
	// Form.fc:=This.fc  // does nothing
	This:C1470.setViewtoForm()
	
	
	
Function setViewtoForm($view : Text; $data : Object)
	If ($view="")
		$view:=This:C1470.view
	End if 
	This:C1470.view:=$view
	var lb_o : Object
	If (lb_o=Null:C1517)
		lb_o:=New object:C1471
	End if 
	lb_o.columns:=This:C1470.fc.data.views[This:C1470.view].list.columns
	
	var $ptSubForm : Pointer
	OBJECT Get pointer:C1124(This:C1470.fc.data.views[This:C1470.view].list.lbName; $ptSubForm)
	// returns nil  why?
	
	//$ptSubForm->:=cs.listboxK.new(This.fc.data.views[This.view].list.lbName; This.dataClassName)
	LB_DataBrowser:=cs:C1710.listboxK.new(This:C1470.fc.data.views[This:C1470.view].list.lbName; This:C1470.dataClassName; This:C1470)
	
	
	If ($data=Null:C1517)
		//LB_DataBrowser.setSource(ds[Form.dataClassName].all())
		//Form[This.fc.data.views[This.view].list.lbName].setSource(ds[This.dataClassName].all())
		//$ptSubForm->setSource(ds[This.dataClassName].all())
		LB_DataBrowser.setSource(ds:C1482[This:C1470.dataClassName].all())
	Else 
		//LB_DataBrowser.setSource($data)
		//Form[This.fc.data.views[This.view].list.lbName].setSource($data)
		//$ptSubForm->setSource($data)
		LB_DataBrowser.setSource($data)
	End if 
	// $ptSubForm->.setColumns(lb_o.columns)
	LB_DataBrowser.setColumns(lb_o.columns)
	//Form[This.fc.data.views[This.view].list.lbName].setColumns(lb_o.columns)
	// use lo_columns so it can be edited without affecting the primary value of This.fc.data.views[This.view].list.columns)
	// for entry form
	//Form.fc.data.views[Form.view].entry.fields
	
	var $ptSF : Pointer
	OBJECT Get pointer:C1124(This:C1470.fc.data.views.default.entry.sfName; $ptSF)
	//$ptSF->:=cs.cEntry.new(This.dataClassName; This.name; This.fc.data.views.default.entry.sfName)  //"SF_cur")
	//$ptSF->setSubForm()  // space between fields
	SF_cur:=cs:C1710.cEntry.new(This:C1470.dataClassName; This:C1470.name; This:C1470.fc.data.views.default.entry.sfName)  //"SF_cur")
	SF_cur.setSubForm()  // space between fields
	
	
	
Function createFC()
	var $id : Text
	$id:=STR_FCNew(This:C1470.dataClassName; "DataBrowser")
	// it is not saving when passing out the object
	// get the entity
	ds:C1482.FC.new
	
Function setFC()
	
	
Function saveFC()
	
	
Function getListView()
	
	
Function getEntryView()
	
Function _fixFCdata()
	If (Undefined:C82(This:C1470.fc.data.views))
		If (Undefined:C82(This:C1470.fc.data))
			This:C1470.fc.data:=New object:C1471
		End if 
		This:C1470.fc.data.views:=New object:C1471
		This:C1470.fc.data.views.default:=New object:C1471("list"; New object:C1471(\
			"page"; New object:C1471; \
			"lbName"; "LB_DataBrowser"; \
			"lbValues"; New object:C1471; \
			"columns"; New collection:C1472; \
			"fields"; "id"))
		var $column_o : Object
		$column_o:=LBX_ColumnFromName(This:C1470.dataClassName; "id")
		This:C1470.fc.data.views.default.list.columns.push($column_o)
		This:C1470.fc.data.views.default.entry:=New object:C1471(\
			"fields"; "id"; \
			"sfName"; "SF_cur"; \
			"subform"; Null:C1517)
		This:C1470.fc.save()
	End if 
	
	
	
	//MARK:-[COMPUTED ATTRIBUTES]
Function get focused() : Text  /// The name of the object that has the focus in the form
	
	return (OBJECT Get name:C1087(Object with focus:K67:3))
	
	
	//MARK:-[FUNCTIONS]
	//=== === === === === === === === === === === === === === === === === === === === === 
Function init()
	
	ASSERT:C1129(False:C215; "👀 init() must be overriden by the subclass!")
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function onLoad()
	
	ASSERT:C1129(False:C215; "👀 onLoad() must be overriden by the subclass!")
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function saveContext()
	
	ASSERT:C1129(False:C215; "👀 saveContext() must overriden done by the subclass!")
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function restoreContext()
	
	ASSERT:C1129(False:C215; "👀 restore() must be overriden by the subclass!")
	
	//MARK:-[FORM OBJECTS CREATION]
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Create a static object instance
Function formObject($name : Text; $widgetName : Text) : cs:C1710.formObject
	
	If (Count parameters:C259>=2)
		
		This:C1470._instantiate("formObject"; $name; $widgetName)
		
	Else 
		
		This:C1470._instantiate("formObject"; $name)
		
	End if 
	
	return (This:C1470[$name])
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Create a button object instance
Function button($name : Text; $widgetName : Text) : cs:C1710.button
	
	If (Count parameters:C259>=2)
		
		This:C1470._instantiate("button"; $name; $widgetName)
		
	Else 
		
		This:C1470._instantiate("button"; $name)
		
	End if 
	
	return (This:C1470[$name])
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Create a widget object instance
Function widget($name : Text; $widgetName : Text) : cs:C1710.widget
	
	If (Count parameters:C259>=2)
		
		This:C1470._instantiate("widget"; $name; $widgetName)
		
	Else 
		
		This:C1470._instantiate("widget"; $name)
		
	End if 
	
	return (This:C1470[$name])
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Create a input object instance
Function input($name : Text; $widgetName : Text) : cs:C1710.input
	
	If (Count parameters:C259>=2)
		
		This:C1470._instantiate("input"; $name; $widgetName)
		
	Else 
		
		This:C1470._instantiate("input"; $name)
		
	End if 
	
	return (This:C1470[$name])
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Create a stepper object instance
Function stepper($name : Text; $widgetName : Text) : cs:C1710.stepper
	
	If (Count parameters:C259>=2)
		
		This:C1470._instantiate("stepper"; $name; $widgetName)
		
	Else 
		
		This:C1470._instantiate("stepper"; $name)
		
	End if 
	
	return (This:C1470[$name])
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Create a thermometer object instance
Function thermometer($name : Text; $widgetName : Text) : cs:C1710.thermometer
	
	If (Count parameters:C259>=2)
		
		This:C1470._instantiate("thermometer"; $name; $widgetName)
		
	Else 
		
		This:C1470._instantiate("thermometer"; $name)
		
	End if 
	
	return (This:C1470[$name])
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Create a listbox object instance
Function listbox($name : Text; $widgetName : Text) : cs:C1710.listbox
	
	If (Count parameters:C259>=2)
		
		This:C1470._instantiate("listbox"; $name; $widgetName)
		
	Else 
		
		This:C1470._instantiate("listbox"; $name)
		
	End if 
	
	return (This:C1470[$name])
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Create a picture object instance
Function picture($name : Text; $widgetName : Text) : cs:C1710.picture
	
	If (Count parameters:C259>=2)
		
		This:C1470._instantiate("picture"; $name; $widgetName)
		
	Else 
		
		This:C1470._instantiate("picture"; $name)
		
	End if 
	
	return (This:C1470[$name])
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Create a subform object instance
Function subform($name : Text; $widgetName : Text) : cs:C1710.subform
	
	If (Count parameters:C259>=2)
		
		This:C1470._instantiate("subform"; $name; $widgetName)
		
	Else 
		
		This:C1470._instantiate("subform"; $name)
		
	End if 
	
	return (This:C1470[$name])
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Create a selector object instance
Function selector($name : Text; $widgetName : Text) : cs:C1710.selector
	
	If (Count parameters:C259>=2)
		
		This:C1470._instantiate("selector"; $name; $widgetName)
		
	Else 
		
		This:C1470._instantiate("selector"; $name)
		
	End if 
	
	return (This:C1470[$name])
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Create a group instance
Function group($name : Text; $member; $member2; $memberN) : cs:C1710.group
	
	var ${2}
	var $i : Integer
	
	This:C1470[$name]:=cs:C1710.group.new()
	
	For ($i; 2; Count parameters:C259; 1)
		
		This:C1470[$name].addMember(${$i})
		
	End for 
	
	return (This:C1470[$name])
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// 🛠 IN WORKS
Function getWidgets()
	
	var $name : Text
	var $i; $type : Integer
	ARRAY TEXT:C222($objects; 0)
	
	FORM GET OBJECTS:C898($objects; Form all pages:K67:7)
	
	For ($i; 1; Size of array:C274($objects); 1)
		
		$name:=$objects{$i}
		$type:=OBJECT Get type:C1300(*; $name)
		
		Case of 
				//______________________________________________________
			: ($type=Object type push button:K79:16)\
				 | ($type=Object type radio button:K79:23)\
				 | ($type=Object type checkbox:K79:26)\
				 | ($type=Object type 3D button:K79:17)\
				 | ($type=Object type 3D checkbox:K79:27)\
				 | ($type=Object type 3D radio button:K79:24)\
				 | ($type=Object type picture button:K79:20)
				
				This:C1470._instantiate("button"; $name)
				
				//______________________________________________________
			: ($type=Object type static text:K79:2)\
				 | ($type=Object type static picture:K79:3)\
				 | ($type=Object type line:K79:33)\
				 | ($type=Object type rectangle:K79:32)\
				 | ($type=Object type rounded rectangle:K79:34)\
				 | ($type=Object type oval:K79:35)
				
				This:C1470._instantiate("static"; $name)
				
				//______________________________________________________
			: (False:C215)
				
				//______________________________________________________
			Else 
				
				// A "Case of" statement should never omit "Else"
				
				//______________________________________________________
		End case 
		
	End for 
	
	//MARK:-[WIDGETS]
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Add form event(s) for the current form
Function appendEvents($events)
	
	This:C1470._setEvents($events; Enable events others unchanged:K42:38)
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Remove form event(s) for the current form
Function removeEvents($events)
	
	This:C1470._setEvents($events; Disable events others unchanged:K42:39)
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Define the event(s) for the current form
Function setEvents($events)
	
	This:C1470._setEvents($events; Enable events disable others:K42:37)
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Set window title
Function setTitle($title : Text)
	
	SET WINDOW TITLE:C213($title; This:C1470.window)
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Defines the name of the callback method
Function setCallBack($method : Text)
	
	This:C1470.callback:=$method
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Start a timer to update the user interface
	// Default delay is ASAP
Function refresh($delay : Integer)
	
	If (Count parameters:C259>=1)
		
		SET TIMER:C645($delay)
		
	Else 
		
		SET TIMER:C645(-1)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Creates a CALL FORM of the current form (callback) & with current callback method
	// .callMeBack ()
	// .callMeBack ( param : Collection )
	// .callMeBack ( param1, param2, …, paramN )
Function callMeBack($param; $param1; $paramN)
	
	C_VARIANT:C1683(${1})
	
	var $code : Text
	var $i : Integer
	var $parameters : Collection
	
	If (Length:C16(String:C10(This:C1470.callback))#0)
		
		If (Count parameters:C259=0)
			
			CALL FORM:C1391(This:C1470.window; This:C1470.callback)
			
		Else 
			
			$code:="CALL FORM:C1391("+String:C10(This:C1470.window)+"; \""+This:C1470.callback+"\""
			
			If (Value type:C1509($1)=Is collection:K8:32)
				
				$parameters:=$1
				
				For ($i; 0; $parameters.length-1; 1)
					
					$code:=$code+"; $1["+String:C10($i)+"]"
					
				End for 
				
			Else 
				
				$parameters:=New collection:C1472
				
				For ($i; 1; Count parameters:C259; 1)
					
					$parameters.push(${$i})
					
					$code:=$code+"; $1["+String:C10($i-1)+"]"
					
				End for 
			End if 
			
			$code:=$code+")"
			
			Formula from string:C1601($code).call(Null:C1517; $parameters)
			
		End if 
		
	Else 
		
		ASSERT:C1129(False:C215; "Callback method is not defined.")
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Creates a CALL FORM of the current form (callback) with the passed method
	// .callMe ( method : Text )
	// .callMe ( method : Text ; param : Collection )
	// .callMe ( method : Text ; param1, param2, …, paramN )
Function callMe($method : Text; $param1; $paramN)
	
	C_VARIANT:C1683(${2})
	
	var $code : Text
	var $i : Integer
	var $parameters : Collection
	
	If (Count parameters:C259=1)
		
		CALL FORM:C1391(This:C1470.window; $method)
		
	Else 
		
		$code:="CALL FORM:C1391("+String:C10(This:C1470.window)+"; \""+$method+"\""
		
		If (Value type:C1509($2)=Is collection:K8:32)
			
			$parameters:=$2
			
			For ($i; 0; $parameters.length-1; 1)
				
				$code:=$code+"; $1["+String:C10($i)+"]"
				
			End for 
			
		Else 
			
			$parameters:=New collection:C1472
			
			For ($i; 2; Count parameters:C259; 1)
				
				$parameters.push(${$i})
				$code:=$code+"; $1["+String:C10($i-2)+"]"
				
			End for 
		End if 
		
		$code:=$code+")"
		
		Formula from string:C1601($code).call(Null:C1517; $parameters)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Associate a worker to the current form
Function setWorker($worker)
	
	var $type : Integer
	$type:=Value type:C1509($worker)
	
	If (Asserted:C1132(($type=Is text:K8:3) | ($type=Is real:K8:4) | ($type=Is longint:K8:6); "Wrong parameter type"))
		
		This:C1470.worker:=$worker
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Assigns a task to the associated worker
	// .callWorker ( method : Text )
	// .callWorker ( method : Text ; param : Collection )
	// .callWorker ( method : Text ; param1, param2, …, paramN )
	// ---------------------------------------------------------------------------------
	//#TO_DO : Accept an integer as first parameter to allow calling a specific worker.
	// .callWorker ( process : Integer ; method : Text )
	// .callWorker ( process : Integer ; method : Text ; param : Collection )
	// .callWorker ( process : Integer ; method : Text ; param1, param2, …, paramN )
	// ---------------------------------------------------------------------------------
Function callWorker($method; $param; $param1; $paramN)
	
	C_VARIANT:C1683(${2})
	
	var $code : Text
	var $i : Integer
	var $parameters : Collection
	
	If (This:C1470.worker#Null:C1517)
		
		If (Count parameters:C259=1)
			
			If (Asserted:C1132(This:C1470.worker#Null:C1517; "No associated worker"))
				
				CALL WORKER:C1389(This:C1470.worker; $method)
				
			End if 
			
		Else 
			
			$code:="CALL WORKER:C1389(\""+This:C1470.worker+"\"; \""+$method+"\""
			
			If (Value type:C1509($2)=Is collection:K8:32)
				
				$parameters:=$2
				
				For ($i; 0; $parameters.length-1; 1)
					
					$code:=$code+"; $1["+String:C10($i)+"]"
					
				End for 
				
			Else 
				
				$parameters:=New collection:C1472
				
				For ($i; 2; Count parameters:C259; 1)
					
					$parameters.push(${$i})
					$code:=$code+"; $1["+String:C10($i-2)+"]"
					
				End for 
			End if 
			
			$code:=$code+")"
			
			Formula from string:C1601($code).call(Null:C1517; $parameters)
			
		End if 
		
	Else 
		
		ASSERT:C1129(False:C215; "Worker is not is not defined.")
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Executes a project method in the context of a subform (without returned value)
	// .executeInSubform ( subform : Object | Text ; method : Text )
	// .executeInSubform ( subform : Object | Text ; method : Text ; param : Collection )
	// .executeInSubform ( subform : Object | Text ; method : Text ; param1, param2, …, paramN )
Function callChild($subform; $method : Text; $param; $param1; $paramN)
	
	C_VARIANT:C1683(${3})
	
	var $code; $target : Text
	var $i : Integer
	var $parameters : Collection
	
	If (Value type:C1509($subform)=Is object:K8:27)
		
		// We assume it's a subform object
		ASSERT:C1129($subform.name#Null:C1517)
		$target:=$subform.name
		
	Else 
		
		$target:=String:C10($subform)
		
	End if 
	
	ARRAY TEXT:C222($widgets; 0)
	FORM GET OBJECTS:C898($widgets; Form all pages:K67:7)
	
	If (Find in array:C230($widgets; $target)>0)
		
		If (Count parameters:C259=2)
			
			EXECUTE METHOD IN SUBFORM:C1085($target; $method)
			
		Else 
			
			$code:="EXECUTE METHOD IN SUBFORM:C1085(\""+$target+"\"; \""+$method+"\";*"
			
			If (Value type:C1509($3)=Is collection:K8:32)
				
				$parameters:=$3
				
				For ($i; 0; $parameters.length-1; 1)
					
					$code:=$code+"; $1["+String:C10($i)+"]"
					
				End for 
				
			Else 
				
				$parameters:=New collection:C1472
				
				For ($i; 3; Count parameters:C259; 1)
					
					$parameters.push(${$i})
					
					$code:=$code+"; $1["+String:C10($i-3)+"]"
					
				End for 
			End if 
			
			$code:=$code+")"
			
			Formula from string:C1601($code).call(Null:C1517; $parameters)
			
		End if 
		
	Else 
		
		ASSERT:C1129(Structure file:C489=Structure file:C489(*); "Subform not found: "+$target)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function spreadToChilds($param : Object)
	
	Ui_form_spreadToSubforms($param)
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Send an event to the subform container
Function callParent($event : Integer)
	
	If (Asserted:C1132(This:C1470.isSubform; "🛑 Only applicable for sub-forms!"))
		
		CALL SUBFORM CONTAINER:C1086($event)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function dimensions() : Object
	
	var $height; $width : Integer
	
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($width; $height)
	
	return (New object:C1471(\
		"width"; $width; \
		"height"; $height))
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function height() : Integer
	
	return (This:C1470.dimensions().height)
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function width() : Integer
	
	return (This:C1470.dimensions().width)
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function goToPage($page : Integer; $subform : Boolean)
	
	var $_subform : Boolean
	
	If (Count parameters:C259>=2)
		
		// User's request
		$_subform:=$subform
		
	Else 
		
		$_subform:=This:C1470.isSubform
		
	End if 
	
	If ($_subform)
		
		// Change page of current subform
		FORM GOTO PAGE:C247($page; *)
		
	Else 
		
		FORM GOTO PAGE:C247($page)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function page($subform : Boolean) : Integer
	
	var $_subform : Boolean
	
	If (Count parameters:C259>=1)
		
		// User's request
		$_subform:=$subform
		
	Else 
		
		$_subform:=This:C1470.isSubform
		
	End if 
	
	If ($_subform)
		
		// Current subform page
		return (FORM Get current page:C276(*))
		
	Else 
		
		return (FORM Get current page:C276)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// ⚠️ No optional parameter to allow the distinction between form and subform
Function firstPage()
	
	FORM FIRST PAGE:C250
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// ⚠️ No optional parameter to allow the distinction between form and subform
Function lastPage()
	
	FORM LAST PAGE:C251
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// ⚠️ No optional parameter to allow the distinction between form and subform
Function nextPage()
	
	FORM NEXT PAGE:C248
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// ⚠️ No optional parameter to allow the distinction between form and subform
Function previousPage()
	
	FORM PREVIOUS PAGE:C249
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Gives the focus to a widget in the current form
Function goTo($widget : Text)
	
	// TODO: allow a cs.widget
	
	GOTO OBJECT:C206(*; $widget)
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Remove any focus in the current form
Function removeFocus()
	
	GOTO OBJECT:C206(*; "")
	//=== === === === === === === === === === === === === === === === === === === === === 
Function postKeyDown($keyCode : Integer; $modifier : Integer)
	
	If (Count parameters:C259>=2)
		
		POST EVENT:C467(Key down event:K17:4; $keyCode; Tickcount:C458; 0; 0; $modifier; Current process:C322)
		
	Else 
		
		POST EVENT:C467(Key down event:K17:4; $keyCode; Tickcount:C458; 0; 0; 0; Current process:C322)
		
	End if 
	
	//MARK:-[CURSOR]
	//=== === === === === === === === === === === === === === === === === === === === === 
Function setCursor($cursor : Integer)
	
	If (Count parameters:C259>=1)
		
		SET CURSOR:C469($cursor)
		
	Else 
		
		SET CURSOR:C469
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function releaseCursor()
	
	SET CURSOR:C469
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function setCursorNotAllowed($display : Boolean)
	
	If (Count parameters:C259=0 ? True:C214 : $display)
		
		SET CURSOR:C469(9019)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function setCursorDragCopy($display : Boolean)
	
	If (Count parameters:C259=0 ? True:C214 : $display)
		
		SET CURSOR:C469(9016)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function setCursorArrow($display : Boolean)
	
	If (Count parameters:C259=0 ? True:C214 : $display)
		
		SET CURSOR:C469(1303)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function setCursorText($display : Boolean)
	
	If (Count parameters:C259=0 ? True:C214 : $display)
		
		SET CURSOR:C469(256)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function setCursorCrosshair($display : Boolean)
	
	If (Count parameters:C259=0 ? True:C214 : $display)
		
		SET CURSOR:C469(1382)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function setCursorWatch($display : Boolean)
	
	If (Count parameters:C259=0 ? True:C214 : $display)
		
		SET CURSOR:C469(260)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
Function setCursorPointingHand($display : Boolean)
	
	If (Count parameters:C259=0 ? True:C214 : $display)
		
		SET CURSOR:C469(9000)
		
	End if 
	
	
	//MARK:-[PRIVATE]
	//=== === === === === === === === === === === === === === === === === === === === === 
	//Function _cursor($id : Integer; $diplay : Boolean)
	//If (Count parameters=0)
	//SET CURSOR
	//Else 
	//If (Count parameters<2 ? True : $display)
	//SET CURSOR($id)
	//End if 
	//End if
	
Function _instantiate($class : Text; $key : Text; $name : Text)
	
	If (Asserted:C1132(Count parameters:C259>=1; "Missing parameter"))
		
		Case of 
				
				//______________________________________________________
			: (Count parameters:C259=3)
				
				This:C1470[$key]:=cs:C1710[$class].new($name)
				
				//______________________________________________________
			: (Count parameters:C259=2)  // Use key as the widget name
				
				This:C1470[$key]:=cs:C1710[$class].new($key)
				
				//______________________________________________________
			: (Count parameters:C259=1)  // A tool init
				
				This:C1470[$class]:=cs:C1710[$class].new()
				
				//______________________________________________________
		End case 
	End if 
	
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// [PRIVATE] set form events
Function _setEvents($events; $mode : Integer)
	
	ARRAY LONGINT:C221($codes; 0)
	
	Case of 
			
			//______________________________________________________
		: (Value type:C1509($events)=Is collection:K8:32)
			
			COLLECTION TO ARRAY:C1562($events; $codes)
			
			//______________________________________________________
		: (Value type:C1509($events)=Is integer:K8:5)\
			 | (Value type:C1509($events)=Is longint:K8:6)\
			 | (Value type:C1509($events)=Is real:K8:4)
			
			ARRAY LONGINT:C221($codes; 1)
			APPEND TO ARRAY:C911($codes; $events)
			
			//______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215; "The event parameter must be an number or a collection")
			
			//______________________________________________________
	End case 
	
	OBJECT SET EVENTS:C1239(*; ""; $codes; $mode)
	
	