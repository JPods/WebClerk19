C_LONGINT:C283(bContacts)
C_TEXT:C284($script)
$script:="QUERY([Discussion];[Discussion]UniqueIDForeign="+String:C10([TechNote:58]idUnique:1)+";*)"+<>vCR
$script:=$script+"QUERY([Discussion]; & [Discussion]TableNum="+String:C10(Table:C252(->[TechNote:58]))+")"
ProcessTableOpen(Table:C252(->[Discussion:139]); $script; "TechNotes: "+[TechNote:58]Name:2)