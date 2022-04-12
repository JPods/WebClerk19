//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($settings;$settingsSel;$status)

$settingsSel:=ds:C1482.DEFAULT_SETTINGS.all()
If ($settingsSel.length<1)
	$settings:=ds:C1482.DEFAULT_SETTINGS.new()
	Settings_Preset ($settings)
	$status:=$settings.save()  //No need to check the success, for it's a new entity
Else 
	$settings:=$settingsSel.first()
	If ($settings.smtp=Null:C1517)
		Settings_Preset ($settings)
		$status:=$settings.save()
	End if 
End if 

$0:=$settings

