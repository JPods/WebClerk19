//%attributes = {}
//get the conversion log
$fDoc:=Open document:C264(""; ".json"; Get pathname:K24:6)
If (OK=1)
	$tProjectSources:=File:C1566(DOCUMENT; fk platform path:K87:2).parent.parent.platformPath+Convert path POSIX to system:C1107("Project/Sources/")
	$tButtons:=File:C1566(DOCUMENT; fk platform path:K87:2).parent.parent.platformPath+Convert path POSIX to system:C1107("Resources/Buttons/")
	//check each message in the log for an error
	$jLog:=JSON Parse:C1218(Document to text:C1236(DOCUMENT))
	For each ($jMessage; $jLog.messages)
		If ($jMessage.severity="error")
			Case of 
				: ($jMessage.message="'Background offset'@")
					If ($jMessage.form#"(@)")  //exclude forms that were in trash
						//determine the path to the form and parse it
						If (OB Is defined:C1231($jMessage; "table"))
							$tFolderPath:=$tProjectSources+Convert path POSIX to system:C1107("TableForms/"+String:C10($jMessage.table)+"/"+$jMessage.form+"/")
						Else 
							$tFolderPath:=$tProjectSources+Convert path POSIX to system:C1107("Forms/"+$jMessage.form+"/")
						End if 
						$tFormPath:=$tFolderPath+"form.4DForm"
						$jForm:=JSON Parse:C1218(Document to text:C1236($tFormPath))
						//find the object referenced by the message in the form
						$bFound:=False:C215  //use to break from the for each
						For each ($jPage; $jForm.pages)\
							 Until ($bFound)
							If ($jPage#Null:C1517)
								For each ($tObject; $jPage.objects)\
									 Until ($bFound)
									If ($tObject=$jMessage.object)
										$bFound:=True:C214
										
										//set the button attributes
										$tIcon:="bevel_button_"+String:C10($jPage.objects[$tObject].width)+"x"+String:C10($jPage.objects[$tObject].height)+".svg"
										$jPage.objects[$tObject].style:="custom"
										$jPage.objects[$tObject].icon:="/RESOURCES/Buttons/"+$tIcon
										$jPage.objects[$tObject].iconFrames:=4
										$jPage.objects[$tObject].textPlacement:="center"
										
										//create the bevel button if it doesn't exist
										If (Not:C34(File:C1566($tButtons+$tIcon; fk platform path:K87:2).exists))
											//TEXT TO DOCUMENT($tButtons+$tIcon; bevel_button_create($jPage.objects[$tObject].width; $jPage.objects[$tObject].height))
										End if 
									End if 
								End for each 
							End if 
						End for each 
						
						//write it back
						TEXT TO DOCUMENT:C1237($tFormPath; JSON Stringify:C1217($jForm))
					End if 
					
			End case 
		End if 
	End for each 
End if 