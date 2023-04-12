
// Modified by: Bill James (2022-11-19T06:00:00Z)
// Method: DataBrowser.pu_viewsEntry
// Description 
// Parameters
// ----------------------------------------------------


Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (aViewsEntry>0)
			Case of 
				: (aViewsEntry{aViewsEntry}="From list")
					SF_cur._buildEntryFromList()
					
				: (aViewsEntry{aViewsEntry}="List from string")
					SF_cur._buildListFromString()
					
				: (aViewsEntry{aViewsEntry}="From string")
					SF_cur._buildFromString()
					
				: (aViewsEntry{aViewsEntry}="New")
					$view:=Request:C163("Name of view")
					If ((OK=1) & ($view#""))
						//TODO: new view
						
					End if 
				: (aViewsEntry{aViewsEntry}="From Empty")
					
					Form:C1466[Form:C1466.list.lbName].setFromEmpty()
					
				: (aViewsEntry{aViewsEntry}="Delete")
					// delete view from data
					CONFIRM:C162("Delete view "+SF_cur.view+"?")
					If (OK=1)
						CONFIRM:C162("Really? Delete view "+SF_cur.view+"?")
						If (OK=1)
							
							
							//LB_DataBrowser.sel.drop()
							//LB_DataBrowser.ents:=ds[Form.dataClassName].all()
						End if 
					End if 
					
				: (aViewsEntry{aViewsEntry}="--@")
					// do nothing, return to selected view
				: (aViewsEntry{aViewsEntry}="Save")
					
					
				: (aViewsEntry{aViewsEntry}="Array to Entry")
					//Form.SF_cur:=cs.cEntry.new(Form.dataClassName; "DataBrowser"; "SF_cur")
					If (Form:C1466.LB_Show.ents.length>0)
						//Form.SF_cur:=cs.cEntry.new(Form.dataClassName; "DataBrowser"; Form.entry.sfName)  //"SF_cur")
						SF_cur.fc.data.views[SF_cur.view].fields:=""
						var $line_o : Object
						For each ($line_o; Form:C1466.LB_Show.ents)
							SF_cur.fc.data.views[SF_cur.view].fields:=\
								SF_cur.fc.data.views[SF_cur.view].fields+\
								$line_o.fieldName+","
						End for each 
						SF_cur.fc.data.views[SF_cur.view].fields:=\
							Substring:C12(SF_cur.fc.data.views[SF_cur.view].fields; 1; \
							Length:C16(SF_cur.fc.data.views[SF_cur.view].fields)-1)
						var $options_o : Object
						$options_o:=New object:C1471("entry"; New object:C1471("fields"; \
							SF_cur.fc.data.views[SF_cur.view].fields); "top"; 10)
						SF_cur._setSubForm($options_o)  // space between fields
					End if 
					
				: (aViewsEntry{aViewsEntry}="Text to Entry")
					var $options_o : Object
					$options_o:=New object:C1471("entry"; New object:C1471("fields"; \
						SF_cur.fc.data.views[SF_cur.view].fields); "top"; 10)
					SF_cur._setSubForm($options_o)  // space between fields
					
				: (aViewsEntry>1)
					SF_cur.view:=aViewsEntry{aViewsEntry}
					SF_cur._setSubForm()  // space between fields
					SF_cur._makeEntryChoices()
					
			End case 
		End if 
	: (Form event code:C388=On Load:K2:1)
		
End case 

