
// Modified by: Bill James (2022-11-19T06:00:00Z)
// Method: DataBrowser.pu_viewsList
// Description 
// Parameters
// ----------------------------------------------------



Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (aViewsList{aViewsList}="New")
				$view:=Request:C163("Name of view")
				If ((OK=1) & ($view#""))
					//TODO: new view
					
				End if 
			: (aViewsList{aViewsList}="From Empty")
				Form:C1466.LB_Selection_s.setFromEmpty()
				LB_DataBrowser.setFromEmpty()
				
			: (aViewsList{aViewsList}="Delete")
				// delete view from data
				CONFIRM:C162("Delete view "+Form:C1466.view+"?")
				If (OK=1)
					CONFIRM:C162("Really? Delete view "+Form:C1466.view+"?")
					If (OK=1)
						
						
						//LB_DataBrowser.sel.drop()
						//LB_DataBrowser.ents:=ds[Form.dataClassName].all()
					End if 
				End if 
				
			: (aViewsList{aViewsList}="--@")
				// do nothing, return to selected view
			: (aViewsList{aViewsList}="Save")
				
				
			: (aViewsList{aViewsList}="Array to Entry")
				//Form.SF_cur:=cs.cEntry.new(Form.dataClassName; "DataBrowser"; "SF_cur")
				If (Form:C1466.LB_Show.ents.length>0)
					//Form.SF_cur:=cs.cEntry.new(Form.dataClassName; "DataBrowser"; Form.entry.sfName)  //"SF_cur")
					Form:C1466.entry.fields:=""
					var $line_o : Object
					For each ($line_o; Form:C1466.LB_Show.ents)
						Form:C1466.entry.fields:=Form:C1466.entry.fields+$line_o.fieldName+","
					End for each 
					Form:C1466.entry.fields:=Substring:C12(Form:C1466.entry.fields; 1; Length:C16(Form:C1466.entry.fields)-1)
					var $options_o : Object
					$options_o:=New object:C1471("entry"; New object:C1471("fields"; Form:C1466.entry.fields); "top"; 10)
					SF_cur.setSubForm($options_o)  // space between fields
				End if 
				
			: (aViewsList{aViewsList}="Text to Entry")
				var $options_o : Object
				$options_o:=New object:C1471("entry"; New object:C1471("fields"; Form:C1466.entry.fields); "top"; 10)
				SF_cur.setSubForm($options_o)  // space between fields
				
			: (aViewsList{aViewsList}="Array to List")
				//Form.LB_Selection_s.setFromArray()
				LB_DataBrowser.setFromArray()
				
			: (aViewsList{aViewsList}="Text to List")
				LB_DataBrowser.setColumnsString(thisForm.fc.data.views[thisForm.view].fields)
				
			: (aViewsList>1)
				// LBX_DataBrowserSetTable(Form.dataClassName; aViewsList{aViewsList}; LB_DataBrowser.ents)
				thisForm.setFCtoForm(aViewsList{aViewsList})
		End case 
	: (Form event code:C388=On Load:K2:1)
		
End case 

