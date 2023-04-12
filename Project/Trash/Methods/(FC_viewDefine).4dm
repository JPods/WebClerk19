//%attributes = {}

// Modified by: Bill James (2022-09-02T05:00:00Z)
// Method: FC_viewDefine
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($view : Text)->$view_o : Object
If (Size of array:C274(aViews)=0)
	
	Case of 
		: (($action="") | ($action="default"))
			
			$fc_rework.data.views.default.list.fields:=$fieldList
			$fc_rework.data.views.default.list.lbName:="LB_Selection"
			$fc_rework.data.views.default.list.columns:=$columns_c
			$fc_rework.data.views.default.list.sfName:=""
			$fc_rework.data.views.default.list.subform:=Null:C1517
			
			$fc_rework.data.views.default.entry.fields:=$fieldList
			$fc_rework.data.views.default.entry.sfName:="SF_cur"
			$fc_rework.data.views.default.entry.subform:=Null:C1517
			
			
			var $viewName : Text
			$viewName:=Request:C163("Name this view.")
			If (($viewName#"") & (Find in array:C230(aViews; $viewName)<1))
				$view_o
				$fc_rework.data.views.default.list.fields:=$fieldList
				$fc_rework.data.views.default.list.lbName:="LB_Selection"
				$fc_rework.data.views.default.list.columns:=$columns_c
				$fc_rework.data.views.default.list.sfName:=""
				$fc_rework.data.views.default.list.subform:=Null:C1517
				
				$fc_rework.data.views.default.entry.fields:=$fieldList
				$fc_rework.data.views.default.entry.sfName:="SF_cur"
				$fc_rework.data.views.default.entry.subform:=Null:C1517
				
				
				var $viewName : Text
				$viewName:=Request:C163("Name this view.")
				If (($viewName#"") & (Find in array:C230(aViews; $viewName)<1))
					$view_o
					$fc_rework.data.views.default.list.fields:=$fieldList
					$fc_rework.data.views.default.list.lbName:="LB_Selection"
					$fc_rework.data.views.default.list.columns:=$columns_c
					$fc_rework.data.views.default.list.sfName:=""
					$fc_rework.data.views.default.list.subform:=Null:C1517
					
					$fc_rework.data.views.default.entry.fields:=$fieldList
					$fc_rework.data.views.default.entry.sfName:="SF_cur"
					$fc_rework.data.views.default.entry.subform:=Null:C1517
					
				End if 
			End if 
			