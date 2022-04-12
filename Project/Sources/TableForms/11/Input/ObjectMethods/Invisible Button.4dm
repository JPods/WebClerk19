C_TEXT:C284($script)
$script:="QUERY([CarrierZone];[CarrierZone]UniqueIDCarrier="+String:C10([Carrier:11]idNum:44)+")"
DB_ShowCurrentSelection(->[CarrierZone:143]; $script; 22; [Carrier:11]carrierid:10; 2)