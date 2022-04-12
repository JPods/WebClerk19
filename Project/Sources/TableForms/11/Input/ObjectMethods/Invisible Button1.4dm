C_TEXT:C284($script)
$script:="QUERY([CarrierWeight];[CarrierWeight]UniqueIDCarrier="+String:C10([Carrier:11]idNum:44)+")"
DB_ShowCurrentSelection(->[CarrierWeight:144]; $script; 22; [Carrier:11]carrierid:10; 2)